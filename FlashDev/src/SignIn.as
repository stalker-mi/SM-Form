package 
{
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.display.Image;
	
	import feathers.controls.TextInput;
	import feathers.events.FeathersEventType;
	/**
	 * ...
	 * @author vovik
	 */
	public class SignIn extends Sprite 
	{
		public var errorsArr:Array;
		public var mData:Array;
		
		public function SignIn() 
		{
			errorsArr = new Array();
			mData = new Array();
		}
		
		// кнопка Назад
		public function AddBack(BACK:String = "back"):void {
			var back_button:Button = new Button(Root.assets.getTexture("back0000"));	
            back_button.x = 10;
            back_button.y = 100;
            back_button.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				dispatchEventWith(BACK, true);
			});
            addChild(back_button);
		}
		
		// Мое поле
		public function AddText(id:int=0,txt_y:Number=100, text:String="", default_text:String="", tips:int=0,allLower:Boolean=false):void{
			// поле label
			var txt:TextField = new TextField(200, 28, text, "Verdana", 19);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);
			txt.y=txt_y;
			addChild(txt);
			
			// поле ввода
			var input1:TextInput = new TextInput();
			input1.x = 70;
			input1.y = txt.y+28.4;
			input1.isEditable = true;
			input1.paddingLeft = 20;
			input1.textEditorProperties.fontSize = 20;
			if (default_text) input1.text = default_text;
			input1.backgroundSkin = new Image(Root.assets.getTexture("border0000"));
			input1.addEventListener(FeathersEventType.FOCUS_OUT, function():void {
				if (allLower) {
					// Заменяет выражение типа ВыРаЖЕниЕ на Выражение
					input1.text = input1.text.substr(0,1).toUpperCase()+input1.text.substr(1).toLowerCase();
				}
				else {
					// Заменяет выражение типа ВыРаЖЕниЕ на выражение
					input1.text = input1.text.toLowerCase();
				}
				//очищаем
				errorsArr[id].text = "";
				//цвет красный
				errorsArr[id].color = 0xff0000;
				dispatchEventWith(text,true,input1.text);
				} );
			input1.addEventListener(FeathersEventType.FOCUS_IN, function():void {
				// цвет желтый
				errorsArr[id].color = 0xffaa00;
				// вывод подсказок
				errorsArr[id].text = Constants.TIPS[tips];
			});
			addChild(input1);
			
			// поле ошибок
			var error1:TextField = new TextField(200, 30, "", "Verdana", 9,0xff0000);
			error1.x=int((Constants.STAGE_WIDTH - error1.width) / 2);
			error1.y=txt.y+60;
			addChild(error1);
			errorsArr[id] = error1;
			mData[id] = input1;
		}
		
		// вывод ошибок
		public function trace_error(error:TextField, number_error:int = 0) :Boolean
		{
			error.text = Constants.ERROR[number_error];
			return true;
		}
		
	}

}