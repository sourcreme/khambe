//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.platform.kha;

import khambe.animation.AnimatedFloat;
import khambe.sound.Playback;
import khambe.sound.Sound;
import khambe.util.Value;

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
