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
			AddText(1, 90, "E-mail", Root.user.Email, 1, 2);
			// ошибки e-mial
			addEventListener("E-mail", function(e:Event, data:String):void { proverka_email(data); } );
			// поле Логин
			AddText(2, 165, "Логин", Root.user.Login, 2, 2);
			addEventListener("Логин", function(e:Event, data:String):void { proverka_login(data); } );
			// поле Пароль
			AddText(3, 244, "Пароль", null, 3, 3);
			mData[3].displayAsPassword = true;
			addEventListener("Пароль", function(e:Event, data:String):void { proverka_pas1(data); } );
			// поле Пароль
			AddText(4, 319, "Повторить пароль", null, 4, 3);
			mData[4].displayAsPassword = true;
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
			if (errorsArr[1].text != "" || errorsArr[2].text != "" || errorsArr[3].text != "" || errorsArr[4].text != "") this_error = true;
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
			// валидация e-mail
			var pattern:RegExp = /^(\S+)@([a-z0-9-]+)(\.)([a-z]{2,4})(\.?)([a-z]{0,4})+$/;
			if (!pattern.test(text)) return trace_error(errorsArr[1], 7);
			
			return false;
		}
		
		// локальная проверка Логина
		private function proverka_login(text:String):Boolean {
			//поле пустое
			if (text == "") return trace_error(errorsArr[2], 1);
			// Имя пользователя (с ограничением 2-10 символов, которыми могут быть буквы и цифры, первый символ обязательно буква)
			var pattern:RegExp = /^[a-zA-Z][a-zA-Z0-9-_\.]{1,10}$/;
			if (!pattern.test(text)) return trace_error(errorsArr[2], 8);
			
			return false;
		}
		
		// локальная проверка Пароля
		private function proverka_pas1(text:String):Boolean {
			//поле пустое
			if (text == "") return trace_error(errorsArr[3], 1);
			var pattern:RegExp =/^[a-zA-Z0-9-_*.#%$!&@]{5,}$/; 
			if (!pattern.test(text)) return trace_error(errorsArr[3], 10);
			var k:int = text.length;
			if (text.indexOf("qwerty") != -1) k -= 3;
			if (text.indexOf("123")!=-1) k --;
			for (var i:int = 0; i < text.length; i++ ) {
				// цифры от 0 до 9
				if (text.charCodeAt(i) >= 48 && text.charCodeAt(i) <= 58) k++;
				// букцы A-Z
				else if (text.charCodeAt(i) >= 97 && text.charCodeAt(i) <= 122) k += 2;
				// буквы a-z
				else if (text.charCodeAt(i) >= 65 && text.charCodeAt(i) <= 90) k += 3;
				// спецсимволы
				else k += 4;
			}
			if(k<21) return trace_error(errorsArr[3], 12);
			if(mData[4].text!=text) return trace_error(errorsArr[4], 11);
			return false;
		}
		
		// локальная проверка повторения пароля
		private function proverka_pas2(text:String):Boolean {
			//поле пустое
			if (text == "") return trace_error(errorsArr[4], 1);
			if(mData[3].text=="") return trace_error(errorsArr[4], 9);
			if(mData[3].text!=text) return trace_error(errorsArr[4], 11);
			
			return false;
		}
		
	}

}