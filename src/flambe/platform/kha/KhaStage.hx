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

	public function new() : Void
	{

	}

	public function lockOrientation (orient :Orientation) : Void
	{

	}

	public function unlockOrientation () : Void
	{

	}

	public function requestResize (width :Int, height :Int) : Void
	{

	}

	public function requestFullscreen (enable :Bool = true) : Void
	{

	}

	private inline function get_width() : Int
	{
		return kha.System.windowWidth();
	}

	private inline function get_height() : Int
	{
		return kha.System.windowHeight();
	}

	private inline function get_fullscreenSupported() : Bool
	{
		return false;
	}
}




