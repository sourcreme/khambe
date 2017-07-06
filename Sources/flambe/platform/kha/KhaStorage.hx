//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import haxe.Serializer;
import haxe.Unserializer;

import flambe.subsystem.StorageSystem;

class KhaStorage implements StorageSystem
{
    public var supported (get, null) :Bool;

    public function new (so :Dynamic)
    {
    }

    public function get_supported () :Bool
    {
        return true;
    }

    public function set (key :String, value :Dynamic) :Bool
    {
        return false;
    }

    public function get<A> (key :String, defaultValue :A = null) :A
    {
        return null;
    }

    public function remove (key :String)
    {
    }

    public function clear ()
    {
    }
}
