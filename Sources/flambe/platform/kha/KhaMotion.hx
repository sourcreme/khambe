//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import flambe.input.Acceleration;
import flambe.input.Attitude;
import flambe.subsystem.MotionSystem;
import flambe.util.Signal1;

class KhaMotion implements MotionSystem
{
    public var accelerationSupported (get, null) :Bool;
    public var acceleration (default, null) :Signal1<Acceleration>;
    public var accelerationIncludingGravity (default, null) :Signal1<Acceleration>;

    public var attitudeSupported (get, null) :Bool;
    public var attitude (default, null) :Signal1<Attitude>;

    public static function shouldUse () :Bool
    {
        return false;
    }

    public function new ()
    {
        acceleration = new Signal1();

        var accelerationIncludingGravity = new HeavySignal1();
        this.accelerationIncludingGravity = accelerationIncludingGravity;

        attitude = new Signal1();
    }

    private function get_accelerationSupported () :Bool
    {
        return true;
    }

    private function get_attitudeSupported () :Bool
    {
        return false;
    }
}
