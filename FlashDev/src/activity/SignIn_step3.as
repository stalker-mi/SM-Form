package activity 
{
	
	import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.display.Button;
	import starling.events.Event;
	/**
	 * ...
	 * @author vovik
	 */
	public class SignIn_step3 extends Sprite
	{
		public static const OK:String = "ok";
		public static const BACK:String = "back3";
		
		public function SignIn_step3() 
		{
			// кнопка Назад
			var back_button:Button = new Button(Root.assets.getTexture("back0000"));	
            back_button.x = 10;
            back_button.y = 100;
            back_button.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				dispatchEventWith(BACK, true);
			});
            addChild(back_button);
		}
		
	}

}