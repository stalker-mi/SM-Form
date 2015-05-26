package activity 
{
	
	import starling.display.Image;
    import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
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
			// подготовка к отправке
			var url:URLRequest = new URLRequest("http://in-syst.ru/SMForm.php?reg");
			var variables:URLVariables = new URLVariables();
			variables.name = Root.user.Name;
			variables.surname = Root.user.Surname;
			variables.sex = Root.user.Sex;
			variables.email = Root.user.Email;
			variables.login = Root.user.Login;
			variables.password = Root.user.Password;
			url.data = variables;
			url.method=URLRequestMethod.POST;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			// отправка
			urlLoader.load(url);
			addText2(100);
			urlLoader.addEventListener(Event.COMPLETE, function():void {
				RemoveBack(BACK);
				// вывод
				if(button2.visible) button2.visible = false;
				var str:String = urlLoader.data as String;
				if(!txt_container.visible) txt_container.visible = true;
				txt_container.text = str;
				button1.enabled = true;
			});
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function():void {
				// вывод
				if(!button2.visible) button2.visible = true;
				if(!txt_container.visible) txt_container.visible = true;
				txt_container.text = "Connection Error";
			});
			// кнопка ОК
			var button1:Button = new Button(Root.assets.getTexture("button_ok0000"), "OK");
			button1.fontSize = 24;
            button1.x = int((Constants.STAGE_WIDTH - button1.width) / 2);
            button1.y = 332;
            button1.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				dispatchEventWith(OK, true);
			});
			button1.enabled = false;
			addChild(button1);
			
			// кнопка Повторить
			var button2:Button = new Button(Root.assets.getTexture("button10000"), "Повторить");
			button2.fontSize = 24;
            button2.x = int((Constants.STAGE_WIDTH - button2.width) / 2);
            button2.y = 232;
            button2.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				// повторная
				urlLoader.load(url);
			});
			button2.visible = false;
			addChild(button2);
			
		}
		
	}

}