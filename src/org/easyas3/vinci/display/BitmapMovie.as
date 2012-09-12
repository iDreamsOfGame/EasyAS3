/**
 * Copyright @2009-2012 www.easyas3.org, all rights reserved.
 * Create date: 2012-9-12 
 * Jerry Li
 * 李振宇
 * cosmos53076@163.com
 */

package org.easyas3.vinci.display
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.easyas3.pool.IPoolObject;
	
	/**
	 * 位图动画
	 * @author Jerry
	 */
	public class BitmapMovie extends Sprite implements IPoolObject
	{
		/**
		 * 自定义数据
		 */
		protected var _data:Object;
		
		/**
		 * 位图显示对象
		 */
		protected var _bmp:Bitmap;
		
		/**
		 * 指定播放头在动画序列中的帧索引
		 */
		protected var _currentIndex:int;
		
		/**
		 * 动画序列中帧索引的最大值
		 */
		protected var _maxIndex:int;
		
		/**
		 * 动画是否在播放中
		 */
		protected var _isPlaying:Boolean;
		
		/**
		 * 位图动画帧信息序列
		 */
		protected var _frames:Vector.<BitmapFrameInfo>;
		
		/**
		 * 对象使用中标识
		 */
		protected var _using:Boolean;
		
		/**
		 * 构造函数
		 * @param	frames:Vector.<BitmapFrameInfo> (default = null) — 位图动画帧信息序列
		 */
		public function BitmapMovie(frames:Vector.<BitmapFrameInfo> = null)
		{
			super();
			
			_bmp = new Bitmap();
			initialize();
			this.frames = frames;
			
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}
		
		/**
		 * 自定义数据
		 */
		public function get data():Object 
		{
			return _data;
		}
		
		/**
		 * 自定义数据
		 */
		public function set data(value:Object):void 
		{
			_data = value;
		}
		
		/**
		 * 位图动画帧信息序列
		 */
		public function get frames():Vector.<BitmapFrameInfo> 
		{
			return _frames;
		}
		
		/**
		 * 位图动画帧信息序列
		 */
		public function set frames(value:Vector.<BitmapFrameInfo>):void 
		{
			_frames = value;
			_bmp.bitmapData = null;
			
			if (_frames == null)
			{
				_currentIndex = 0;
				_maxIndex = 0;
			}
			else
			{
				_maxIndex = _frames.length - 1;
				gotoFrameIndex(_currentIndex);
			}
			
			updatePlayStatus();
		}
		
		/**
		 * 指定播放头在动画序列中所处的帧编号
		 */
		public function get currentFrame():int 
		{
			//用户指定的帧数从1开始，Vector索引从0开始，所以加上1
			return _currentIndex + 1;
		}
		
		/**
		 * 动画序列中帧的总数
		 */
		public function get totalFrames():int 
		{
			return _frames?(_maxIndex + 1):0;
		}
		
		/**
		 * 位图是否启用平滑处理
		 */
		public function get smoothing():Boolean 
		{
			return _bmp?_bmp.smoothing:false;
		}
		
		/**
		 * 位图是否启用平滑处理
		 */
		public function set smoothing(value:Boolean):void 
		{
			if (_bmp != null)
			{
				_bmp.smoothing = value;
			}
		}
		
		/**
		 * 动画是否在播放中
		 */
		public function get isPlaying():Boolean 
		{
			return _isPlaying;
		}
		
		/**
		 * 当前位图帧信息
		 */
		public function get currentBitmapFrameInfo():BitmapFrameInfo
		{
			return _frames?_frames[_currentIndex]:null;
		}
		
		/**
		 * 对象使用中标识
		 */
		public function get using():Boolean 
		{
			return _using;
		}
		
		/**
		 * 对象使用中标识
		 */
		public function set using(value:Boolean):void 
		{
			_using = value;
		}
		
		/**
		 * 播放动画
		 */
		public function play():void 
		{
			_isPlaying = true;
			updatePlayStatus();
		}
		
		/**
		 * 停止播放动画
		 */
		public function stop():void 
		{
			_isPlaying = false;
			updatePlayStatus();
		}
		
		/**
		 * 从指定帧开始播放动画
		 * @param	frame:int — 帧数
		 */
		public function gotoAndPlay(frame:int):void 
		{
			gotoFrame(frame)
			play();
		}
		
		/**
		 * 将播放头移到动画指定帧并停在那里
		 * @param	frame:int — 帧数
		 */
		public function gotoAndStop(frame:int):void 
		{
			gotoFrame(frame);
			stop();
		}
		
		/**
		 * 跳转到指定的帧
		 * @param	frame:int — 帧数
		 */
		public function gotoFrame(frame:int):void 
		{
			//用户指定的帧数从1开始，Vector索引从0开始，所以减去1
			gotoFrameIndex(frame - 1);
		}
		
		/**
		 * 将播放头转到下一帧并停止
		 */
		public function nextFrame():void 
		{
			if (_currentIndex == _maxIndex)
			{
				gotoFrameIndex(0);
			}
			else
			{
				gotoFrameIndex(_currentIndex + 1);
			}
		}
		
		/**
		 * 克隆对象
		 * @return
		 */
		public function clone():IPoolObject
		{
			return new BitmapMovie(_frames);
		}
		
		/**
		 * 重置对象属性
		 */
		public function reset():void 
		{
			initialize();
		}
		
		/**
		 * 销毁对象
		 */
		public function dispose():void 
		{
			stop();
			
			_frames = null;
			
			if (contains(_bmp))
			{
				removeChild(_bmp);
			}
			
			//移出事件监听
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
			
			//有帧事件监听的话就清除帧事件监听
			if (hasEventListener(Event.ENTER_FRAME))
			{
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		
		/**
		 * 初始化
		 */
		protected function initialize():void 
		{
			x = 0;
			y = 0;
			alpha = 1;
			rotation = 0;
			visible = true;
			scaleX = 1;
			scaleY = 1;
			
			addChild(_bmp);
			
			_currentIndex = 0;
			_maxIndex = 0;
			
			play();
		}
		
		/**
		 * 跳转到指定索引的帧
		 * @param	index:int — 帧索引
		 */
		protected function gotoFrameIndex(index:int):void 
		{
			var bmpFrameInfo:BitmapFrameInfo;
			
			_currentIndex = index;
			
			//边界值检查
			if (_currentIndex > _maxIndex)
			{
				_currentIndex = _maxIndex;
			}
			else if (_currentIndex < 0)
			{
				_currentIndex = 0;
			}
			
			//显示指定帧索引的位图
			bmpFrameInfo = _frames[_currentIndex];
			_bmp.bitmapData = bmpFrameInfo.bitmapData;
			_bmp.x = bmpFrameInfo.x;
			_bmp.y = bmpFrameInfo.y;
		}
		
		/**
		 * 更新动画播放状态
		 */
		protected function updatePlayStatus():void 
		{
			if (_isPlaying && _maxIndex != 0 && stage != null)
			{
				//播放状态时添加帧事件监听
				addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
			else
			{
				//停止状态时移除帧事件监听
				if (hasEventListener(Event.ENTER_FRAME))
				{
					removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				}
			}
		}
		
		/**
		 * 帧事件监听
		 * @private
		 * @param	e:Event — 事件对象
		 */
		private function enterFrameHandler(e:Event):void 
		{
			nextFrame();
		}
		
		/**
		 * 添加到舞台事件监听
		 * @private
		 * @param	e:Event — 事件对象
		 */
		private function addedHandler(e:Event):void 
		{
			updatePlayStatus();
		}
		
		/**
		 * 移出舞台事件监听
		 * @private
		 * @param	e:Event — 事件对象
		 */
		private function removedHandler(e:Event):void 
		{
			updatePlayStatus();
		}
	}
}