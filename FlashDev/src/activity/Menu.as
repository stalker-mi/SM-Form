package activity
{
	import starling.display.Image;
    import starling.display.Button;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.BitmapFont;
    import starling.text.TextField;
    
	import feathers.controls.TextInput;
    /** The Menu shows the logo of the game and a start button that will, once triggered, 
     *  start the actual game. In a real game, it will probably contain several buttons and
     *  link to several screens (e.g. a settings screen or the credits). If your menu contains
     *  a lot of logic, you could use the "Feathers" library to make your life easier. */
    public class Menu extends Sprite
    {
        public static const LOG_IN:String = "logIn";
        public static const SIGN_IN:String = "signIn";
		
        public function Menu()
        {
            init();
        }
        
        private function init():void
        {
            var button:Button = new Button(Root.assets.getTexture("button_in0000"), "Войти");
			button.fontSize = 24;
            button.x = int((Constants.STAGE_WIDTH - button.width) / 2);
            button.y = 134;
            button.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				button2.y = 402;
				addChild(log_in);
			});
            addChild(button);
			
			var log_in:Sprite=new Sprite();
			
			var txt:TextField = new TextField(90, 35, "Логин:", "Verdana", 24);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);;
			txt.y=183;
			log_in.addChild(txt);
			
			txt=new TextField(105, 35, "Пароль:", "Verdana", 24);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);;
			txt.y=257;
			log_in.addChild(txt);
			
			var input:TextInput = new TextInput();
			input.x = 70;
			input.y = 215;
			input.isEditable = true;
			input.paddingLeft = 20;
			input.textEditorProperties.fontSize = 20;
			input.backgroundSkin=new Image(Root.assets.getTexture("border0000"));
			log_in.addChild(input);
			
			var input1:TextInput = new TextInput();
			input1.x = 70;
			input1.y = 288;
			input1.isEditable = true;
			input1.paddingLeft = 20;
			input1.textEditorProperties.fontSize = 20;
			input1.displayAsPassword = true;
			input1.backgroundSkin=new Image(Root.assets.getTexture("border0000"));
			log_in.addChild(input1);
			
			var button1:Button = new Button(Root.assets.getTexture("button_ok0000"), "OK");
			button1.fontSize = 24;
            button1.x = int((Constants.STAGE_WIDTH - button1.width) / 2);
            button1.y = 332;
            button1.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				Root.user.Login = input.text;
				Root.user.Password = input1.text;
				dispatchEventWith(LOG_IN, true);
			});
			log_in.addChild(button1);
			
			var button2:Button = new Button(Root.assets.getTexture("buttom_reg0000"), "Регистрация");
			button2.fontSize = 24;
            button2.x = int((Constants.STAGE_WIDTH - button2.width) / 2);
            button2.y = 252;
            button2.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				dispatchEventWith(SIGN_IN, true);
			});
            addChild(button2);
			
			
        }
        

		
    }
}