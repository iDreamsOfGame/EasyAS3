/*
* Copyright @2009-2012 www.easyas3.org, all rights reserved.
* Create date: 2012-9-18 
* Jerry Li
* 李振宇
* cosmos53076@163.com
*/

package org.easyas3.vinci.display
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import org.easyas3.display.pixel.PixelInteractiveSprite;
	import org.easyas3.pool.IPoolObject;
	import org.easyas3.vinci.IRenderer;
	import org.easyas3.vinci.VinciContext;
	import org.easyas3.vinci.VinciRenderManager;
	
	/**
	 * 位图动画基类
	 * @author Jerry 
	 */	
	public class BitmapMovie extends PixelInteractiveSprite implements IPoolObject, IRenderer
	{
		/**
		 * 位图动画帧信息序列
		 */
		protected var _frames:Vector.<BitmapFrame>;
		
		/**
		 * 自定义数据
		 */
		protected var _data:Object;
		
		/**
		 * 指定播放头在动画序列中的帧索引
		 */
		protected var _currentIndex:int;
		
		/**
		 * 动画序列中帧索引的最大值
		 */
		protected var _maxIndex:int;
		
		/**
		 * 位图对象
		 */
		protected var _bitmap:Bitmap;
		
		/**
		 * 动画是否在播放中
		 */
		protected var _isPlaying:Boolean;
		
		/**
		 * 对象使用中标识
		 */
		protected var _using:Boolean;
		
		/**
		 * 帧速率
		 */
		protected var _frameRate:Number;
		
		/**
		 * 中心点位置
		 */
		protected var _centerPointPosition:String;
		
		/**
		 * 渲染管理器
		 * @private
		 */
		private var _renderManager:VinciRenderManager;
		
		/**
		 * 构造函数
		 * @param	frames:Vector.<BitmapFrameInfo> (default = null) — 位图动画帧信息序列
		 * @param	frameRate:Number (default = NaN) — 帧速率
		 * @param	centerPointPosition:String (default = "center") — 位图动画中心点位置
		 */	
		public function BitmapMovie(frames:Vector.<BitmapFrame> = null, frameRate:Number = NaN, centerPointPosition:String = "center")
		{
			super();
			
			_frameRate = frameRate;
			_centerPointPosition = centerPointPosition;
			_bitmap = new Bitmap();
			initialize();
			this.frames = frames;
			
			//判断是否独立渲染
			if (frameRate)
			{
				_renderManager = new VinciRenderManager(this);
			}
			else
			{
				//添加到渲染队列
				context.addBitmapMovie(this);
			}
		}
		
		/**
		 * 位图动画帧信息序列
		 */
		public function get frames():Vector.<BitmapFrame> 
		{
			return _frames;
		}
		
		/**
		 * 位图动画帧信息序列
		 */
		public function set frames(value:Vector.<BitmapFrame>):void 
		{
			_frames = value;
			_bitmap.bitmapData = null;
			
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
		 * 当前位图帧信息
		 */
		public function get currentBitmapFrameInfo():BitmapFrame
		{
			return _frames?_frames[_currentIndex]:null;
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
		 * 位图对象
		 */
		public function get bitmap():Bitmap 
		{
			return _bitmap;
		}
		
		/**
		 * 位图是否启用平滑处理
		 */
		public function get smoothing():Boolean 
		{
			return _bitmap?_bitmap.smoothing:false;
		}
		
		/**
		 * 位图是否启用平滑处理
		 */
		public function set smoothing(value:Boolean):void 
		{
			if (_bitmap != null)
			{
				_bitmap.smoothing = value;
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
		 * 标识对象是否从对象池中取出并正在使用
		 */
		public function get using():Boolean 
		{
			return _using;
		}
		
		/**
		 * 标识对象是否从对象池中取出并正在使用
		 */
		public function set using(value:Boolean):void 
		{
			_using = value;
		}
		
		/**
		 * 帧频
		 */
		public function get frameRate():Number 
		{
			return _frameRate;
		}
		
		/**
		 * 渲染引擎控制器
		 */
		protected function get context():VinciContext
		{
			return VinciContext.getInstance();
		}
		
		/**
		 * 播放动画
		 */
		public function play():void 
		{
			_isPlaying = true;
		}
		
		/**
		 * 停止播放动画
		 */
		public function stop():void 
		{
			_isPlaying = false;
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
		 * 跳转到指定索引的帧
		 * @param	index:int — 帧索引
		 */
		public function gotoFrameIndex(index:int):void 
		{
			var bmpCenterPos:Point;
			var bmpFrameInfo:BitmapFrame;
			
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
			_bitmap.bitmapData = bmpFrameInfo.bitmapData;
			_bitmap.x = bmpFrameInfo.x;
			_bitmap.y = bmpFrameInfo.y;
			
			//根据中心点坐标计算坐标
			bmpCenterPos = BitmapMovieCenterPointPosition[_centerPointPosition](_bitmap.bitmapData.width, _bitmap.bitmapData.height);
			_bitmap.x += bmpCenterPos.x;
			_bitmap.y += bmpCenterPos.y;
		}
		
		/**
		 * 渲染
		 */
		public function render():void 
		{
			if (_isPlaying && _maxIndex != 0 && stage != null)
			{
				nextFrame();
			}
		}
		
		/**
		 * 克隆对象
		 * @return IPoolObject — 对象池接口对象
		 */
		public function clone():IPoolObject
		{
			return new BitmapMovie(_frames, _frameRate, _centerPointPosition);
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
			
			//渲染管理器销毁
			if (_renderManager)
			{
				_renderManager.dispose();
				_renderManager = null;
			}
			
			//从渲染控制器里移除自身
			context.removeBitmapMovie(this);
			
			//移除Bitmap对象
			if (contains(_bitmap))
			{
				removeChild(_bitmap);
			}
			
			_frames = null;
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
			
			addChild(_bitmap);
			
			_currentIndex = 0;
			_maxIndex = 0;
			
			play();
		}
	}
}