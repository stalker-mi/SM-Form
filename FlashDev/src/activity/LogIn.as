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
			addText2("");
			txt_container.visible = true;
			if (Root.user.Login=="" || !Root.user.Login) {
				txt_container.text = "Поле логин пустое\n";
				error = true;
			}
			if (Root.user.Password == "" || !Root.user.Password ) {
				txt_container.text = "Поле пароль пустое\n";
				error = true;
			}
			
			var url:URLRequest = new URLRequest("http://in-syst.ru/SMForm.php?login");
			var variables:URLVariables = new URLVariables();
			variables.login = Root.user.Login;
			variables.password = Root.user.Password;
			url.data = variables;
			url.method = URLRequestMethod.POST;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			// отправка
			if (!error) urlLoader.load(url);
			
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

	}
	
}
