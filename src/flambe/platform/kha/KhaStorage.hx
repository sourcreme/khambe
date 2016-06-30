//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.kha;

import flambe.subsystem.StorageSystem;

class KhaStorage implements StorageSystem
{
	public var supported (get, null) :Bool;

	public function new ()
	{
		_dataStorage = cast kha.Storage.defaultFile().readObject();
		if(_dataStorage == null) {
			_dataStorage = new Map<String, Dynamic>();
			kha.Storage.defaultFile().writeObject(_dataStorage);
		}
	}

	public function get_supported () :Bool
	{
		return true;
	}

	public function set (key :String, value :Dynamic) :Bool
	{
		_dataStorage.set(key, value);
		kha.Storage.defaultFile().writeObject(_dataStorage);
		return true;
	}

	public function get<A> (key :String, defaultValue :A = null) :A
	{
		return _dataStorage.exists(key) ? _dataStorage.get(key) : defaultValue;
	}

	public function remove (key :String)
	{
		_dataStorage.remove(key);
		kha.Storage.defaultFile().writeObject(_dataStorage);
	}

	public function clear ()
	{
		_dataStorage = new Map<String,Dynamic>();
		kha.Storage.defaultFile().writeObject(_dataStorage);
	}

	private var _dataStorage :Map<String,Dynamic>;
}





