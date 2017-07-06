//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import haxe.io.Bytes;

import flambe.asset.AssetEntry;
import flambe.display.Texture;
import flambe.subsystem.RendererSystem;
import flambe.util.Value;
import flambe.util.Assert;
import kha.Image;

class KhaRenderer implements InternalRenderer<Image>
{
	public var type (get, null) :RendererType;
	public var maxTextureSize (get, null) :Int;
	public var hasGPU (get, null) :Value<Bool>;

	public var graphics :InternalGraphics = null;

	public function new (nativeGraphics :kha.graphics2.Graphics)
	{
		_hasGPU = new Value<Bool>(false);
		graphics = new KhaGraphics(nativeGraphics);
	}

	public function getCompressedTextureFormats () :Array<AssetFormat>
	{
		return [];
	}

	public function createCompressedTexture (format :AssetFormat, data :Bytes) :Texture
	{
		Assert.fail(); // Unsupported
		return null;
	}

	public function willRender () :Void
	{
		graphics.willRender();
	}

	public function didRender () :Void
	{
		graphics.didRender();
	}

	public function createTexture (width :Int, height :Int) :Texture
	{
		trace("KhaRenderer createTexture!");
		var root = new KhaTextureRoot(Image.create(width, height));
		return root.createTexture(width, height);
	}

	public function createGraphics (renderTarget :KhaTextureRoot) :KhaGraphics
	{
		trace("KhaRenderer createGraphics");
		return new KhaGraphics(renderTarget.nativeTexture.g2);
	}

	//thus
    //thus
    //thus
    //thus
	public function createTextureFromImage (image :Image) :Texture
	{
		trace("KhaRenderer createTextureFromImage");
		var root = new KhaTextureRoot(image);
		return root.createTexture(image.width, image.height);
	}

	private function get_type() : RendererType
	{
		return WebGL;
	}

	private function get_maxTextureSize() : Int
	{
		return Image.maxSize;
	}
	
	private function get_hasGPU() : Value<Bool>
	{
		return _hasGPU;
	}

	private var _hasGPU :Value<Bool>;
}
