package activity 
{
	
	import starling.display.Image;
    import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
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
			
			var button1:Button = new Button(Root.assets.getTexture("button_ok0000"), "OK");
			button1.fontSize = 24;
            button1.x = int((Constants.STAGE_WIDTH - button1.width) / 2);
            button1.y = 332;
            button1.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				dispatchEventWith(OK, true);
			});
			addChild(button1);
			
		}
		
	}

}