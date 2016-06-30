//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.display;

/**
 * Draws to a surface.
 */
interface Pipeline
{
	var name :String;
	var pipelineState :kha.graphics4.PipelineState;
}