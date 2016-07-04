//
// flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.display;

import flambe.asset.AssetPack;


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