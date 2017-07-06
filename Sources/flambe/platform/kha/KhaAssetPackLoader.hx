//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import flambe.asset.AssetEntry;
import flambe.asset.Manifest;
import flambe.util.Assert;

using flambe.util.Strings;
using StringTools;

class KhaAssetPackLoader extends BasicAssetPackLoader
{
	public function new (platform :KhaPlatform, manifest :Manifest)
	{
		super(platform, manifest);
	}

	override private function loadEntry (url :String, entry :AssetEntry)
	{
		var itemName = url.substr(url.lastIndexOf("/") + 1);
		if(Std.parseInt(itemName.charAt(0)) != null)
			itemName = "_" + itemName;

		switch (entry.format) {
			case JXR, PNG, JPG, GIF, KNG:
				kha.Assets.loadImage(itemName.removeFileExtension(), function(img :kha.Image) {
					var texture = _platform.getRenderer().createTextureFromImage(img);
					handleLoad(entry, texture);
				});
			case MP3, OGG, WAV:
				kha.Assets.loadSound(itemName.removeFileExtension(), function(sound :kha.Sound) {
					handleLoad(entry, new KhaSound(sound));
				});
			case MP4:
				Assert.fail("Unsupported format", ["format", entry.format]);
				return;
			case TTF:
				Assert.fail("Unsupported format", ["format", entry.format]);
				return;
			case Data:
				kha.Assets.loadBlob(itemName.replace(".", "_").substring(0, itemName.lastIndexOf("?")), function(blob :kha.Blob) {
					var file = new BasicFile(blob.toString());
					handleLoad(entry, file);
				});
			default:
				Assert.fail("Unsupported format", ["format", entry.format]);
				return;
		}
	}

	override private function getAssetFormats (fn :Array<AssetFormat> -> Void)
	{
		fn([MP4, JXR, KNG, PNG, JPG, GIF, MP3, OGG, WAV, Data, TTF]);
	}
}
