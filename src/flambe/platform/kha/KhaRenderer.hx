//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import haxe.io.Bytes;

import flambe.asset.AssetEntry;
import flambe.display.Graphics;
import flambe.display.Texture;
import flambe.subsystem.RendererSystem;
import flambe.util.Assert;
import flambe.util.Value;

class KhaRenderer implements InternalRenderer<kha.Image>
{
	public var graphics :InternalGraphics;
	public var type (get, null) :RendererType;
	public var maxTextureSize (get, null) :Int;
	public var hasGPU (get, null) :Value<Bool>;

	public function new() : Void
	{
		graphics = new KhaGraphics(kha.Image.createRenderTarget(System.stage.width, System.stage.height));
		_hasGPU = new Value<Bool>(true);
	}

	public function createTexture (width :Int, height :Int) :Texture
	{
		var root = new KhaTextureRoot(kha.Image.create(width, height));
		return root.createTexture(width, height);
	}

	public function createTextureFromImage (image :kha.Image) :Texture
	{
		var root = new KhaTextureRoot(image);
		return root.createTexture(root.width, root.height);
	}

	public function getCompressedTextureFormats () :Array<AssetFormat>
	{
		Assert.fail();
		return [];
	}

	public function createCompressedTexture (format :AssetFormat, data :Bytes) :Texture
	{
		Assert.fail();
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

	private inline function get_type() : RendererType
	{
		return Kha;
	}

	private inline function get_maxTextureSize() : Int
	{
		return 1024;
	}

	private inline function get_hasGPU() : Value<Bool>
	{
		return _hasGPU;
	}

	private var _hasGPU :Value<Bool>;
}
