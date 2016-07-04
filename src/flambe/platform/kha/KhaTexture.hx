//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import haxe.io.Bytes;

import flambe.display.Graphics;
import flambe.display.SubTexture;
import flambe.display.Texture;
import flambe.util.Assert;
import flambe.util.Value;

class KhaTexture extends BasicAsset<KhaTexture> implements SubTexture
{

	public var graphics (get, null) :Graphics;
	public var parent (get, null) :Texture;

	// The texture bounds
	public var x (get, null) :Int;
	public var y (get, null) :Int;
	public var width (get, null) :Int;
	public var height (get, null) :Int;

	public var root (default, null) :KhaTextureRoot;

	// The global position of this texture from the root
	public var rootX (default, null) :Int = 0;
	public var rootY (default, null) :Int = 0;

	public function new (root :KhaTextureRoot, width :Int, height :Int)
	{
		super();
		this.root = root;
		_width = width;
		_height = height;
	}

	public function readPixels (x :Int, y :Int, width :Int, height :Int) :Bytes
	{
		return root.readPixels(rootX+x, rootY+y, width, height);
	}

	public function writePixels (pixels :Bytes, x :Int, y :Int, sourceW :Int, sourceH :Int)
	{
		root.writePixels(pixels, rootX+x, rootY+y, sourceW, sourceH);
	}

	public function subTexture (x :Int, y :Int, width :Int, height :Int) :SubTexture
	{
		var sub :KhaTexture = cast root.createTexture(width, height);
		sub._parent = this;
		sub._x = x;
		sub._y = y;
		sub.rootX = rootX + x;
		sub.rootY = rootY + y;
		return sub;
	}

	public function split (tilesWide :Int, tilesHigh :Int = 1) :Array<SubTexture>
	{
		var tiles = [];
		var tileWidth = Std.int(_width / tilesWide);
		var tileHeight = Std.int(_height / tilesHigh);
		for (y in 0...tilesHigh) {
			for (x in 0...tilesWide) {
				tiles.push(subTexture(x*tileWidth, y*tileHeight, tileWidth, tileHeight));
			}
		}
		return tiles;
	}

	private function get_graphics () :Graphics
	{
		return root.getGraphics();
	}

	override private function copyFrom (that :KhaTexture)
	{
		this.root._disposed = false;
		this.root.copyFrom(that.root);

		this._width = that._width;
		this._height = that._height;

		// We don't support mutability on the position, since it invalidates the rootX/Y of child
		// subTextures. This assert should never fail with the asset reloader.
		Assert.that(
			this.rootX == that.rootX &&
			this.rootY == that.rootY &&
			this._x == that._x &&
			this._y == that._y);
	}

	override private function onDisposed ()
	{
		// Since subtextures shouldn't be able to accidently dispose their parents and siblings,
		// only dispose the root if this is the top-most subtexture.
		if (_parent == null) {
			root.dispose();
		}
	}

	override private function get_reloadCount () :Value<Int>
	{
		// Delegate to the root, so that root reloads get propogated to all subtextures
		return root.reloadCount;
	}

	inline private function get_parent () :Texture
	{
		return _parent;
	}

	inline private function get_x () :Int
	{
		return _x;
	}

	inline private function get_y () :Int
	{
		return _y;
	}

	inline private function get_width () :Int
	{
		return _width;
	}

	inline private function get_height () :Int
	{
		return _height;
	}

	private var _parent :KhaTexture = null;

	private var _x :Int = 0;
	private var _y :Int = 0;
	private var _width :Int;
	private var _height :Int;
}
