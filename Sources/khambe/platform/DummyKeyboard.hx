//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.platform;

import khambe.input.Key;
import khambe.input.KeyboardEvent;
import khambe.subsystem.KeyboardSystem;
import khambe.util.Signal0;
import khambe.util.Signal1;

using khambe.platform.KeyCodes;

class DummyKeyboard
	implements KeyboardSystem
{
	public var supported (get, null) :Bool;

	public var down (default, null) :Signal1<KeyboardEvent>;
	public var up (default, null) :Signal1<KeyboardEvent>;
	public var backButton (default, null) :Signal0;

	public function new ()
	{
		down = new Signal1();
		up = new Signal1();
		backButton = new Signal0();
	}

	public function get_supported () :Bool
	{
		return false;
	}

	public function isDown (key :Key) :Bool
	{
		return false;
	}
}
