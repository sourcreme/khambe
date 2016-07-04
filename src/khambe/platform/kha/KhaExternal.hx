
//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.platform.kha;

import khambe.subsystem.ExternalSystem;

class KhaExternal implements ExternalSystem
{
	public var supported (get, null) :Bool;

	public function new() : Void
	{

	}

	public function call (name :String, ?params :Array<Dynamic>) : Dynamic
	{
		return null;
	}

	public function bind (name :String, fn :Dynamic) : Void
	{

	}

	private inline function get_supported() : Bool
	{
		return false;
	}
}