//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import flambe.display.Graphics;
import flambe.display.Texture;
import haxe.io.Bytes;

import flambe.math.FMath;

class KhaTextureRoot extends BasicAsset<KhaTextureRoot> implements TextureRoot
{
	public var width (default, null) :Int;
	public var height (default, null) :Int;
	public var image (default, null) :kha.Image;

	public function new(image :kha.Image) : Void
	{
		super();

		this.image = image;
		this.width = image.width;
		this.height = image.height;
	}

	public function createTexture (width :Int, height :Int) :KhaTexture
	{
		return new KhaTexture(this, width, height);
	}

	public function readPixels (x :Int, y :Int, width :Int, height :Int) :Bytes
	{
		return null;
	}

	public function writePixels (pixels :Bytes, x :Int, y :Int, sourceW :Int, sourceH :Int) :Void
	{
	}

	public function getGraphics () :Graphics
	{
		if(_graphics == null) {
			_graphics = new KhaGraphics(this.image);
		}
		return _graphics;
	}

	override private function onDisposed ()
	{
		image.unload();
		image = null;
	}

	private var _graphics :Graphics;
}
