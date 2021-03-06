package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
	
    import starling.core.Starling;
    import starling.events.Event;
    import starling.textures.RenderTexture;
    import starling.utils.AssetManager;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;
    import starling.utils.SystemUtil;
    import starling.utils.formatString;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

    [SWF(width="320", height="480", frameRate="30", backgroundColor="#000000")]
    public class Main extends Sprite
    {
		//Вставка текстур
		[Embed(source = "../assets/assets.png")] private var texture:Class;
		private static var xml:XML=new XML(
<TextureAtlas imagePath="assets.png">
	<!-- Created with Adobe Flash CS6 version 12.0.0.481 -->
	<!-- http://www.adobe.com/products/flash.html -->
	<SubTexture name="back0000" x="0" y="0" width="40" height="40"/>
	<SubTexture name="border0000" x="40" y="0" width="181" height="35"/>
	<SubTexture name="buttom_reg0000" x="221" y="0" width="203" height="50"/>
	<SubTexture name="button10000" x="0" y="50" width="162" height="50"/>
	<SubTexture name="button_in0000" x="162" y="50" width="109" height="50"/>
	<SubTexture name="button_ok0000" x="271" y="50" width="92" height="50"/>
	<SubTexture name="my_background0000" x="0" y="100" width="320" height="480"/>
	<SubTexture name="sex0000" x="320" y="100" width="61" height="60"/>
	<SubTexture name="sex0001" x="381" y="100" width="61" height="60"/>
</TextureAtlas>


);
		[Embed(source="../assets/click.mp3")] private var my_sound:Class;
        private const StageWidth:int  = Constants.STAGE_WIDTH;
        private const StageHeight:int = Constants.STAGE_HEIGHT;

        private var mStarling:Starling;

        public function Main()
        {
            // Создание и оптимизация сцены
            var iOS:Boolean = SystemUtil.platform == "IOS";
            var stageSize:Rectangle  = new Rectangle(0, 0, StageWidth, StageHeight);
            var screenSize:Rectangle = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
            var viewPort:Rectangle = RectangleUtil.fit(stageSize, screenSize, ScaleMode.SHOW_ALL);
            var scaleFactor:int = viewPort.width < 480 ? 1 : 2; // midway between 320 and 640

            Starling.multitouchEnabled = true; // useful on mobile devices
            Starling.handleLostContext = true; // recommended everywhere when using AssetManager
            RenderTexture.optimizePersistentBuffers = iOS; // safe on iOS, dangerous on Android
			
			// создание старлинга
            mStarling = new Starling(Root, stage, viewPort, null, "auto", "auto");
            mStarling.stage.stageWidth    = StageWidth;  // <- same size on all devices!
            mStarling.stage.stageHeight   = StageHeight; // <- same size on all devices!
            mStarling.enableErrorChecking = Capabilities.isDebugger;
            mStarling.start();
			
			// при сворачивании останавливаем старлинг
            if (!SystemUtil.isDesktop)
            {
                 mStarling.start();
     ;
            }
			
			// при создании сцены
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
            {
				// загрузчик
				var assets:AssetManager = new AssetManager(scaleFactor);
				assets.verbose = Capabilities.isDebugger;
				// добавляем текстуры и звук
				assets.addTextureAtlas("assets", new TextureAtlas(Texture.fromData(texture), xml));
				assets.addSound("click", new my_sound());
				var root:Root = mStarling.root as Root;
				// запускаем!
				root.start(assets);
			});
			
		}

    }
}