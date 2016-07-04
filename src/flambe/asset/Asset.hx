//
// flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.asset;

import flambe.util.Disposable;
import flambe.util.Value;

/**
 * A fully loaded asset.
 */
interface Asset extends Disposable
{
	/**
	 * The number of times this asset has been live-reloaded. Asset reloading is only enabled in
	 * flambe_debug builds, and only from the /assets directory.
	 */
	var reloadCount (get, null) :Value<Int>;

	/**
	 * Frees up the underlying resources used by this asset. An asset must not be used after it has
	 * been disposed.
	 */
	function dispose () :Void;
}
