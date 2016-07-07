//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.platform.kha;

import khambe.display.Orientation;
import khambe.subsystem.StageSystem;
import khambe.util.Signal0;
import khambe.util.Value;

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
		_width = kha.System.windowWidth();
		_height = kha.System.windowHeight();
	}

	public function lockOrientation (orient :Orientation) : Void
	{

	}

	public function unlockOrientation () : Void
	{

	}

	public function requestResize (width :Int, height :Int) : Void
	{
		if(_width != width || _height != height) {
			_width = width;
			_height = height;
		}
	}

	public function requestFullscreen (enable :Bool = true) : Void
	{
		//depends on platform SystemImpl
	}

	private inline function get_width() : Int
	{
		return _width;
	}

	private inline function get_height() : Int
	{
		return _height;
	}

	private inline function get_fullscreenSupported() : Bool
	{
		return false;
	}

	private var _width  :Int;
	private var _height :Int;
}




