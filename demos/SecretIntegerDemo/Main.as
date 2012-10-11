package  
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.easyas3.obfuscation.SecretInteger;
	
	/**
	 * ... 整数内存混淆Demo ...
	 * @author Jerry
	 */
	public class Main extends Sprite 
	{
		public var normal_txt:TextField;
		
		public var special_txt:TextField;
		
		public var refresh_btn:SimpleButton;
		
		public var normalInt:int = 123456;
		
		public var specialInt:SecretInteger = new SecretInteger(123456);
		
		/**
		 * 构造函数
		 */
		public function Main() 
		{
			update();
			refresh_btn.addEventListener(MouseEvent.CLICK, refreshBtnClickHandler);
		}
		
		private function refreshBtnClickHandler(e:MouseEvent):void 
		{
			update();
		}
		
		private function update():void 
		{
			normal_txt.embedFonts = false;
			special_txt.embedFonts = false;
			normal_txt.text = normalInt.toString();
			special_txt.text = specialInt.value.toString();
		}
	}

}