//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import haxe.io.Bytes;
import kha.Image;
import flambe.math.FMath;

class KhaTextureRoot extends BasicAsset<KhaTextureRoot> implements TextureRoot
{
    // The power of two dimensions of the texture
    public var width (default, null) :Int;
    public var height (default, null) :Int;

    public var nativeTexture (default, null) :kha.Image;

    public function new (image :Image)
    {
        super();
        nativeTexture = image;
        this.width = image.width;
        this.height = image.height;
    }

    public function init ()
    {
        assertNotDisposed();
    }

    //thus
    //thus
    //thus
    //thus
    public function createTexture (width :Int, height :Int) :KhaTexture
    {
        trace("KhaTextureRoot createTexture!");
        return new KhaTexture(this, width, height);
    }

    public function readPixels (x :Int, y :Int, width :Int, height :Int) :Bytes
    {
        trace("KhaTextureRoot readPixels");
        return nativeTexture.getPixels();
    }

    public function writePixels (pixels :Bytes, x :Int, y :Int, sourceW :Int, sourceH :Int)
    {
        trace("KhaTextureRoot writePixels");
    }

    public function getGraphics () :KhaGraphics
    {
        assertNotDisposed();
        trace("KhaTextureRoot getGraphics");
        if (_graphics == null) {
            _graphics = _renderer.createGraphics(this);
            _graphics.onResize(width, height);
        }
        return _graphics;
    }

    override private function copyFrom (that :KhaTextureRoot)
    {
        trace("KhaTextureRoot copyFrom");
        this.nativeTexture = that.nativeTexture;
        this.width = that.width;
        this.height = that.height;
        this._graphics = that._graphics;
    }

    override private function onDisposed ()
    {
        nativeTexture.unload();
        nativeTexture = null;
        _graphics = null;
    }

    private var _graphics :KhaGraphics;
    private var _renderer :KhaRenderer;
    
}
