//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;


class KhaCatapultClient extends CatapultClient
{
    public static function canUse () :Bool
    {
        return false;
    }

    public function new ()
    {
        super();
    }

    override private function onRestart ()
    {
    }
}
