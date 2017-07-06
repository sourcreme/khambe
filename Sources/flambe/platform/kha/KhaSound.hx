//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import flambe.animation.AnimatedFloat;
import flambe.math.FMath;
import flambe.platform.Tickable;
import flambe.sound.Playback;
import flambe.sound.Sound;
import flambe.util.Disposable;
import flambe.util.Value;
import kha.audio1.Audio;
import kha.audio1.AudioChannel;

class KhaSound extends BasicAsset<Dynamic> implements Sound
{
	public var duration (get, null) :Float;
	public var nativeSound :kha.Sound;

	public function new (sound :kha.Sound)
	{
		super();
		this.nativeSound = sound;

		_length = 0;
	}

	public function play (volume :Float = 1.0) :Playback
	{
		assertNotDisposed();
		return new KhaPlayback(this, volume, false);
	}

	public function loop (volume :Float = 1.0) :Playback
	{   
		assertNotDisposed();
		return new KhaPlayback(this, volume, true);
	}

	public function get_duration () :Float
	{
		assertNotDisposed();
		return _length;
	}

	override private function onDisposed ()
	{
		nativeSound = null;
	}

	private var _length :Float;
}

private class KhaPlayback implements flambe.sound.Playback implements Tickable
{
	public var volume (default, null) :AnimatedFloat;
	public var paused (get, set) :Bool;
	public var complete (get, null) :Value<Bool>;
	public var position (get, null) :Float;
	public var sound (get, null) :Sound;

	public function new(sound :KhaSound, volume :Float, loop :Bool) : Void
	{
		this.volume = new AnimatedFloat(volume);
		_sound = sound;
		_paused = false;
		_complete = new Value<Bool>(false);
		_wasPaused = false;
		_tickableAdded = false;
		playAudio();
	}

	public function get_paused() : Bool
	{
		return false;
	}

	public function set_paused(paused :Bool) : Bool
	{
		if(paused)
			_channel.pause();
		else
			_channel.play();
		_paused = paused;
		return paused;
	}

	public function get_complete() : Value<Bool>
	{
		return _complete;
	}

	public function get_position() : Float
	{
		return _channel.position;
	}

	public function get_sound() : Sound
	{
		return _sound;
	}

	public function update (dt :Float) :Bool
	{
		volume.update(dt);

		if(_channel.finished) {
			_complete._ = true;
		}

		if (_complete._) {
			// Allow complete or paused sounds to be garbage collected
			_tickableAdded = false;
			// Release references
			_hideBinding.dispose();

			return true;
		}
		return false;
	}

	public function dispose() : Void
	{
		_channel.stop();
		_sound = null;
	}

	private function playAudio() : Void
	{
		_channel = Audio.stream(_sound.nativeSound);

		if (!_tickableAdded) {
			KhaPlatform.instance.mainLoop.addTickable(this);
			_tickableAdded = true;

			// Claim references
			_hideBinding = System.hidden.changed.connect(function(hidden,_) {
				if (hidden) {
					_wasPaused = get_paused();
					this.paused = true;
				} else {
					this.paused = _wasPaused;
				}
			});
			_channel.finished;
		}
	}


	private var _sound :KhaSound;
	private var _channel :AudioChannel;
	private var _complete :Value<Bool>;
	private var _paused :Bool;

	private var _hideBinding :Disposable;
	private var _wasPaused :Bool;
	private var _tickableAdded :Bool;
}
