package activity 
{
    import starling.display.Image;
    import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Vovik
	 */
	public class SignIn_step2 extends SignIn
	{
		public static const NEXT:String = "next2";
		public static const BACK:String = "back2";
		private var error:Boolean;
		
		public function SignIn_step2() 
		{
			init();
		}
		
		private function init():void
        {
			// кнопка назад
			AddBack(BACK);
			// поле E-mail
			AddText(1, 90, "E-mail", Root.user.Email, 1, false);
			// ошибки e-mial
			addEventListener("E-mail", function(e:Event, data:String):void { proverka_email(data); } );
			// поле Логин
			AddText(2, 165, "Логин", Root.user.Login, 2, false);
			addEventListener("Логин", function(e:Event, data:String):void { proverka_login(data); } );
			// поле Пароль
			AddText(3, 244, "Пароль", null, 3, false);
			addEventListener("Пароль", function(e:Event, data:String):void { proverka_pas1(data); } );
			// поле Пароль
			AddText(4, 319, "Повторить пароль", null, 4, false);
			addEventListener("Повторить пароль", function(e:Event, data:String):void { proverka_pas2(data); } );
			
			// кнопка далее
			var button:Button = new Button(Root.assets.getTexture("button10000"), "Далее");
            button.fontSize = 16;	
            button.x = int((Constants.STAGE_WIDTH - button.width) / 2);
            button.y = 400;
            button.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				
				// Если прошло проверку
				if (proverka(mData[1].text, mData[2].text, mData[3].text, mData[4].text)) {
					// вставляем поля
					Root.user.Email = mData[1].text;
					Root.user.Login = mData[2].text;
					Root.user.Password = mData[3].text;
					// идем далее
					dispatchEventWith(NEXT, true);
				}
			});
            addChild(button);
			
			
		}
		
		private function proverka(text1:String, text2:String, text3:String, text4:String):Boolean {
			// ошибка
			var this_error:Boolean;
			// если были локальные ошибки
			if (errorsArr[1].text != "" || errorsArr[2].text != "") this_error = true;
			// если поля пустые
			if (text1 == "") this_error = trace_error(errorsArr[1], 1);
			if (text2 == "") this_error = trace_error(errorsArr[2], 1); 
			if (text3 == "") this_error = trace_error(errorsArr[3], 1); 
			if (text4 == "") this_error = trace_error(errorsArr[4], 1); 
			
			if (!this_error) 
				return true;
			else
				return false;
			
		}
		
		// локальная проверка email
		private function proverka_email(text:String):Boolean {
			//поле пустое
			if (text == "") return trace_error(errorsArr[1], 1);
			
			return false;
		}
		
		// локальная проверка Логина
		private function proverka_login(text:String):Boolean {
			//поле пустое
			if (text == "") return trace_error(errorsArr[2], 1);
			
			return false;
		}
		
		// локальная проверка Пароля
		private function proverka_pas1(text:String):Boolean {
			//поле пустое
			if (text == "") return trace_error(errorsArr[3], 1);
			
			return false;
		}
		
		// локальная проверка повторения пароля
		private function proverka_pas2(text:String):Boolean {
			//поле пустое
			if (text == "") return trace_error(errorsArr[4], 1);
			
			return false;
		}
		
	}

}