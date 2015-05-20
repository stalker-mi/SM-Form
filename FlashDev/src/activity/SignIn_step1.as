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

    public class SignIn_step1 extends SignIn
    {
		
		public static const NEXT:String = "next1";
		public static const BACK:String = "back1";
		private var error:Boolean;
		private var error1:TextField;
		private var error2:TextField;
		
        public function SignIn_step1()
        {
			MY_BACK=BACK;
            init();
        }

		
        private function init():void
        {	
			// поле Фамилия
			
			var txt:TextField = new TextField(126, 35, "Фамилия", "Verdana", 24);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);
			txt.y=93;
			addChild(txt);
			
			// поле ввода фамилии
			var input:TextInput = new TextInput();
			input.x = 67;
			input.y = 133;
			input.isEditable = true;
			input.paddingLeft = 20;
			input.textEditorProperties.fontSize = 20;
			if (Root.user.Surname) input.text = Root.user.Surname;
			input.backgroundSkin = new Image(Root.assets.getTexture("border0000"));
			input.maxChars = 12;
			input.addEventListener(FeathersEventType.FOCUS_OUT, function():void {
				// Заменяет выражение типа ВыРаЖЕниЕ на Выражение
				input.text = input.text.substr(0,1).toUpperCase()+input.text.substr(1).toLowerCase();
				//очищаем
				error1.text = "";
				//цвет красный
				error1.color = 0xff0000;
				// локальная проверка фамилии
				proverka_sname(input.text);});
			input.addEventListener(FeathersEventType.FOCUS_IN, function():void {
				// цвет желтый
				error1.color = 0xffaa00;
				// вывод подсказок
				error1.text = Constants.TIPS[0];
			});
			addChild(input);
			
			// поле ошибок для фамилии
			error1 = new TextField(200, 35, "", "Verdana", 9,0xff0000);
			error1.x=int((Constants.STAGE_WIDTH - error1.width) / 2);
			error1.y=163;
			addChild(error1);
			
			txt = new TextField(60, 50, "Имя", "Verdana", 24);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);;
			txt.y=180;
			addChild(txt);
			
			// поле ввода имени
			var input1:TextInput = new TextInput();
			input1.x = 67;
			input1.y = 225;
			input1.isEditable = true;
			input1.paddingLeft = 20;
			input1.textEditorProperties.fontSize = 20;
			if (Root.user.Name) input1.text = Root.user.Name;
			input1.backgroundSkin = new Image(Root.assets.getTexture("border0000"));
			input1.addEventListener(FeathersEventType.FOCUS_OUT, function():void {
				// Заменяет выражение типа ВыРаЖЕниЕ на Выражение
				input1.text = input1.text.substr(0,1).toUpperCase()+input1.text.substr(1).toLowerCase();
				//очищаем
				error2.text = "";
				//цвет красный
				error2.color = 0xff0000;
				// локальная проверка имени
				proverka_name(input1.text); } );
			input1.addEventListener(FeathersEventType.FOCUS_IN, function():void {
				// цвет желтый
				error2.color = 0xffaa00;
				// вывод подсказок
				error2.text = Constants.TIPS[0];
			});
			addChild(input1);
			
			// поле ошибок для имени
			error2 = new TextField(200, 35, "", "Verdana", 9,0xff0000);
			error2.x=int((Constants.STAGE_WIDTH - error2.width) / 2);
			error2.y=255;
			addChild(error2);
			
			// пол Пол
			txt = new TextField(60, 50, "Пол", "Verdana", 24);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);;
			txt.y=280;
			addChild(txt);
			
			// Выбор пола - мужской
			var sex_m:Sprite = new Sprite();
			sex_m.addChild(new Image(Root.assets.getTexture("sex0000")));
			sex_m.x = 80;
			sex_m.y = 327;
			sex_m.alpha = 0.5;
			if(Root.user.Sex=="m") sex_m.alpha = 1;
			sex_m.addEventListener(TouchEvent.TOUCH, function(event:TouchEvent):void {
				// если выбран М пол
				if (event.getTouch(sex_m, TouchPhase.BEGAN))
				{
					if (sex_m.alpha == 0.5) sex_m.alpha = 1;
					if (sex_f.alpha == 1) sex_f.alpha = 0.5;
				}
			});
			addChild(sex_m);
			
			// Выбор пола - женский
			var sex_f:Sprite = new Sprite();
			sex_f.addChild(new Image(Root.assets.getTexture("sex0001")));
			sex_f.x = 190;
			sex_f.y = 327;
			sex_f.alpha = 0.5;
			if(Root.user.Sex=="f") sex_f.alpha = 1;
			sex_f.addEventListener(TouchEvent.TOUCH, function(event:TouchEvent):void {
				// если выбран Ж пол
				if (event.getTouch(sex_f, TouchPhase.BEGAN))
				{
					if (sex_f.alpha == 0.5) sex_f.alpha = 1;
					if (sex_m.alpha == 1) sex_m.alpha = 0.5;
				}
			});
			addChild(sex_f);
			
			// Кнопка Далее
			var button:Button = new Button(Root.assets.getTexture("button10000"), "Далее");
            button.fontSize = 16;	
            button.x = int((Constants.STAGE_WIDTH - button.width) / 2);
            button.y = 400;
            button.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				// Если прошло проверку
				if (proverka(input.text, input1.text, sex_f.alpha, sex_m.alpha)) {
					// вставляем поля
					Root.user.Surname = input.text;
					Root.user.Name = input1.text;
					if (sex_m.alpha == 1) Root.user.Sex = "m";
					else Root.user.Sex = "f";
					// идем Далее
					dispatchEventWith(NEXT, true, new Array(input.text, input1.text, sex_m.alpha));
				}
			});
            addChild(button);
            
        }
		
		// Общая проверка
		private function proverka(text1:String, text2:String, alpha1:Number, alpha2:Number):Boolean
		{
			// ошибка
			var this_error:Boolean;
			// если были локальные ошибки
			if (error1.text != "" || error2.text != "") this_error = true;
			// если не выбрали пол
			if (alpha1 == alpha2) this_error = trace_error(error2, 2);
			// если выбрали пол
			if(error2.text==Constants.ERROR[2] && alpha1 != alpha2) this_error = false;
			// если поля пустые
			if (text1 == "") this_error = trace_error(error1, 1);
			if (text2 == "") this_error = trace_error(error2, 1); 
			// Проверка на одинаковый алфавит
			var pattern1:RegExp = /^[a-zA-Z]+$/;
			var pattern2:RegExp = /^[а-яА-ЯёЁ]+$/;
			if (pattern1.test(text1) && pattern2.test(text2)) 
			this_error = trace_error(error2, 5);
			if (pattern1.test(text2) && pattern2.test(text1)) 
			this_error = trace_error(error2, 5);
			
			if (!this_error) 
				return true;
			else
				return false;
		}
		
		// Проверка фамилии
		private function proverka_sname(text:String):Boolean {
			//поле пустое
			if (text == "") return trace_error(error1, 1);
			var pattern:RegExp = /^[а-яА-ЯёЁa-zA-Z0-9]{2,}$/;
			if (!pattern.test(text)) return trace_error(error1, 6);
			// вводятся буквы только латиницы или кириллицы
			pattern = /^[а-яА-ЯёЁa-zA-Z]+$/; 
			if (!pattern.test(text)) return trace_error(error1, 3);
			// проверка на латиницу
			pattern =/^[a-zA-Z]+$/;
			if (!pattern.test(text)) {
				// проверка на киррилицу
				pattern =/^[а-яА-ЯёЁ]+$/;
				if (!pattern.test(text)) return trace_error(error1, 4);
			}
			
			return false;
		}
		
		// Проверка имени
		private function proverka_name(text:String):Boolean {
			if(text=="") return trace_error(error2, 1);
			// вводятся буквы только латиницы или кириллицы
			var pattern:RegExp = /^[а-яА-ЯёЁa-zA-Z]/;
			if (!pattern.test(text)) return trace_error(error2, 3);
			// проверка на латиницу
			pattern =/^[a-zA-Z]+$/;
			if (!pattern.test(text)) {
				// проверка на киррилицу
				pattern =/^[а-яА-ЯёЁ]+$/;
				if (!pattern.test(text)) return trace_error(error2, 4);
			}
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