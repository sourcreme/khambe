//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import flambe.display.BlendMode;
import flambe.display.Texture;

import kha.math.FastMatrix3;
import kha.Color;

class KhaGraphics implements InternalGraphics
{
	public var nativeGraphics :kha.graphics2.Graphics;

	public function new (nativeGraphics :kha.graphics2.Graphics)
	{
		this.nativeGraphics = nativeGraphics;
		_stateList = new DrawingState();
	}

	public function translate (x :Float, y :Float)
	{
		_stateList.matrix = _stateList.matrix.multmat(FastMatrix3.translation(x,y));
	}

	public function scale (x :Float, y :Float)
	{
		_stateList.matrix = _stateList.matrix.multmat(FastMatrix3.scale(x,y));
	}

	public function rotate (rotation :Float)
	{
		_stateList.matrix = _stateList.matrix.multmat(FastMatrix3.rotation(rotation));
	}

	public function transform (m00 :Float, m10 :Float, m01 :Float, m11 :Float, m02 :Float, m12 :Float)
	{
		
		_stateList.matrix = _stateList.matrix.multmat(new FastMatrix3(m00, m01, m02, m10, m11, m12, 0, 0, 1));
	}

	public function drawTexture (texture :Texture, destX :Float, destY :Float)
	{
		drawSubTexture(texture, destX, destY, 0, 0, texture.width, texture.height);
	}

	public function drawSubTexture (texture :Texture, destX :Float, destY :Float, sourceX :Float, sourceY :Float, sourceW :Float, sourceH :Float)
	{
		prepareGraphics2D();
		var texture :KhaTexture = cast texture;
		var root = texture.root;
		root.assertNotDisposed();

		nativeGraphics.drawSubImage(root.nativeTexture, destX, destY, texture.rootX+sourceX, texture.rootY+sourceY, sourceW, sourceH);
	}

	public function drawPattern (texture :Texture, x :Float, y :Float, width :Float, height :Float)
	{
		trace("drawPattern");
	}

	public function fillRect (color :Int, x :Float, y :Float, width :Float, height :Float)
	{
		prepareGraphics2D();
		nativeGraphics.color = 0xFF000000 + color;
		nativeGraphics.fillRect(x, y, width, height);
		nativeGraphics.color = Color.White;
	}

	public function multiplyAlpha (factor :Float)
	{
		_stateList.alpha *= factor;
	}

	public function setAlpha (alpha :Float)
	{
		_stateList.alpha = alpha;
	}

	public function setBlendMode (blendMode :BlendMode)
	{
	}

	public function applyScissor (x :Float, y :Float, width :Float, height :Float)
	{
	}

	public function willRender ()
	{
		nativeGraphics.flush();
		nativeGraphics.clear(0x00000000);
		nativeGraphics.begin();
	}

	public function didRender ()
	{
		nativeGraphics.end();
	}

	public function onResize (width :Int, height :Int)
	{
	}

	public function save() : Void
	{
		var current = _stateList;
		var state = _stateList.next;

		if (state == null) {
			state = new DrawingState();
			state.prev = current;
			current.next = state;
		}

		state.matrix.setFrom(current.matrix);
		state.alpha = current.alpha;

		_stateList = state;
	}

	public function restore() : Void
	{
		_stateList = _stateList.prev;
	}

	public inline function prepareGraphics2D() : Void
	{
		nativeGraphics.transformation = _stateList.matrix;
		nativeGraphics.opacity = _stateList.alpha;
	}

	private var _stateList :DrawingState;
}

private class DrawingState
{
    public var matrix :FastMatrix3;
    public var alpha :Float;

    public var prev :DrawingState = null;
    public var next :DrawingState = null;

    public function new() : Void
    {
        matrix = FastMatrix3.identity();
        alpha = 1;
    }
}