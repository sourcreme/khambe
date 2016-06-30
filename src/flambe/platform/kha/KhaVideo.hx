//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import flambe.animation.AnimatedFloat;
import flambe.sound.Playback;
import flambe.sound.Sound;
import flambe.util.Value;

/**
 *
 */
class KhaVideo extends BasicAsset<KhaVideo>
{
	public var nativeVideo :kha.Video;

	public function new (nativeVideo :kha.Video) : Void
	{
		super();
		this.nativeVideo = nativeVideo;
	}


	override private function onDisposed ()
	{
		nativeVideo.unload();
		nativeVideo = null;
	}
}
