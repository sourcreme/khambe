//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.platform.kha;

import khambe.display.BlendMode;
import khambe.display.Pipeline;
import khambe.display.Font;
import khambe.display.Graphics;
import khambe.display.Texture;
import khambe.math.FMath;
import khambe.math.Matrix;
import khambe.math.Rectangle;
import khambe.util.Assert;
import khambe.System;
import khambe.platform.kha.KhaPipeline;
import kha.arrays.Float32Array;
import kha.graphics4.BlendingFactor;

class KhaGraphics implements InternalGraphics
{
	public var backbuffer :kha.Image;

	public function new(image :kha.Image) : Void
	{
		backbuffer = image;
		_stateList = new DrawingState();
	}

	public function willRender () :Void
	{
		prepareGraphics2D();
		backbuffer.g2.begin(true, kha.Color.Black);
	}

	public function didRender () : Void
	{
		backbuffer.g2.end();
	}

	public function onResize (width :Int, height :Int) : Void
	{
	}

	public function save () : Void
	{
		var current = _stateList;
		var state = _stateList.next;

		if (state == null) {
			state = new DrawingState();
			state.prev = current;
			current.next = state;
		}

		current.matrix.clone(state.matrix);
		state.alpha = current.alpha;
		state.blendMode = current.blendMode;
		state.pipeline = current.pipeline;
		// state.scissor = current.scissor;
		_stateList = state;
	}

	public function restore () : Void
	{
		Assert.that(_stateList.prev != null, "Can't restore without a previous save");
		_stateList = _stateList.prev;
	}

	public function translate (x :Float, y :Float) : Void
	{
		var matrix = getTopState().matrix;
		matrix.m02 += matrix.m00*x + matrix.m01*y;
		matrix.m12 += matrix.m10*x + matrix.m11*y;
	}

	public function scale (x :Float, y :Float) : Void
	{
		var matrix = getTopState().matrix;
		matrix.m00 *= x;
		matrix.m10 *= x;
		matrix.m01 *= y;
		matrix.m11 *= y;
	}

	public function rotate (rotation :Float) : Void
	{
		var matrix = getTopState().matrix;
		rotation = FMath.toRadians(rotation);
		var sin = Math.sin(rotation);
		var cos = Math.cos(rotation);
		var m00 = matrix.m00;
		var m10 = matrix.m10;
		var m01 = matrix.m01;
		var m11 = matrix.m11;

		matrix.m00 = m00*cos + m01*sin;
		matrix.m10 = m10*cos + m11*sin;
		matrix.m01 = m01*cos - m00*sin;
		matrix.m11 = m11*cos - m10*sin;
	}

	public function transform (m00 :Float, m10 :Float, m01 :Float, m11 :Float, m02 :Float, m12 :Float) : Void
	{
		var state = getTopState();
		_scratchMatrix.set(m00, m10, m01, m11, m02, m12);
		Matrix.multiply(state.matrix, _scratchMatrix, state.matrix);
	}

	public function multiplyAlpha (factor :Float) : Void
	{
		getTopState().alpha *= factor;
	}

	public function setAlpha (alpha :Float) : Void
	{
		getTopState().alpha = alpha;
	}

	public function setBlendMode (blendMode :BlendMode) : Void
	{
		getTopState().blendMode = blendMode;
	}

	public function setPipeline(pipeline :Pipeline) :Void
	{
		getTopState().pipeline = pipeline;
	}

	public function applyScissor (x :Float, y :Float, width :Float, height :Float) : Void
	{
	}

	public function drawTexture (texture :Texture, destX :Float, destY :Float, ?color :Int = 0xFFFFFFFF) : Void
	{
		drawSubTexture(texture, destX, destY, 0, 0, texture.width, texture.height, color);
	}

	public function drawSubTexture (texture :Texture, destX :Float, destY :Float, sourceX :Float, sourceY :Float, sourceW :Float, sourceH :Float, ?color :Int = 0xFFFFFFFF) : Void
	{
		prepareGraphics2D();
		var texture :KhaTexture = cast texture;
		var root = texture.root;
		root.assertNotDisposed();

		backbuffer.g2.color = color;
		backbuffer.g2.drawSubImage(root.image, destX, destY, texture.rootX+sourceX, texture.rootY+sourceY, sourceW, sourceH);
	}

	public function drawPattern (texture :Texture, destX :Float, destY :Float, width :Float, height :Float) : Void
	{
		trace("drawPattern NOT IMPLEMENTED yet!");
	}

	public function fillRect (color :Int, x :Float, y :Float, width :Float, height :Float) : Void
	{
		prepareGraphics2D();

		backbuffer.g2.color = 0xFF000000 + color;
		backbuffer.g2.fillRect(x, y, width, height);
		backbuffer.g2.color = kha.Color.White;
	}

	public function drawText (font :Font, text :String, color :Int, size :Int, destX :Float, destY :Float) : Void
	{
		prepareGraphics2D();

		backbuffer.g2.color = 0xFF000000 + color;
		backbuffer.g2.font = font.nativeFont;
		backbuffer.g2.fontSize = size;
		backbuffer.g2.drawString(text, destX, destY);
		backbuffer.g2.color = kha.Color.White;
	}

	public inline function getMatrix() : Matrix
	{
		return getTopState().matrix;
	}

	public function prepareGraphics2D() : Void
	{
		var matrix = getTopState().matrix;
		backbuffer.g2.opacity = getTopState().alpha;
		backbuffer.g2.transformation = new kha.math.FastMatrix3(
			matrix.m00, matrix.m01, matrix.m02,
			matrix.m10, matrix.m11, matrix.m12,
			0, 0, 1
		);

		// if(getTopState().scissor.hasScissor) {
		// 	var scissor = getTopState().scissor;
		// 	var y =  System.stage.height - scissor.y - scissor.height;
		// 	backbuffer.g2.scissor(scissor.x, y, scissor.width, scissor.height);
		// }

		if(getTopState().pipeline != null) {
			if(_curBlendMode != getTopState().blendMode || _curPipeline != getTopState().pipeline.name) {
				_curBlendMode = getTopState().blendMode;
				_curPipeline = getTopState().pipeline.name;
				backbuffer.g2.pipeline = getTopState().pipeline.pipelineState;

				switch (getTopState().blendMode) {
					case Normal:
						backbuffer.g2.pipeline.blendSource = BlendingFactor.SourceAlpha;
						backbuffer.g2.pipeline.blendDestination = BlendingFactor.InverseSourceAlpha; //done
						backbuffer.g2.pipeline.alphaBlendSource = BlendingFactor.SourceAlpha;
						backbuffer.g2.pipeline.alphaBlendDestination = BlendingFactor.InverseSourceAlpha;
					case Add:
						backbuffer.g2.pipeline.blendSource = BlendingFactor.BlendOne;
						backbuffer.g2.pipeline.blendDestination = BlendingFactor.BlendOne; //done
						backbuffer.g2.pipeline.alphaBlendSource = BlendingFactor.SourceAlpha;
						backbuffer.g2.pipeline.alphaBlendDestination = BlendingFactor.InverseSourceAlpha;
					case Copy:
						backbuffer.g2.pipeline.blendSource = BlendingFactor.BlendOne;
						backbuffer.g2.pipeline.blendDestination = BlendingFactor.BlendZero; //not checked
						backbuffer.g2.pipeline.alphaBlendSource = BlendingFactor.SourceAlpha;
						backbuffer.g2.pipeline.alphaBlendDestination = BlendingFactor.InverseSourceAlpha;
					case Mask:
						backbuffer.g2.pipeline.blendSource = BlendingFactor.BlendZero;
						backbuffer.g2.pipeline.blendDestination = BlendingFactor.SourceAlpha; //not checked
						backbuffer.g2.pipeline.alphaBlendSource = BlendingFactor.SourceAlpha;
						backbuffer.g2.pipeline.alphaBlendDestination = BlendingFactor.InverseSourceAlpha;
					case Multiply:
						backbuffer.g2.pipeline.blendSource = BlendingFactor.SourceAlpha;
						backbuffer.g2.pipeline.blendDestination = BlendingFactor.InverseSourceAlpha; //done
						backbuffer.g2.pipeline.alphaBlendSource = BlendingFactor.SourceAlpha;
						backbuffer.g2.pipeline.alphaBlendDestination = BlendingFactor.InverseSourceAlpha;
					case Screen:
						backbuffer.g2.pipeline.blendSource = BlendingFactor.BlendOne;
						backbuffer.g2.pipeline.blendDestination = BlendingFactor.InverseSourceColor; //done
						backbuffer.g2.pipeline.alphaBlendSource = BlendingFactor.SourceAlpha;
						backbuffer.g2.pipeline.alphaBlendDestination = BlendingFactor.InverseSourceAlpha;
					case Fancy:
						backbuffer.g2.pipeline.blendSource = BlendingFactor.BlendOne;
						backbuffer.g2.pipeline.blendDestination = BlendingFactor.BlendOne; //done
						backbuffer.g2.pipeline.alphaBlendSource = BlendingFactor.InverseSourceColor;
						backbuffer.g2.pipeline.alphaBlendDestination = BlendingFactor.InverseSourceAlpha;
				}
			}
		}
	}

	private inline function getTopState () : DrawingState
	{
		return _stateList;
	}

	private var _stateList :DrawingState = null;
	private var _curBlendMode :BlendMode;
	private var _curPipeline  :String;

	@:allow(khambe.platform.kha.KhaPlatform) private var _xOffset :Float = 0;
	@:allow(khambe.platform.kha.KhaPlatform) private var _yOffset :Float = 0;
	@:allow(khambe.platform.kha.KhaPlatform) private var _scaleOffset :Float = 1;
	@:allow(khambe.platform.kha.KhaPlatform) private var _heightOffset :Float = 0;

	private static var _scratchMatrix = new Matrix();
}

private class DrawingState
{
	public var matrix :Matrix;
	public var alpha :Float;
	public var blendMode :BlendMode;
	public var pipeline :Pipeline;

	public var prev :DrawingState = null;
	public var next :DrawingState = null;

	public function new ()
	{
		matrix = new Matrix();
		alpha = 1;
		blendMode = Normal;
	}
}


