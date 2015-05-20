package 
{
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	/**
	 * ...
	 * @author vovik
	 */
	public class SignIn extends Sprite 
	{
		public var MY_BACK:String="back";
		
		public function SignIn() 
		{
			// кнопка Назад
			var back_button:Button = new Button(Root.assets.getTexture("back0000"));	
            back_button.x = 10;
            back_button.y = 100;
            back_button.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				dispatchEventWith(MY_BACK, true);
			});
            addChild(back_button);
			
		}
		
		
	}

}