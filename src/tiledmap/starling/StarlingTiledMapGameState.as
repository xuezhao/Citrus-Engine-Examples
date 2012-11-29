package tiledmap.starling {

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import com.citrusengine.core.StarlingState;
	import com.citrusengine.math.MathVector;
	import com.citrusengine.objects.platformer.box2d.Hero;
	import com.citrusengine.objects.platformer.box2d.Platform;
	import com.citrusengine.physics.box2d.Box2D;
	import com.citrusengine.utils.objectmakers.ObjectMakerStarling;
	import com.citrusengine.view.starlingview.StarlingArt;

	import flash.display.Bitmap;
	import flash.geom.Rectangle;

	/**
	 * @author Aymeric
	 */
	public class StarlingTiledMapGameState extends StarlingState {

		[Embed(source="/../embed/tiledmap/map-atlas.tmx", mimeType="application/octet-stream")]
		private const _Map:Class;

		[Embed(source="/../embed/tiledmap/Genetica-tiles-atlas.xml", mimeType="application/octet-stream")]
		private const _MapAtlasConfig:Class;

		[Embed(source="/../embed/tiledmap/Genetica-tiles-atlas.png")]
		private const _MapAtlasPng:Class;

		public function StarlingTiledMapGameState() {
			super();
			
			// Useful for not forgetting to import object from the Level Editor
			var objects:Array = [Hero, Platform];
		}

		override public function initialize():void {

			super.initialize();

			var box2D:Box2D = new Box2D("box2D");
			// box2D.visible = true;
			add(box2D);

			var bitmap:Bitmap = new _MapAtlasPng();
			var texture:Texture = Texture.fromBitmap(bitmap);
			var xml:XML = XML(new _MapAtlasConfig());
			var sTextureAtlas:TextureAtlas = new TextureAtlas(texture, xml);

			ObjectMakerStarling.FromTiledMap(XML(new _Map()), sTextureAtlas);

			var hero:Hero = getObjectByName("hero") as Hero;

			view.setupCamera(hero, new MathVector(stage.stageWidth / 2, 240), new Rectangle(0, 0, 1280, 640), new MathVector(.25, .05));

			(view.getArt(getObjectByName("foreground")) as StarlingArt).alpha = 0.3;
		}
	}
}
