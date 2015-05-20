package
{
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.utils.AssetManager;
	import starling.text.TextField;
	
	import activity.*;

    /** The Root class is the topmost display object in your game. It loads all the assets
     *  and displays a progress bar while this is happening. Later, it is responsible for
     *  switching between game and menu. For this, it listens to "START_GAME" and "GAME_OVER"
     *  events fired by the Menu and Game classes. Keep this class rather lightweight: it 
     *  controls the high level behaviour of your game. */
    public class Root extends Sprite
    {
        private static var sAssets:AssetManager;
        private var mActiveScene:Sprite;
		private static var myUser:User;
        
        public function Root()
        {
            //addEventListener(Menu.LOG_IN, onStartGame);
			addEventListener(Menu.SIGN_IN, onSignIn);
            addEventListener(SignIn_step1.NEXT,  onNext);
			addEventListener(SignIn_step1.BACK,  onNext);
			addEventListener(SignIn_step2.NEXT,  onNext);
			addEventListener(SignIn_step2.BACK,  onNext);
            // not more to do here -- Startup will call "start" immediately.
        }
        
        public function start(assets:AssetManager):void
        {
			sAssets = assets;
			myUser = new User();
			addChild(new Image(sAssets.getTexture("my_background0000")));
			var txt:TextField = new TextField(310, 35, "Форма входа/регистрации", "Verdana", 19, 128, true);
			txt.x=int((Constants.STAGE_WIDTH - txt.width) / 2);;
			txt.y = 19;
			addChild(txt);
			showScene(Menu);
        }
		
        private function onSignIn(event:Event):void
        {
            trace("Sign In!");
            showScene(SignIn_step1);
        }
		
		private function onNext(event:Event):void
        {
            trace("This step: "+event.type);
            if (event.type == "next1") showScene(SignIn_step2);
			if (event.type == "back1") showScene(Menu);
			if (event.type == "next2") showScene(SignIn_step3);
			if (event.type == "back2") showScene(SignIn_step1);
        }
		

		
        private function showScene(screen:Class):void
        {
            if (mActiveScene) mActiveScene.removeFromParent(true);
            mActiveScene = new screen();
            addChild(mActiveScene);
        }
        
        public static function get assets():AssetManager { return sAssets; }
		public static function get user():User { return myUser; }
    }
}