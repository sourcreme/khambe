//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.util;


/**
 * Utility mixins for Arrays. Designed to be imported with 'using'.
 */
class Arrays
{
    public static function sortedInsert<A> (arr :Array<A>, val :A, comp :A -> A -> Int) :Int
    {
        var insertedIdx = -1;
        var nn = arr.length;
        for (ii in 0...nn) {
            var compVal = arr[ii];
            if (comp(val, compVal) <= 0) {
                arr.insert(ii, val);
                insertedIdx = ii;
                break;
            }
        }

        if (insertedIdx < 0) {
            arr.push(val);
            insertedIdx = arr.length - 1;
        }

        return insertedIdx;
    }

    /** Allocate an array of a predetermined length. */
    @:noUsing inline public static function create<A> (length :Int) :Array<A>
    {
#if (flash || js)
		var a:Array<A> = untyped __new__(Array, length);
		return a;
#else
		return cpp.NativeArray.create(length);
#end
    }

    /** Resizes an array in-place. */
    inline public static function resize<A> (arr :Array<A>, length :Int)
    {
         if (arr.length > length) {
#if (flash || js)
			untyped arr.length = length;
			return arr;
#else
			return cpp.NativeArray.setSize(arr, length);
#end
		}
		else {
			return arr;
        }
    }

    inline public static function indexOf<A> (arr :Array<A>, element :A, ?fromIndex :Int) :Int
    {
        return arr.indexOf(element, fromIndex);
    }

    inline public static function lastIndexOf<A> (arr :Array<A>, element :A, ?fromIndex :Int) :Int
    {
        return arr.lastIndexOf(element, fromIndex);
    }
}
