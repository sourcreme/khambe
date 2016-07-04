//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.display;

/**
 * A fixed-size sprite that displays a single texture.
 */
class ImageSprite extends Sprite
{
	/**
	 * The texture being displayed, or null if none.
	 */
	public var texture :Texture;
	public var color (default, set):Int;

	public function new (texture :Texture, color :Int = 0xFFFFFF)
	{
		super();
		this.texture = texture;
		this.color = color;
		pipeline = khambe.platform.kha.KhaPipeline.imagePipeline;
	}

	override public function draw (g :Graphics)
	{
		if (texture != null) {
			g.drawTexture(texture, 0, 0, color);
		}
	}

	override public function getNaturalWidth () :Float
	{
		return (texture != null) ? texture.width : 0;
	}

	override public function getNaturalHeight () :Float
	{
		return (texture != null) ? texture.height : 0;
	}

	private inline function set_color(color :Int) :Int
	{
		return this.color = 0xFF000000 + color;
	}
}
