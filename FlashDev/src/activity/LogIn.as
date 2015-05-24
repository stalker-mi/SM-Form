package activity
{
	
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
		
	public class LogIn extends SignIn {

		 public static const LOG_OUT:String = "log_out";


		public function LogIn() {
			
			var error:Boolean;
			addText2("Вы вошли как\n"+Root.user.Login);
			if (Root.user.Login == "") txt_container.text = "Поле логин пустое\n";
			if (Root.user.Password == "") txt_container.text = "Поле пароль пустое\n";
			
			var button:Button = new Button(Root.assets.getTexture("button_in0000"), "Выйти");
			button.fontSize = 24;
            button.x = int((Constants.STAGE_WIDTH - button.width) / 2);
            button.y = 334;
            button.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				dispatchEventWith(LOG_OUT,true);
			});
            addChild(button);
			
			
		}

	}
	
}
