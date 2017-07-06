//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import flambe.util.Logger;

class KhaLogHandler implements LogHandler
{
    public function new (tag :String)
    {
    }

    public function log (level :LogLevel, message :String)
    {
        var levelPrefix = switch (level) {
            case Info: "INFO";
            case Warn: "WARN";
            case Error: "ERROR";
        }
    }

    private var _tagPrefix :String;
    private var _trace :String -> Void;
}
