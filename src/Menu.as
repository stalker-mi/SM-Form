package
{
    import starling.display.Button;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.BitmapFont;
    import starling.text.TextField;
    
	import flash.filesystem.*;
    /** The Menu shows the logo of the game and a start button that will, once triggered, 
     *  start the actual game. In a real game, it will probably contain several buttons and
     *  link to several screens (e.g. a settings screen or the credits). If your menu contains
     *  a lot of logic, you could use the "Feathers" library to make your life easier. */
    public class Menu extends Sprite
    {
        public static const START_GAME:String = "startGame";
        
        public function Menu()
        {
            init();
        }
        
        private function init():void
        {
            var textField:TextField = new TextField(250, 50, "Save words", 
                "Mistral", 50, 0xffffff);
            textField.x = (Constants.STAGE_WIDTH - textField.width) / 2;
            textField.y = 50;
            addChild(textField);
            
			
            var button:Button = new Button(Root.assets.getTexture("button_normal"), "New word");
            button.fontName = "Ubuntu";
            button.fontSize = 16;
            button.x = int((Constants.STAGE_WIDTH - button.width) / 2);
            button.y = Constants.STAGE_HEIGHT * 0.65;
            button.addEventListener(Event.TRIGGERED, onButtonTriggered);
            addChild(button);
			
			var button2:Button = new Button(Root.assets.getTexture("button_normal"), "Show words");
            button2.fontName = "Ubuntu";
            button2.fontSize = 16;
            button2.x = int((Constants.STAGE_WIDTH - button2.width) / 2);
            button2.y = Constants.STAGE_HEIGHT * 0.75;
            button2.addEventListener(Event.TRIGGERED, onButtonTriggered2);
            addChild(button2);
			
			
			var newFile:File = File.applicationStorageDirectory;
  			newFile = newFile.resolvePath("preferences.xml");
			var stream:FileStream;
			var prefsXML:XML;
			if(!newFile.exists) {
				prefsXML = <words><number>0</number></words>; 
				var outputString:String = '<?xml version="1.0" encoding="utf-8"?>\n'; 
				outputString += prefsXML.toXMLString(); 
				stream = new FileStream();
       			stream.open(newFile, FileMode.WRITE);
      	    	stream.writeUTFBytes(outputString);
				stream.close();
			}
			stream = new FileStream();
			
       		stream.open(newFile, FileMode.READ);
			prefsXML = XML(stream.readUTFBytes(stream.bytesAvailable));
			stream.close();
			
			var str:String="Всего слов:"+prefsXML.number;
			
			var txt:TextField = new TextField(200,50, str,"Times New Roman",
											  20, 0xffffff);
			txt.y=100;
			addChild(txt);
			
			
			
        }
        
        private function onButtonTriggered():void
        {
            dispatchEventWith(START_GAME, true, "add");
        }
		
		  private function onButtonTriggered2():void
        {
            dispatchEventWith(START_GAME, true, "show");
        }
    }
}