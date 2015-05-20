package
{
    import flash.desktop.NativeApplication;
    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
	import flash.net.FileReference;
	
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
    import flash.utils.ByteArray;
    import flash.utils.setTimeout;
	import flash.utils.describeType;
	
    import starling.core.Starling;
    import starling.events.Event;
    import starling.textures.RenderTexture;
    import starling.utils.AssetManager;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;
    import starling.utils.SystemUtil;
    import starling.utils.formatString;

    import utils.ProgressBar;
	
	import flash.net.URLRequest;

    [SWF(width="320", height="480", frameRate="30", backgroundColor="#000000")]
    public class Main extends Sprite
    {
		[Embed(source="../assets/audio/click.mp3")] private var click:Class;
		[Embed(source = "../assets/textures/2x/atlas.png")] private var atlas:Class;
		
		
        private const StageWidth:int  = 320;
        private const StageHeight:int = 480;

        private var mStarling:Starling;
        private var mBackground:Loader;
        private var mProgressBar:ProgressBar;

        public function Main()
        {
            // We develop the game in a *fixed* coordinate system of 320x480. The game might
            // then run on a device with a different resolution; for that case, we zoom the
            // viewPort to the optimal size for any display and load the optimal textures.

            var iOS:Boolean = SystemUtil.platform == "IOS";
            var stageSize:Rectangle  = new Rectangle(0, 0, StageWidth, StageHeight);
            var screenSize:Rectangle = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
            var viewPort:Rectangle = RectangleUtil.fit(stageSize, screenSize, ScaleMode.SHOW_ALL);
            var scaleFactor:int = viewPort.width < 480 ? 1 : 2; // midway between 320 and 640

            Starling.multitouchEnabled = true; // useful on mobile devices
            Starling.handleLostContext = true; // recommended everywhere when using AssetManager
            RenderTexture.optimizePersistentBuffers = iOS; // safe on iOS, dangerous on Android

            mStarling = new Starling(Root, stage, viewPort, null, "auto", "auto");
            mStarling.stage.stageWidth    = StageWidth;  // <- same size on all devices!
            mStarling.stage.stageHeight   = StageHeight; // <- same size on all devices!
            mStarling.enableErrorChecking = Capabilities.isDebugger;
            mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
            {
                loadAssets(scaleFactor, startGame);
            });

            mStarling.start();
            initElements(scaleFactor);

            // When the game becomes inactive, we pause Starling; otherwise, the enter frame event
            // would report a very long 'passedTime' when the app is reactivated.

            if (!SystemUtil.isDesktop)
            {
                NativeApplication.nativeApplication.addEventListener(
                    flash.events.Event.ACTIVATE, function (e:*):void { mStarling.start(); });
                NativeApplication.nativeApplication.addEventListener(
                    flash.events.Event.DEACTIVATE, function (e:*):void { mStarling.stop(true); });
            }
        }

        private function loadAssets(scaleFactor:int, onComplete:Function):void
        {
            // Our assets are loaded and managed by the 'AssetManager'. To use that class,
            // we first have to enqueue pointers to all assets we want it to load.

            var appDir:File = File.applicationDirectory;
            var assets:AssetManager = new AssetManager(scaleFactor);
            assets.verbose = Capabilities.isDebugger;
			
            /*
			assets.enqueue(
                appDir.resolvePath("audio"),
                appDir.resolvePath(formatString("fonts/{0}x",    scaleFactor)),
                appDir.resolvePath(formatString("textures/{0}x", scaleFactor))
            );
			
			*/
			/*
			assets.enqueue(
       			"http://in-syst.ru/saveWords/audio/click.mp3",
				"http://in-syst.ru/saveWords/textures/2x/background.jpg",
				"http://in-syst.ru/saveWords/textures/2x/atlas.xml",
				"http://in-syst.ru/saveWords/textures/2x/atlas.png"
            );
			
			*/
			
			assets.enqueue(
       			"http://in-syst.ru/saveWords/audio/click.mp3",
				"http://in-syst.ru/saveWords/textures/2x/atlas.xml",
				"http://in-syst.ru/saveWords/textures/2x/atlas.png"
            );
			
			/*
			 var atlas_XML:XML=new XML(<TextureAtlas imagePath="atlas.png">
    <SubTexture name="button_normal" x="2" y="417" width="253" height="63"/>
    <SubTexture name="powered_by_starling" x="2" y="287" width="360" height="128"/>
    <SubTexture name="starling_rocket" x="2" y="2" width="512" height="283"/>
</TextureAtlas>);
			assets.addXml("atlas", atlas_XML);
			
			assets.enqueue(
						   click,
						   my_background,
						   atlas
						   );
			*/
			
			//appDir.resolvePath( "http://in-syst.ru/saveWords/audio/click.mp3"),

            // Now, while the AssetManager now contains pointers to all the assets, it actually
            // has not loaded them yet. This happens in the "loadQueue" method; and since this
            // will take a while, we'll update the progress bar accordingly.

            assets.loadQueue(function(ratio:Number):void
            {
                mProgressBar.ratio = ratio;
                if (ratio == 1) onComplete(assets);
            });
        }

		
        private function startGame(assets:AssetManager):void
        {
            var root:Root = mStarling.root as Root;
           	root.start(assets);
			//root.start(null);
            setTimeout(removeElements, 150); // delay to make 100% sure there's no flickering.
        }

        private function initElements(scaleFactor:int):void
        {
            // Add background image. By using "loadBytes", we can avoid any flickering.
/*
            var bgPath:String = formatString("textures/{0}x/background.jpg", scaleFactor);
            var bgFile:File = File.applicationDirectory.resolvePath(bgPath);
			var bytes:ByteArray = new ByteArray();
            var stream:FileStream = new FileStream();
            stream.open(bgFile, FileMode.READ);
            stream.readBytes(bytes, 0, stream.bytesAvailable);
            stream.close();
*/

           mBackground = new Loader();
		 
           // mBackground.loadBytes(bytes);
		   //mBackground.load(new URLRequest("http://in-syst.ru/saveWords/textures/2x/background.jpg"));
           
			mBackground.scaleX = 1.0 / scaleFactor;
            mBackground.scaleY = 1.0 / scaleFactor;
            mStarling.nativeOverlay.addChild(mBackground);

            mBackground.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,
                function(e:Object):void
                {
                    (mBackground.content as Bitmap).smoothing = true;
                });
			mBackground.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR,
                function(e:Object):void
                {
                   trace("gg");;
                });
														
            // While the assets are loaded, we will display a progress bar.

            mProgressBar = new ProgressBar(175, 20);
            mProgressBar.x = (StageWidth - mProgressBar.width) / 2;
            mProgressBar.y =  StageHeight * 0.7;
            mStarling.nativeOverlay.addChild(mProgressBar);
        }

        private function removeElements():void
        {
            if (mBackground)
            {
                mStarling.nativeOverlay.removeChild(mBackground);
                mBackground = null;
            }

            if (mProgressBar)
            {
                mStarling.nativeOverlay.removeChild(mProgressBar);
                mProgressBar = null;
            }
        }
    }
}