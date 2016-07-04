//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.platform.kha;

import khambe.subsystem.*;
import khambe.util.Logger;
import khambe.util.Promise;
import khambe.asset.AssetPack;
import khambe.asset.Manifest;

class KhaPlatform implements Platform
{
	public static var instance (default, null) :KhaPlatform = new KhaPlatform();

	private function new() : Void {}

	public function init(title :String, width :Int, height :Int, onInitialized :Void -> Void) : Void
	{
		kha.System.init({title: title, width: width, height: height}, function() {
			_khaPointer = new KhaPointer();
			_khaMouse = new KhaMouse(_khaPointer);
			_khaTouch = new KhaTouch(_khaPointer);

			_khaStage = new KhaStage();
			_khaRenderer = new KhaRenderer();
			_mainLoop = new MainLoop();

			kha.Scheduler.addTimeTask(onUpdate, 0, 1 / 60);
			kha.System.notifyOnRender(onRender);

			System.hidden.changed.connect(function (hidden,_) {
				if (!hidden) {
					_skipFrame = true;
					KhaSound.pauseAll(false);
				}
				else {
					KhaSound.pauseAll(true);
				}
			});
			_skipFrame = false;

			onInitialized();
			handleApplicationState();
			Log.info("Initialized Kha platform", ["renderer", _khaRenderer.type]);
		});
	}

	public function getExternal() : ExternalSystem
	{
		if(_khaExternal == null) {
			_khaExternal = new KhaExternal();
		}
		return _khaExternal;
	}
	
	public function getKeyboard() : KeyboardSystem
	{
		if(_khaKeyboard == null) {
			_khaKeyboard = new KhaKeyboard();
		}

		return _khaKeyboard;
	}
	
	public function getMotion() : MotionSystem
	{
		if(_khaMotion == null) {
			_khaMotion = new KhaMotion();
		}
		return _khaMotion;
	}
	
	public function getMouse() : MouseSystem
	{
		return _khaMouse;
	}
	
	public function getPointer() : PointerSystem
	{
		return _khaPointer;
	}
	
	public function getRenderer() : InternalRenderer<kha.Image>
	{
		return _khaRenderer;
	}
	
	public function getStage() : StageSystem
	{
		return _khaStage;
	}
	
	public function getStorage() : StorageSystem
	{
		if(_khaStorage == null) {
			_khaStorage = new KhaStorage();
		}
		return _khaStorage;
	}
	
	public function getTouch() : TouchSystem
	{
		return _khaTouch;
	}
	
	public function getWeb() : WebSystem
	{
		if(_khaWeb == null) {
			_khaWeb = new KhaWeb();
		}
		return _khaWeb;
	}

	public function createLogHandler(tag :String) : LogHandler
	{
		return new KhaLogHandler(tag);
	}
	
	public function loadAssetPack(manifest :Manifest) : Promise<AssetPack>
	{
		return new KhaAssetPackLoader(this, manifest, true).promise;
	}
	
	public function getCatapultClient() : CatapultClient
	{
		if(_khaCatapult == null) {
			_khaCatapult = new KhaCatapultClient();
		}
		return _khaCatapult;
	}

	public function getLocale() : String
	{
		return null;
	}
	
	public function getTime() : Float
	{
		return -1;
	}

	private inline function handleApplicationState() : Void
	{
		function foregroundListener() : Void
		{
			System.hidden._ = false;
		}

		function resumeListener() : Void
		{
			System.hidden._ = false;
		}

		function pauseListener() : Void
		{
			System.hidden._ = true;
		}

		function backgroundListener() : Void
		{
			System.hidden._ = true;
		}

		function shutdownListener() : Void
		{
			System.hidden._ = true;
		}

		kha.System.notifyOnApplicationState(foregroundListener, resumeListener, pauseListener, backgroundListener, shutdownListener);
	}


	private inline function onRender(framebuffer :kha.Framebuffer) : Void
	{
		_mainLoop.render(_khaRenderer);
		var kGraphics :KhaGraphics = cast _khaRenderer.graphics;

		framebuffer.g2.begin(true, kha.Color.Black);
		kha.Scaler.scale(kGraphics.backbuffer, framebuffer, kha.System.screenRotation);
		framebuffer.g2.end();

		translatePointer(kGraphics, framebuffer);
	}

	private inline function translatePointer(kGraphics :KhaGraphics, framebuffer :kha.Framebuffer) : Void
	{
		var rect = kha.Scaler.targetRect(kGraphics.backbuffer.width, kGraphics.backbuffer.height, framebuffer.width, framebuffer.height, kha.System.screenRotation);

		_khaStage.requestResize(Std.int(rect.width/rect.scaleFactor), Std.int(rect.height/rect.scaleFactor));

		kGraphics._scaleOffset = _khaPointer._scale = rect.scaleFactor;
		kGraphics._xOffset = _khaPointer._xOffset = rect.x;
		kGraphics._yOffset = _khaPointer._yOffset = rect.y;
		kGraphics._heightOffset = rect.height;
	}

	private inline function onUpdate() : Void
	{
		var currentTime = kha.Scheduler.time();
		_deltaTime = currentTime - _lastTime;
		_lastTime = currentTime;

		if (System.hidden._) {
			return; // Prevent updates while hidden
		}
		if (_skipFrame) {
			_skipFrame = false;
			return;
		}

		_mainLoop.update(_deltaTime);
	}

	private var _khaMouse    :MouseSystem;
	private var _khaPointer  :KhaPointer;
	private var _khaRenderer :KhaRenderer;
	private var _khaStage    :KhaStage;
	private var _khaTouch    :TouchSystem;
	private var _khaExternal :ExternalSystem;
	private var _khaKeyboard :KeyboardSystem;
	private var _khaMotion   :MotionSystem;
	private var _khaStorage  :StorageSystem;
	private var _khaWeb      :WebSystem;
	private var _khaCatapult :CatapultClient;

	private var _deltaTime :Float = 0;
	private var _lastTime  :Float = 0;
	private var _skipFrame :Bool;
	private var _mainLoop  :MainLoop;


}













