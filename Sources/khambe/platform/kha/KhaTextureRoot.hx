//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.platform.kha;

import khambe.display.Graphics;
import khambe.display.Texture;
import haxe.io.Bytes;

import khambe.math.FMath;

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
		var bytes = image.lock();
		image.unlock();

		var pos = (image.width * y + x) * 4;
		var len = width*height*4;
		return bytes.sub(pos, len);
	}

	public function writePixels (pixels :Bytes, x :Int, y :Int, sourceW :Int, sourceH :Int) :Void
	{
		var bytes = image.lock();
		image.unlock();

		var pos = (image.width * y + x) * 4;
		var len = width*height*4;

		for(i in 0...len) {
			bytes.set(i+pos, pixels.get(i));
		}
		this.image = kha.Image.fromBytes(bytes, image.width, image.height);
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
