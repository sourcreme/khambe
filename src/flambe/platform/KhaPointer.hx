//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform;

import flambe.display.Sprite;
import flambe.input.PointerEvent;
import flambe.math.Point;
import flambe.scene.Director;
import flambe.subsystem.PointerSystem;
import flambe.util.Signal1;

class KhaPointer extends BasicPointer
{
	public function new (x :Float = 0, y :Float = 0, isDown :Bool = false)
	{
		super(x, y, isDown);

		function onMouseDown(button:Int, x:Int, y:Int) {
			x = Std.int((x-_xOffset) / _scale);
			y = Std.int((y-_yOffset) / _scale);
			submitDown(x,y,Mouse(null));
		};

		function onMouseUp(button:Int, x:Int, y:Int) {
			x = Std.int((x-_xOffset) / _scale);
			y = Std.int((y-_yOffset) / _scale);
			submitUp(x,y,Mouse(null));
		};

		function onMouseMove(x:Int, y:Int, cx:Int, cy:Int) {
			x = Std.int((x-_xOffset) / _scale);
			y = Std.int((y-_yOffset) / _scale);
			submitMove(x,y,Mouse(null));
		};

		kha.input.Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove, null);
	}


	@:allow(flambe.platform.kha.KhaPlatform) private var _xOffset :Float = 0;
	@:allow(flambe.platform.kha.KhaPlatform) private var _yOffset :Float = 0;
	@:allow(flambe.platform.kha.KhaPlatform) private var _scale :Float = 1;
}
