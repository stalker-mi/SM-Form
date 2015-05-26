package activity
{
	
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
		
	public class LogIn extends SignIn {

		 public static const LOG_OUT:String = "log_out";


		public function LogIn() {
			
			var error:Boolean;
			addText2(150);
			txt_container.visible = true;
			// проверка логина
			error = proverka_login(Root.user.Login);
			// проверка пароля
			error=proverka_pas(Root.user.Password);
			// запрос к php
			var url:URLRequest = new URLRequest("http://in-syst.ru/SMForm.php?login");
			var variables:URLVariables = new URLVariables();
			variables.login = Root.user.Login;
			variables.password = Root.user.Password;
			url.data = variables;
			url.method = URLRequestMethod.POST;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			// отправка
			if (!error && txt_container.text=="") urlLoader.load(url);
			
			urlLoader.addEventListener(Event.COMPLETE, function():void {
				// вывод
				var str:String = urlLoader.data as String;
				txt_container.text = str;
			});
			
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function():void {
				// вывод
				txt_container.text = "Connection Error";
			});
			// Кнопка выйти
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
		// проверка логина
		private function proverka_login(text:String):Boolean {
			//поле пустое
			if (text == "") return trace_error(txt_container, 13);
			// Имя пользователя (с ограничением 2-10 символов, которыми могут быть буквы и цифры, первый символ обязательно буква)
			var pattern:RegExp = /^[a-zA-Z][a-zA-Z0-9-_\.]{1,10}$/;
			if (!pattern.test(text)) return trace_error(txt_container, 8);
			
			return false;
		}
		// проверка пароля
		private function proverka_pas(text:String):Boolean {
			if (text == "") return trace_error(txt_container, 14);
				var pattern:RegExp =/^[a-zA-Z0-9-_*.#%$!&@]{5,}$/; 
				if (!pattern.test(text)) return trace_error(txt_container, 10);
				
				return false;
		}
		
	}
}
