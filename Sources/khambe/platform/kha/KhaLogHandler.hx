//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.platform.kha;

import khambe.util.Logger;

class KhaLogHandler implements LogHandler
{
	public function new (tag :String)
	{
		_tagPrefix = tag + ": ";
	}

	public function log (level :LogLevel, message :String)
	{
		message = _tagPrefix + message;

#if js
		switch (level) {
			case Info:
				(untyped __js__("console")).info(message);
			case Warn:
				(untyped __js__("console")).warn(message);
			case Error:
				(untyped __js__("console")).error(message);
		}
#end
	}

	private var _tagPrefix :String;
}
