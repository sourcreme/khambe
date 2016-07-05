//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe.platform;

import khambe.asset.AssetPack;
import khambe.asset.Manifest;
import khambe.display.Texture;
import khambe.subsystem.*;
import khambe.util.Logger;
import khambe.util.Promise;

interface Platform
{
	function init (title :String, width :Int, height :Int, onInitialized :Void -> Void) :Void;

	function getExternal () :ExternalSystem;
	function getKeyboard () :KeyboardSystem;
	function getMotion() :MotionSystem;
	function getMouse () :MouseSystem;
	function getPointer () :PointerSystem;
	function getRenderer () :InternalRenderer<Dynamic>;
	function getStage () :StageSystem;
	function getStorage () :StorageSystem;
	function getTouch () :TouchSystem;
	function getWeb () :WebSystem;

	function createLogHandler (tag :String) :LogHandler;
	function loadAssetPack (manifest :Manifest) :Promise<AssetPack>;
	function getCatapultClient () :CatapultClient;

	function getLocale () :String;
	function getTime () :Float;
}
