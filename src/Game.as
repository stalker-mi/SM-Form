package 
{
    import starling.animation.Transitions;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.utils.deg2rad;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	
	import feathers.controls.TextInput;
	import feathers.core.ITextEditor;
	import feathers.controls.text.StageTextTextEditor;
	
	import starling.display.Button;
	import starling.events.Event;
	
	import flash.filesystem.*;
	
    /** The Game class represents the actual game. In this scaffold, it just displays a 
     *  Starling that moves around fast. When the user touches the Starling, the game ends. */ 
    public class Game extends Sprite
    {
        public static const GAME_OVER:String = "gameOver";
        
        private var mBird:Image;
        
		private var input:TextInput;
		private var input2:TextInput;
		
        public function Game()
        {
            init();
        }
        
        private function init():void
        {
			
			var txt:TextField = new TextField(200, 50, "Word","Times New Roman",
											  40, 0xffffff);
			txt.y=50;
			addChild(txt);
			
			input = new TextInput();
     		//input.text = "Hello World";
			input.x=10;
			input.y=100;
			input.width=200;
			input.height=50;
			input.isEditable=true;
			addChild(input);
        	input.textEditorProperties.fontSize = 20;
			input.setFocus();
			input.backgroundSkin=new Image(Root.assets.getTexture("powered_by_starling"));
			
			txt = new TextField(200, 50, "Translate","Times New Roman",
											  40, 0xffffff);
			txt.y=200;
			addChild(txt);  
											
			input2 = new TextInput();
     		//input2.text = "Hello World";
			input2.x=10;
			input2.y=250;
			input2.width=200;
			input2.height=50;
			input2.isEditable=true;
        	input2.textEditorProperties.fontSize = 20;
			input2.backgroundSkin=new Image(Root.assets.getTexture("powered_by_starling"));
			addChild(input2);
											
			var button:Button = new Button(Root.assets.getTexture("button_normal"), "ОК");
            button.fontName = "Ubuntu";
            button.fontSize = 16;
            button.x = int((Constants.STAGE_WIDTH - button.width) / 2);
            button.y = Constants.STAGE_HEIGHT * 0.75;
            button.addEventListener(Event.TRIGGERED, onButtonTriggered);
            addChild(button);
			
			
            /*mBird = new Image(Root.assets.getTexture("starling_rocket"));
            mBird.pivotX = mBird.width / 2;
            mBird.pivotY = mBird.height / 2;
            mBird.x = Constants.STAGE_WIDTH / 2;
            mBird.y = Constants.STAGE_HEIGHT / 2;
            mBird.addEventListener(TouchEvent.TOUCH, onBirdTouched);
            addChild(mBird);
			moveBird();
            */
			
			
            
        }
        
        
        
		private function onButtonTriggered():void
        {
			
			if(input2.text!="" && input.text!=""){
			
			var newFile:File = File.applicationStorageDirectory;
  			newFile = newFile.resolvePath("preferences.xml");
			var stream:FileStream=new FileStream();
			stream.open(newFile, FileMode.READ);
			var prefsXML:XML = XML(stream.readUTFBytes(stream.bytesAvailable));
			stream.close();
			
			prefsXML.number++;
			

			prefsXML.appendChild(<word><word_text>{input.text}</word_text><word_translate>{input2.text}</word_translate></word>);  
			
			var str:String = prefsXML.toString();
			//str = str.replace(/\n/g, File.lineEnding);
			//var newFile:File = File.cacheDirectory;
			stream = new FileStream();
       		stream.open(newFile, FileMode.WRITE);
      	    stream.writeUTFBytes(str);
			stream.close();
			}
			Root.assets.playSound("click");
            dispatchEventWith(GAME_OVER, true, input.text);
        }
		
        private function onBirdTouched(event:TouchEvent):void
        {
            if (event.getTouch(mBird, TouchPhase.BEGAN))
            {
                Root.assets.playSound("click");
                Starling.juggler.removeTweens(mBird);
                dispatchEventWith(GAME_OVER, true, 100);
            }
        }
    }
}