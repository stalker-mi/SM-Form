package activity
{
    import starling.display.Image;
    import starling.display.Sprite;
	import starling.text.TextField;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
	import starling.display.Button;
	import starling.events.Event;
	
	

    public class SignIn_step1 extends SignIn
    {
		
		public static const NEXT:String = "next1";
		public static const BACK:String = "back1";
		private var error:Boolean;
		
        public function SignIn_step1()
        {
            init();
        }

		
        private function init():void
        {	
			// кнопка назад
			AddBack(BACK);
			// поле Фамилия
			AddText(1, 103, "Фамилия", Root.user.Surname, 0, 1);
			// ошибки фамилии
			addEventListener("Фамилия", function(e:Event, data:String):void { proverka_sname(data); } );
			// поле имя
			AddText(2, 190, "Имя", Root.user.Name, 0, 1);
			// ошибки имени
			addEventListener("Имя", function(e:Event, data:String):void { proverka_name(data); } );
			
			// поле Пол
			var txt:TextField = new TextField(60, 50, "Пол", "Verdana", 24);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);;
			txt.y=280;
			addChild(txt);
			
			// Выбор пола - мужской
			var sex_m:Sprite = new Sprite();
			sex_m.addChild(new Image(Root.assets.getTexture("sex0001")));
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
			sex_f.addChild(new Image(Root.assets.getTexture("sex0000")));
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
				if (proverka(mData[1].text, mData[2].text, sex_f.alpha, sex_m.alpha)) {
					// вставляем поля
					Root.user.Surname = mData[1].text;
					Root.user.Name = mData[2].text;
					if (sex_m.alpha == 1) Root.user.Sex = "m";
					else Root.user.Sex = "f";
					
					// идем Далее
					dispatchEventWith(NEXT, true);
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
			if (errorsArr[1].text != "" || errorsArr[2].text != "") this_error = true;
			// если не выбрали пол
			if (alpha1 == alpha2) this_error = trace_error(errorsArr[2], 2);
			// если выбрали пол
			if(errorsArr[2].text==Constants.ERROR[2] && alpha1 != alpha2) this_error = false;
			// если поля пустые
			if (text1 == "") this_error = trace_error(errorsArr[1], 1);
			if (text2 == "") this_error = trace_error(errorsArr[2], 1); 
			// Проверка на одинаковый алфавит
			var pattern1:RegExp = /^[a-zA-Z]+$/;
			var pattern2:RegExp = /^[а-яА-ЯёЁ]+$/;
			if (pattern1.test(text1) && pattern2.test(text2)) 
			this_error = trace_error(errorsArr[2], 5);
			if (pattern1.test(text2) && pattern2.test(text1)) 
			this_error = trace_error(errorsArr[2], 5);
			
			if (!this_error) 
				return true;
			else
				return false;
		}
		
		// Проверка фамилии
		private function proverka_sname(text:String):Boolean {
			//поле пустое
			if (text == "") return trace_error(errorsArr[1], 1);
			var pattern:RegExp = /^[а-яА-ЯёЁa-zA-Z0-9]{2,}$/;
			if (!pattern.test(text)) return trace_error(errorsArr[1], 6);
			// вводятся буквы только латиницы или кириллицы
			pattern = /^[а-яА-ЯёЁa-zA-Z]+$/; 
			if (!pattern.test(text)) return trace_error(errorsArr[1], 3);
			// проверка на латиницу
			pattern =/^[a-zA-Z]+$/;
			if (!pattern.test(text)) {
				// проверка на киррилицу
				pattern =/^[а-яА-ЯёЁ]+$/;
				if (!pattern.test(text)) return trace_error(errorsArr[1], 4);
			}
			
			return false;
		}
		
		// Проверка имени
		private function proverka_name(text:String):Boolean {
			if(text=="") return trace_error(errorsArr[2], 1);
			// вводятся буквы только латиницы или кириллицы
			var pattern:RegExp = /^[а-яА-ЯёЁa-zA-Z]/;
			if (!pattern.test(text)) return trace_error(errorsArr[2], 3);
			// проверка на латиницу
			pattern =/^[a-zA-Z]+$/;
			if (!pattern.test(text)) {
				// проверка на киррилицу
				pattern =/^[а-яА-ЯёЁ]+$/;
				if (!pattern.test(text)) return trace_error(errorsArr[2], 4);
			}
			return false;
			
		}
		
		
        

    }
}