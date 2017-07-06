//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import flambe.subsystem.ExternalSystem;

class KhaExternal implements ExternalSystem
{
    public var supported (get, null) :Bool;

    public function new ()
    {
    }

    public static function shouldUse () :Bool
    {
        return false;
    }

    public function get_supported ()
    {
        return true;
    }

    public function call (name :String, ?params :Array<Dynamic>) :Dynamic
    {
        return null;
    }

    public function bind (name :String, fn :Dynamic)
    {
    }
}
