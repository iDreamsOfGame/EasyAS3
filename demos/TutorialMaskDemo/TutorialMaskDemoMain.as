package
{
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.easyas3.components.TutorialMask;
	import org.easyas3.components.TutorialMaskHoleShape;
	
	/**
	 * ... 新手指导遮罩类演示 ...
	 * @author Jerry
	 */
	public class TutorialMaskDemoMain extends Sprite
	{
		public var startButton:Button;
		
		public var container:MovieClip;
		
		public var mc2:MovieClip;
		
		/**
		 * 构造函数
		 */
		public function TutorialMaskDemoMain()
		{
			super();
			container.mc.visible = false;
			container.mc.buttonMode = true;
			mc2.visible = false;
			mc2.buttonMode = true;
			container.mc.addEventListener(MouseEvent.CLICK, mcClickHandler);
			mc2.addEventListener(MouseEvent.CLICK, mc2ClickHandler);
			startButton.addEventListener(MouseEvent.CLICK, startButtonClickHandler);
		}
		
		private function mc2ClickHandler(e:MouseEvent):void
		{
			var tf:TextField = new TextField();
			tf.text = "mc2";
			mc2.addChild(tf);
		}
		
		private function mcClickHandler(e:MouseEvent):void
		{
			var tf:TextField = new TextField();
			tf.text = "container.mc";
			container.mc.addChild(tf);
		}
		
		private function startButtonClickHandler(e:MouseEvent):void
		{
			container.mc.visible = true;
			mc2.visible = true;
			
			var tutorialMask:TutorialMask = new TutorialMask();
			
			//只显示container.mc
			tutorialMask.maskHoleEllipseWidth = 10;
			tutorialMask.maskHoleEllipseHeight = 10;
			//tutorialMask.show(0, 0, stage.stageWidth, stage.stageHeight, container.mc, 0, TutorialMaskHoleShape.ROUND_RECTANGLE);
			//只显示mc2
			tutorialMask.show(0, 0, stage.stageWidth, stage.stageHeight, mc2, 0, TutorialMaskHoleShape.CIRCLE);
			addChild(tutorialMask);
		}
	}

}