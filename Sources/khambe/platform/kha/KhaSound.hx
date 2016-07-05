//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.platform.kha;

import khambe.animation.AnimatedFloat;
import khambe.sound.Playback;
import khambe.sound.Sound;
import khambe.util.Value;

import kha.audio1.AudioChannel;

/**
 *
 */
class KhaSound extends BasicAsset<KhaSound> implements Sound
{
	public var duration (get, null) :Float;
	public var nativeSound :kha.Sound;

	public function new (nativeSound :kha.Sound) : Void
	{
		super();
		this.nativeSound = nativeSound;
	}

	public function play (volume :Float = 1.0) :Playback
	{
		return new KhaPlayback(this, volume, false);
	}

	public function loop (volume :Float = 1.0) :Playback
	{
		return new KhaPlayback(this, volume, true);
	}

	public function get_duration () :Float
	{
		return -1;
	}

	override private function copyFrom (asset :KhaSound)
	{
		this.nativeSound = asset.nativeSound;
	}

	override private function onDisposed ()
	{
		nativeSound.unload();
		nativeSound = null;
	}

	@:allow(khambe.platform.kha.KhaPlatform) private static function pauseAll(pause :Bool) : Void
	{
		for(playback in KhaPlayback._playbacks) {
			playback.systemPaused(pause);
		}
	}

	private var _duration :Float;
}

// This should be immutable too
class KhaPlayback implements Playback
{
	public var volume (default, null) :AnimatedFloat;
	public var paused (get, set) :Bool;
	public var complete (get, null) :Value<Bool>;
	public var position (get, null) :Float;
	public var sound (get, null) :Sound;

	public function new (sound :KhaSound, volume :Float, loop :Bool)
	{
		_sound = sound;
		this.volume = new AnimatedFloat(volume);
		_complete = new Value<Bool>(false);
		_paused = false;

		_channel = kha.audio1.Audio.stream(sound.nativeSound, loop);
		_channel.volume = this.volume._;
		_playbacks.push(this);
	}

	public function dispose ()
	{
		_playbacks.remove(this);
		_channel.stop();
		_channel = null;
	}

	private inline function get_sound () :Sound
	{
		return _sound;
	}

	private inline function get_paused () :Bool
	{
		return _paused;
	}

	private inline function set_paused (paused :Bool) :Bool
	{
		if(paused)
			_channel.pause();
		else
			_channel.play();
		return _paused = paused;
	}

	private inline function get_complete () :Value<Bool>
	{
		return _complete;
	}

	private inline function get_position () :Float
	{
		return _channel.position;
	}

	@:allow(khambe.platform.kha.KhaSound) private function systemPaused(paused :Bool) :Void
	{
		if(paused)
			_channel.pause();
		else
			set_paused(_paused);
	}

	private var _channel :AudioChannel;
	private var _sound :Sound;
	private var _complete :Value<Bool>;
	private var _paused :Bool;

	private var _isPaused :Bool;
	@:allow(khambe.platform.kha.KhaSound) private static var _playbacks :Array<KhaPlayback> = [];
}
