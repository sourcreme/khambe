//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.platform.kha;

import khambe.asset.AssetEntry;
import khambe.asset.Manifest;
import khambe.util.Assert;

import khambe.platform.kha.KhaSound;
import khambe.platform.kha.KhaTexture;
import khambe.platform.kha.KhaTextureRoot;

using khambe.util.Strings;
using StringTools;

class KhaAssetPackLoader extends BasicAssetPackLoader
{

	public function new (platform :KhaPlatform, manifest :Manifest, logEntries :Bool = false)
	{
		super(platform, manifest);

		if(logEntries) {
			_logEntries = true;
			_logger = System.createLogger("KhaAssetPackLoader");
		}
	}

	override private function loadEntry (url :String, entry :AssetEntry)
	{
		var itemName = url.substr(url.lastIndexOf("/") + 1);
		_assetsLoading++;


		switch (entry.format) {
			case JXR, PNG, JPG, GIF, KNG:
				_logger.info("IMAGE- " + itemName.removeFileExtension());
				kha.Assets.loadImage(itemName.removeFileExtension(), function(img :kha.Image) {
					var texture = _platform.getRenderer().createTextureFromImage(img);
					handleLoad(entry, texture);
					handleLoadSuccess(itemName);
				});
			case MP3, OGG, WAV:
				_logger.info("SOUND- " + itemName.removeFileExtension());
				kha.Assets.loadSound(itemName.removeFileExtension(), function(sound :kha.Sound) {
					handleLoad(entry, new KhaSound(sound));
					handleLoadSuccess(itemName);
				});
			case MP4:
				_logger.info("VIDEO- " + itemName.removeFileExtension());
				kha.Assets.loadVideo(itemName.removeFileExtension(), function(video :kha.Video) {
					handleLoad(entry, new KhaVideo(video));
					handleLoadSuccess(itemName);
				});
			case TTF:
				_logger.info("FONT- " + itemName.removeFileExtension());
				kha.Assets.loadFont(itemName.removeFileExtension(), function(font :kha.Font) {
					handleLoad(entry, font);
					handleLoadSuccess(itemName);
				});
			case Data:
				_logger.info("DATA- " + itemName.removeFileExtension());
				kha.Assets.loadBlob(itemName.replace(".", "_").substring(0, itemName.lastIndexOf("?")), function(blob :kha.Blob) {
					var file = new BasicFile(blob.toString());
					handleLoad(entry, file);
					handleLoadSuccess(itemName);
				});
			default:
				_logger.error("FAIL- " + itemName.removeFileExtension());
				Assert.fail("Unsupported format", ["format", entry.format]);
				return;
		}
	}

	override private function getAssetFormats (fn :Array<AssetFormat> -> Void)
	{
		fn([MP4, JXR, KNG, PNG, JPG, GIF, MP3, OGG, WAV, Data, TTF]);
	}

	private function handleLoadSuccess(itemName :String) : Void
	{
		_assetsLoading--;
		if(_assetsLoading == 0 && this.promise.result == null)
			handleSuccess();
	}


	private var _assetsLoading :Int = 0;
	private var _logEntries :Bool;
	private var _logger :khambe.util.Logger;
}
