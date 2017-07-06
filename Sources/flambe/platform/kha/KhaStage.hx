//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;


import flambe.display.Orientation;
import flambe.subsystem.StageSystem;
import flambe.util.Signal0;
import flambe.util.Value;

class KhaStage implements StageSystem
{
	public var width (get, null) :Int;
	public var height (get, null) :Int;
	public var orientation (default, null) :Value<Orientation>;
	public var fullscreen (default, null) :Value<Bool>;
	public var fullscreenSupported (get, null) :Bool;

	public var resize (default, null) :Signal0;

	public function new (nativeStage :Dynamic)
	{
		resize = new Signal0();

		fullscreen = new Value<Bool>(false);
		orientation = new Value<Orientation>(null);
	}

	public function get_width () :Int
	{
		return kha.System.windowWidth();
	}

	public function get_height () :Int
	{
		return kha.System.windowHeight();
	}

	public function get_fullscreenSupported () :Bool
	{
		return false;
	}

	public function lockOrientation (orient :Orientation)
	{
	}

	public function unlockOrientation ()
	{
	}

	public function requestResize (width :Int, height :Int)
	{
	}

	public function requestFullscreen (enable :Bool = true)
	{
	}
}
