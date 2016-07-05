//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.input;

/**
 * A 3D vector that represents the linear acceleration being applied to the device.
 *
 * <img src="https://aduros.com/flambe/images/Axes.png">
 */
class Acceleration
{
	/** The acceleration on the X-axis, in m/s^2. */
	public var x (default, null) :Float;

	/** The acceleration on the Y-axis, in m/s^2. */
	public var y (default, null) :Float;

	/** The acceleration on the Z-axis, in m/s^2. */
	public var z (default, null) :Float;

	@:allow(khambe) function new ()
	{
		init(0, 0, 0);
	}

	@:allow(khambe) function init (x :Float, y :Float, z :Float)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}
}
