package activity 
{
	
	import starling.display.Image;
    import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author vovik
	 */
	public class SignIn_step3 extends SignIn
	{
		public static const OK:String = "ok";
		public static const BACK:String = "back3";
		
		public function SignIn_step3() 
		{
			// кнопка назад
			AddBack(BACK);
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest("http://in-syst.ru/SMForm.php"));
			urlLoader.addEventListener(Event.COMPLETE, function():void {
				var str:String = urlLoader.data as String;
				addText2(str);
				button1.enabled = true;
			});
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function():void {
				addText2("Connection Error");
				addChild(button2);
			});
			var button1:Button = new Button(Root.assets.getTexture("button_ok0000"), "OK");
			button1.fontSize = 24;
            button1.x = int((Constants.STAGE_WIDTH - button1.width) / 2);
            button1.y = 332;
            button1.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				dispatchEventWith(OK, true);
			});
			button1.enabled = false;
			addChild(button1);
			
			var button2:Button = new Button(Root.assets.getTexture("button10000"), "Повторить");
			button2.fontSize = 24;
            button2.x = int((Constants.STAGE_WIDTH - button2.width) / 2);
            button2.y = 232;
            button2.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				urlLoader.load(new URLRequest("http://in-syst.ru/SMForm.php"));
			});
			
		}
		
	}

}