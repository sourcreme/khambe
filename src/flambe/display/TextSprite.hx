//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.display;

import flambe.animation.AnimatedFloat;
import flambe.display.Font;
import flambe.math.FMath;

using flambe.util.BitSets;

/**
 * A sprite that displays a line of text using a bitmap font.
 */
class TextSprite extends Sprite
{
	public var text  (get, set) :String;
	public var font  (get, set) :Font;
	public var align (get, set) :TextAlign;
	public var color :Int;
	public var size  :Int;

	public var wrapWidth     (default, null) :AnimatedFloat;
	public var letterSpacing (default, null) :AnimatedFloat;
	public var lineSpacing   (default, null) :AnimatedFloat;

	public function new (font :Font, color :Int, size :Int, ?text :String = "")
	{
		super();

		this.font = font;
		this.color = color;
		this.text = text;
		this.size = size;
		pipeline = flambe.platform.kha.KhaPipeline.textPipeline;

		wrapWidth = new AnimatedFloat(0);
		letterSpacing = new AnimatedFloat(0);
		lineSpacing = new AnimatedFloat(0);
	}

	override public function draw (g :Graphics)
	{
		g.drawText(font, text, color, size, 0, 0);
	}

	override public function getNaturalWidth () :Float
	{
		return font.nativeFont.width(size, text);
	}

	override public function getNaturalHeight () :Float
	{
		return font.nativeFont.height(size);
	}

	public function setWrapWidth (wrapWidth :Float) :TextSprite
	{
		this.wrapWidth._ = wrapWidth;
		return this;
	}

	public function setLetterSpacing (letterSpacing :Float) :TextSprite
	{
		this.letterSpacing._ = letterSpacing;
		return this;
	}

	public function setLineSpacing (lineSpacing :Float) :TextSprite
	{
		this.lineSpacing._ = lineSpacing;
		return this;
	}

	public function setAlign (align :TextAlign) :TextSprite
	{
		this.align = align;
		return this;
	}

	override public function onUpdate (dt :Float)
	{
		super.onUpdate(dt);
		wrapWidth.update(dt);
		letterSpacing.update(dt);
		lineSpacing.update(dt);
	}

	private inline function set_align(align :TextAlign) :TextAlign
	{
		return null;
	}

	private inline function get_align() :TextAlign
	{
		return null;
	}

	private inline function set_font(font :Font) :Font
	{
		return _font = font;
	}

	private inline function get_font() :Font
	{
		return _font;
	}

	private inline function set_text(text :String) :String
	{
		return _text = text;
	}

	private inline function get_text() :String
	{
		return _text;
	}



	private var _font :Font;
	private var _text :String;

}
