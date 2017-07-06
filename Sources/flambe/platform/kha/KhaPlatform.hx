//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.subsystem.*;
import flambe.util.Logger;
import flambe.util.Promise;

class KhaPlatform implements Platform
{
	public static var instance (default, null) :KhaPlatform = new KhaPlatform();

	public var mainLoop (default, null) :MainLoop;

	private function new ()
	{
	}

	public function init () :Void
	{
		_pointer = new BasicPointer();
		_touch = new BasicTouch(_pointer);
		_mouse = new BasicMouse(_pointer);
		_stage = new KhaStage(null);
		mainLoop = new MainLoop();

		kha.System.notifyOnRender(function(framebuffer :kha.Framebuffer) {
			if(_renderer == null) {
				_renderer = new KhaRenderer(framebuffer.g2);
			}

			if (System.hidden._) {
				return; // Prevent updates while hidden
			}
			if (_skipRender) {
				_skipRender = false;
				return;
			}

			mainLoop.render(_renderer);
		});

		kha.Scheduler.addTimeTask(function() {
			var currentTime = kha.Scheduler.time();
			_deltaTime = currentTime - _lastTime;
			_lastTime = currentTime;
			if(_deltaTime < 0)
				_deltaTime = 0;

			if (System.hidden._) {
				return; // Prevent updates while hidden
			}
			if (_skipUpdate) {
				_skipUpdate = false;
				return;
			}
			

			mainLoop.update(_deltaTime);
		}, 0, 1 / 60);

		function downListener(button :Int, x :Int, y :Int) {
			_mouse.submitDown(x, y, button);
		}

		function upListener(button :Int, x :Int, y :Int) {
			_mouse.submitUp(x, y, button);
		}

		function moveListener(a :Int, b :Int, c :Int, d :Int) {
			// _mouse.submitMove(x, y);
		}

		function wheelListener(velocity :Int) {
			// _mouse.submitScroll()
		}

		function foregroundListener() {
			System.hidden._ = false;
		}

		function resumeListener() {
			trace("resumeListener");
		}

		function pauseListener() {
			trace("pauseListener");
		}

		function backgroundListener() {
			System.hidden._ = true;
		}

		function shutdownListener() {
			trace("shutdownListener");
		}

		kha.System.notifyOnApplicationState(foregroundListener, resumeListener, pauseListener, backgroundListener, shutdownListener);

		kha.input.Mouse.get().notify(downListener, upListener, moveListener, wheelListener);

		System.hidden.changed.connect(function (hidden,_) {
            if (!hidden) {
                _skipRender = true;
                _skipUpdate = true;
            }
        });
        _skipRender = false;
        _skipUpdate = false;
	}

	public function getExternal () :ExternalSystem
	{
		if(_external == null)
			_external = new KhaExternal();
		return _external;
	}
	public function getKeyboard () :KeyboardSystem
	{
		if(_keyboard == null)
			_keyboard = new BasicKeyboard();
		return _keyboard;
	}
	public function getMotion() :MotionSystem
	{
		if(_motion == null)
			_motion = new KhaMotion();
		return _motion;
	}
	public function getMouse () :MouseSystem
	{
		return _mouse;
	}
	public function getPointer () :PointerSystem
	{
		return _pointer;
	}
	public function getRenderer () :KhaRenderer
	{
		return _renderer;
	}
	public function getStage () :StageSystem
	{
		return _stage;
	}
	public function getStorage () :StorageSystem
	{
		if(_storage == null)
			_storage = new KhaStorage(null);
		return _storage;
	}
	public function getTouch () :TouchSystem
	{
		return _touch;
	}
	public function getWeb () :WebSystem
	{
		if(_web == null)
			_web = new KhaWeb();
		return _web;
	}

	public function createLogHandler (tag :String) :LogHandler
	{
		return null;
	}
	public function loadAssetPack (manifest :Manifest) :Promise<AssetPack>
	{
		return new KhaAssetPackLoader(this, manifest).promise;
	}
	public function getCatapultClient () :CatapultClient
	{
		return null;
	}

	public function getLocale () :String
	{
		return null;
	}
	public function getTime () :Float
	{
		return null;
	}

	// Statically initialized subsystems
	private var _mouse :BasicMouse;
	private var _pointer :BasicPointer;
	private var _renderer :KhaRenderer;
	private var _stage :KhaStage;
	private var _touch :BasicTouch;

	// Lazily initialized subsystems
	private var _external :KhaExternal;
	private var _keyboard :BasicKeyboard;
	private var _motion :KhaMotion;
	private var _storage :KhaStorage;
	private var _web :KhaWeb;

	private var _lastUpdate :Int;
	private var _skipRender :Bool;
	private var _skipUpdate :Bool;
	private var _timeOffset :Float;

	private var _catapult :KhaCatapultClient;

	private var _deltaTime :Float = 0;
	private var _lastTime :Float = 0;
}
