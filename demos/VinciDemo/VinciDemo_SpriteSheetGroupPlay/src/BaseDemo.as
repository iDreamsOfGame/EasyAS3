package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	
	import org.easyas3.vinci.VinciContext;
	
	/**
	 * ...
	 * @author ｋａｋａ
	 * 演示类基类
	 */
	public class BaseDemo extends Sprite
	{
		
		/**
		 * 显示对象主容器
		 */
		protected var container:Sprite;
		
		/**
		 * 显示对象二维数组
		 */
		protected var arr_item:Array;
		
		private var nowX:Number;
		private var nowY:Number;
		
		private var timer:Timer;
		
		public function BaseDemo():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//初始化二维数组
			arr_item = new Array(DemoConfig.Row);
			var row:int = 0;
			while (row < DemoConfig.Row)
			{
				arr_item[row] = new Array(DemoConfig.Column);
				row++;
			}
			
			container = new Sprite();
			addChild(container);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
			
			timer = new Timer(0,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, initItems);
			timer.start();
			
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			//initItems();
		}
		
		protected function addedHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			initialize();
		}
		
		protected function initialize():void
		{
			VinciContext.stage = stage;
		}
		
		protected var curRow:int = 0;
		private function initItems(evt:TimerEvent):void
		{
			while(curRow < DemoConfig.Row)
			{
				
				var column:int = 0;
				while (column < DemoConfig.Column)
				{
					initItem(curRow, column);
					column++;
				}
				
				curRow++;
				
			}
			
			updateContainer(true);
			
			//stage.quality = StageQuality.LOW;
		}
		
		/**
		 * 生成一个显示对象
		 * @param	row			当前行
		 * @param	column		当前列
		 */
		protected function initItem(row:int, column:int):void
		{
			///被子类覆写
		}
		
		/**
		 * 拖动容器时触发
		 * @param	strRow			开始行数
		 * @param	endRow			结束行数
		 * @param	strColumn		开始列数
		 * @param	endColumn		结束列数
		 */
		protected function containerMove(strRow:int, endRow:int, strColumn:int, endColumn:int):void
		{
			
		}
		
		private var lastRow:int;
		private var lastColumn:int;
		
		/**
		 * 更新容器显示
		 * @param	forceUpdate		是否强制更新
		 */
		private function updateContainer(forceUpdate:Boolean = false):void
		{
			var strRow:int = -(container.y / DemoConfig.RowSpace);
			var endRow:int = strRow + Math.ceil(DemoConfig.stageHeight / DemoConfig.RowSpace) + 1;
			//trace("strRow, endRow",strRow, endRow);
			if (endRow < 0)
			{
				endRow = 0;
			}
			else
			if (endRow > curRow)
			{
				endRow = curRow;
			}
			
			if (strRow < 0) 
			{
				strRow = 0;
			}
			else
			if (strRow > endRow)
			{
				strRow = endRow;
			}
			//trace("now strRow,endRow", strRow, endRow);
			var strColumn:int = -(container.x / DemoConfig.ColumnSpace);
			var endColumn:int = strColumn + Math.ceil(DemoConfig.stageWidth / DemoConfig.ColumnSpace) - 1;
			
			if (endColumn < 0)
			{
				endColumn = 0;
			}
			else
			if (endColumn > DemoConfig.Column)
			{
				endColumn = DemoConfig.Column;
			}
			
			if (strColumn < 0)
			{
				strColumn = 0;
			}
			else
			if (strColumn > endColumn)
			{
				strColumn = endColumn;
			}
			
			if (!forceUpdate)
			{
				if (lastRow == strRow && lastColumn == strColumn) return;
			}
			
			containerMove(strRow, endRow, strColumn, endColumn);
			
			lastRow = strRow;
			lastColumn = strColumn;
		}
		
		/**
		 * 清空容器
		 */
		protected function clearContainer():void
		{
			while (container.numChildren > 0)
			{
				container.removeChildAt(0);
			}
		}
		
		/**
		 * 随机获取一个显示对象
		 * @return
		 */
		protected function getRandItem():MovieClip
		{
			var mc:MovieClip = getItem(Math.random() * DemoConfig.ItemTypeNumber ^ 0);
			//mc.stop();
			return mc;
		}
		
		/**
		 * 根据类型获取一个显示对象
		 * @return
		 */
		protected function getItem(type:int):MovieClip
		{
			//var mcCls:Class = getDefinitionByName(DemoConfig.ItemLinkPrefix +type) as Class;
			//var mc:MovieClip = (new mcCls()) as MovieClip;
			var mcCls:Class = getDefinitionByName(DemoConfig.ItemLinkPrefix +type) as Class;
			var mc:MovieClip = (new mcCls()) as MovieClip;
			return mc;
		}
		
		public static const mcClses:Array = [item_0];
		
		/**
		 * 开始拖动
		 * @param	evt
		 */
		protected function stageMouseDownHandler(evt:MouseEvent):void
		{
			nowX = stage.mouseX;
			nowY = stage.mouseY;
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
		}
		
		/**
		 * 停止拖动
		 * @param	evt
		 */
		protected function stageMouseUpHandler(evt:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
		}
		
		/**
		 * 拖动
		 * @param	evt
		 */
		protected function stageMouseMoveHandler(evt:MouseEvent):void
		{
			var nx:Number = stage.mouseX;
			var ny:Number = stage.mouseY;
			
			container.x += nx - nowX;
			container.y += ny - nowY;
			
			nowX = nx;
			nowY = ny;
			
			
			updateContainer();
		}
		
	}

}