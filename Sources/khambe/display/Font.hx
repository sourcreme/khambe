//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.display;

import khambe.asset.AssetPack;


class Font
{
	public var nativeFont :kha.Font;

	public function new(pack :AssetPack, name :String) : Void
	{
		nativeFont = pack.getFont(name);
	}
}

enum TextAlign
{
    Left;
    Center;
    Right;
}