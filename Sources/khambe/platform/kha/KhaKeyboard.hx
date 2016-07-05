//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.platform.kha;


class KhaKeyboard extends BasicKeyboard
{
	public function new() : Void
	{
		super();

		kha.input.Keyboard.get().notify(onKeyDown, onKeyUp);
	}

	public function onKeyDown(key :kha.Key, value :String) : Void
	{
		submitDown(value.toUpperCase().charCodeAt(0));
	}
	
	public function onKeyUp(key :kha.Key, value :String) : Void
	{
		submitUp(value.toUpperCase().charCodeAt(0));
	}
}