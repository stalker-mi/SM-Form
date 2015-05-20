package  {
	
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
		
	import flash.filesystem.*;	
	
	import feathers.controls.ScrollContainer;
	import starling.display.Quad;
		
	public class Show extends Sprite {

		 public static const GAME_OVER:String = "gameOver";


		public function Show() {
			
			var newFile:File = File.applicationStorageDirectory;
  			newFile = newFile.resolvePath("preferences.xml");
			var stream:FileStream=new FileStream();
			stream.open(newFile, FileMode.READ);
			var prefsXML:XML = XML(stream.readUTFBytes(stream.bytesAvailable));
			stream.close();
			
			var container:ScrollContainer = new ScrollContainer();
			container.width = 400;
			container.height = 300;
			addChild( container );
			
			
			var str:String="";
			for(var i:int=0;i<prefsXML.number;i++)
			str += prefsXML.word[i].word_text+"\n";
			
			
			var txt:TextField = new TextField(150,450, str,"Times New Roman",
											  15, 0xffffff);
			txt.y=10;
			txt.x=10;
			//txt.hAlign="left";
			txt.vAlign="top";
			container.addChild(txt);
			
			str="";
			for(i=0;i<prefsXML.number;i++)
			str += prefsXML.word[i].word_translate+"\n";
			
			txt = new TextField(150,450, str,"Times New Roman",
											  15, 0xffffff);
			txt.y=10;
			txt.x=170;
			//txt.hAlign="left";
			txt.vAlign="top";
			container.addChild(txt);
			
			
			
			
			var button:Button = new Button(Root.assets.getTexture("button_normal"), "ОК");
            button.fontName = "Ubuntu";
            button.fontSize = 16;
            button.x = int((Constants.STAGE_WIDTH - button.width) / 2);
            button.y = Constants.STAGE_HEIGHT * 0.75;
            button.addEventListener(Event.TRIGGERED, onButtonTriggered);
            addChild(button);
			
			
			
			
			
			
			
		}
		
		private function onButtonTriggered():void
        {
			Root.assets.playSound("click");
            dispatchEventWith(GAME_OVER, true, "rwe");
		}

	}
	
}
