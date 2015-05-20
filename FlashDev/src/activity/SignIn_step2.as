package activity 
{
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.display.Button;
	import starling.events.Event;
	
	import feathers.controls.TextInput;
	import feathers.events.FeathersEventType;
	/**
	 * ...
	 * @author Vovik
	 */
	public class SignIn_step2 extends Sprite
	{
		public static const NEXT:String = "next2";
		public static const BACK:String = "back2";
		
		private var error1:TextField;
		private var error2:TextField;
		private var error3:TextField;
		private var error4:TextField;
		
		public function SignIn_step2() 
		{
			init();
		}
		
		private function init():void
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
			
			// поле E-mail
			var txt:TextField = new TextField(200, 28, "E-mail", "Verdana", 19);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);
			txt.y=98.4;
			addChild(txt);
			
			// поле ввода email
			var input1:TextInput = new TextInput();
			input1.x = 70;
			input1.y = 126.8;
			input1.isEditable = true;
			input1.paddingLeft = 20;
			input1.textEditorProperties.fontSize = 20;
			if (Root.user.Email) input1.text = Root.user.Email;
			input1.backgroundSkin = new Image(Root.assets.getTexture("border0000"));
			input1.addEventListener(FeathersEventType.FOCUS_OUT, function():void {
				// Заменяет выражение типа ВыРаЖЕниЕ на выражение
				input1.text = input1.text.toLowerCase();
				//очищаем
				error1.text = "";
				//цвет красный
				error1.color = 0xff0000;
				// локальная проверка имени
				proverka_email(input1.text); } );
			input1.addEventListener(FeathersEventType.FOCUS_IN, function():void {
				// цвет желтый
				error1.color = 0xffaa00;
				// вывод подсказок
				error1.text = Constants.TIPS[1];
			});
			addChild(input1);
			
			// поле ошибок для e-mail
			error1 = new TextField(200, 35, "", "Verdana", 9,0xff0000);
			error1.x=int((Constants.STAGE_WIDTH - error1.width) / 2);
			error1.y=150;
			addChild(error1);
			
			// поле Логин
			txt = new TextField(200, 28, "Логин", "Verdana", 19);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);
			txt.y=167.6;
			addChild(txt);
			
			// поле ввода логина
			var input2:TextInput = new TextInput();
			input2.x = 70;
			input2.y = 196;
			input2.isEditable = true;
			input2.paddingLeft = 20;
			input2.textEditorProperties.fontSize = 20;
			if (Root.user.Login) input2.text = Root.user.Login;
			input2.backgroundSkin = new Image(Root.assets.getTexture("border0000"));
			input2.addEventListener(FeathersEventType.FOCUS_OUT, function():void {
				// Заменяет выражение типа ВыРаЖЕниЕ на выражение
				input2.text = input2.text.toLowerCase();
				//очищаем
				error2.text = "";
				//цвет красный
				error2.color = 0xff0000;
				// локальная проверка имени
				proverka_email(input2.text); } );
			input2.addEventListener(FeathersEventType.FOCUS_IN, function():void {
				// цвет желтый
				error2.color = 0xffaa00;
				// вывод подсказок
				error2.text = Constants.TIPS[2];
			});
			addChild(input2);
			
			// поле ошибок для логина
			error2 = new TextField(200, 35, "", "Verdana", 9,0xff0000);
			error2.x=int((Constants.STAGE_WIDTH - error1.width) / 2);
			error2.y=223;
			addChild(error2);
			
			// поле Пароль
			txt = new TextField(200, 28, "Пароль", "Verdana", 19);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);
			txt.y=246;
			addChild(txt);
			
			
			
			// поле Повторить пароль
			txt = new TextField(200, 28, "Повторить пароль", "Verdana", 19);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);
			txt.y=319;
			addChild(txt);
			
			// кнопка далее
			var button:Button = new Button(Root.assets.getTexture("button10000"), "Далее");
            button.fontSize = 16;	
            button.x = int((Constants.STAGE_WIDTH - button.width) / 2);
            button.y = 400;
            button.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				dispatchEventWith(NEXT, true);
			});
            addChild(button);
			
		}
		
		// локальная проверка email
		private function proverka_email(text:String):Boolean {
			//поле пустое
			if (text == "") return trace_error(error1, 1);
			
			return false;
		}
		
		// вывод ошибок
		private function trace_error(error:TextField, number_error:int = 0) :Boolean
		{
			error.text = Constants.ERROR[number_error];
			return true;
		}
		
	}

}