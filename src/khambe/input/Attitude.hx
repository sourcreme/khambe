//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.input;

/**
 * Three angles that represent the device's attitude, one around each axis.
 *
 * <img src="https://aduros.com/flambe/images/Axes.png">
 */
class Attitude
{
	/**
	 * The angle in degrees around the X-axis; that is, how far the device is pitched forward or
	 * backward.
	 *
	 * <img src="https://aduros.com/flambe/images/Axes-Pitch.png">
	 */
	public var pitch (default, null) :Float;

	/**
	 * The angle in degrees around the Y-axis; that is, how far the device is rolled left or right.
	 *
	 * <img src="https://aduros.com/flambe/images/Axes-Roll.png">
	 */
	public var roll (default, null) :Float;

	/**
	 * The angle in degrees around the Z-axis.
	 *
	 * <img src="https://aduros.com/flambe/images/Axes-Azimuth.png">
	 */
	public var azimuth (default, null) :Float;

	@:allow(khambe) function new ()
	{
		init(0, 0, 0);
	}

	@:allow(khambe) function init (pitch :Float, roll :Float, azimuth :Float)
	{
		this.pitch = pitch;
		this.roll = roll;
		this.azimuth = azimuth;
	}
}
