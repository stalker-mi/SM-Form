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
		
    /** The Game class represents the actual game. In this scaffold, it just displays a 
     *  Starling that moves around fast. When the user touches the Starling, the game ends. */ 
    public class SignIn_step1 extends Sprite
    {
		public static const NEXT:String = "next1";
		public static const BACK:String = "back1";
		private var error:Boolean;
		private var error1:TextField;
		private var error2:TextField;
		
        public function SignIn_step1()
        {
            init();
        }
        
        private function init():void
        {
			var back_button:Button = new Button(Root.assets.getTexture("back0000"));	
            back_button.x = 10;
            back_button.y = 100;
            back_button.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				dispatchEventWith(BACK, true);
			});
            addChild(back_button);
			
			
			var txt:TextField = new TextField(126, 35, "Фамилия", "Verdana", 24);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);
			txt.y=93;
			addChild(txt);
			
			var input:TextInput = new TextInput();
			input.x = 67;
			input.y = 133;
			input.isEditable = true;
			input.paddingLeft = 20;
			input.textEditorProperties.fontSize = 20;
			input.backgroundSkin = new Image(Root.assets.getTexture("border0000"));
			input.maxChars = 12;
			input.addEventListener(FeathersEventType.FOCUS_OUT, function():void {proverka_name(input1.text);});
			addChild(input);
			
			error1 = new TextField(200, 35, "", "Verdana", 9,0xff0000);
			error1.x=int((Constants.STAGE_WIDTH - error1.width) / 2);
			error1.y=163;
				
			txt = new TextField(60, 50, "Имя", "Verdana", 24);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);;
			txt.y=180;
			addChild(txt);
			
			var input1:TextInput = new TextInput();
			input1.x = 67;
			input1.y = 225;
			input1.isEditable = true;
			input1.paddingLeft = 20;
			input1.textEditorProperties.fontSize = 20;
			input1.backgroundSkin = new Image(Root.assets.getTexture("border0000"));
			input1.addEventListener(FeathersEventType.FOCUS_OUT, function():void {proverka_sname(input1.text);});
			addChild(input1);
			
			error2 = new TextField(200, 35, "", "Verdana", 9,0xff0000);
			error2.x=int((Constants.STAGE_WIDTH - error2.width) / 2);
			error2.y=255;
			
			txt = new TextField(60, 50, "Пол", "Verdana", 24);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);;
			txt.y=280;
			addChild(txt);
			
			var sex_m:Sprite = new Sprite();
			sex_m.addChild(new Image(Root.assets.getTexture("sex0000")));
			sex_m.x = 80;
			sex_m.y = 327;
			sex_m.alpha = 0.5;
			sex_m.addEventListener(TouchEvent.TOUCH, function(event:TouchEvent):void {
				if (event.getTouch(sex_m, TouchPhase.BEGAN))
				{
					if (sex_m.alpha == 0.5) sex_m.alpha = 1;
					if (sex_f.alpha == 1) sex_f.alpha = 0.5;
				}
			});
			addChild(sex_m);
			
			var sex_f:Sprite = new Sprite();
			sex_f.addChild(new Image(Root.assets.getTexture("sex0001")));
			sex_f.x = 190;
			sex_f.y = 327;
			sex_f.alpha = 0.5;
			sex_f.addEventListener(TouchEvent.TOUCH, function(event:TouchEvent):void {
				if (event.getTouch(sex_f, TouchPhase.BEGAN))
				{
					if (sex_f.alpha == 0.5) sex_f.alpha = 1;
					if (sex_m.alpha == 1) sex_m.alpha = 0.5;
				}
			});
			addChild(sex_f);
			
			var button:Button = new Button(Root.assets.getTexture("button10000"), "Далее");
            button.fontSize = 16;	
            button.x = int((Constants.STAGE_WIDTH - button.width) / 2);
            button.y = 400;
            button.addEventListener(Event.TRIGGERED, function():void {
				Root.assets.playSound("click");
				if (proverka(input.text, input1.text, sex_f.alpha, sex_m.alpha)) 
				dispatchEventWith(NEXT, true, new Array(input.text,input1.text,sex_m.alpha));
			});
            addChild(button);
            
        }
		
		// Общая проверка
		private function proverka(text1:String, text2:String, alpha1:Number, alpha2:Number):Boolean
		{
			var this_error:Boolean;
			if (alpha1 == alpha2) this_error = true;
			if (text1 == "") { this_error = true; trace_error(error1, 1); }
			if (text2 == "") { this_error = true; trace_error(error2, 1); }
			
			
			if (!this_error) 
				return true;
			else
				return false;
		}
		
		// Проверка имени
		private function proverka_name(text:String):void {
			trace_error(error1, 2);
		}
		
		// Проверка фамилии
		private function proverka_sname(text:String):void {
			trace_error(error2, 3);
		}
		
		private function trace_error(error:TextField, number_error:int = 0) :void
		{
			error.text = Constants.ERROR[number_error];
			addChild(error);
		}
        

    }
}