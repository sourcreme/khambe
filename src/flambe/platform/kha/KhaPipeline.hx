
package flambe.platform.kha;

import kha.graphics4.BlendingFactor;
import kha.graphics4.PipelineState;
import kha.graphics4.VertexData;
import kha.graphics4.VertexStructure;
import kha.Shaders;

import flambe.display.Pipeline;

class KhaPipeline
{
	public static var colorPipeline (get, null) :Pipeline;
	public static var imagePipeline (get, null) :Pipeline;
	public static var textPipeline  (get, null) :Pipeline;

	private static inline function get_imagePipeline() : Pipeline
	{
		if(_imagePipeline == null) {
			var imagePState = new PipelineState();
			imagePState.fragmentShader = Shaders.painter_image_frag;
			imagePState.vertexShader = Shaders.painter_image_vert;

			var structure = new VertexStructure();
			structure.add("vertexPosition", VertexData.Float3);
			structure.add("texPosition", VertexData.Float2);
			structure.add("vertexColor", VertexData.Float4);
			imagePState.inputLayout = [structure];
			
			imagePState.blendSource = BlendingFactor.SourceAlpha;
			imagePState.blendDestination = BlendingFactor.InverseSourceAlpha;
			imagePState.alphaBlendSource = BlendingFactor.SourceAlpha;
			imagePState.alphaBlendDestination = BlendingFactor.InverseSourceAlpha;
			
			imagePState.compile();

			_imagePipeline = new KPipe("imagePipeline", imagePState);
		}

		return _imagePipeline;
	}

	private static inline function get_colorPipeline() : Pipeline
	{
		if(_colorPipeline == null) {
			var colorPState = new PipelineState();
			colorPState.fragmentShader = Shaders.painter_colored_frag;
			colorPState.vertexShader = Shaders.painter_colored_vert;

			var structure = new VertexStructure();
			structure.add("vertexPosition", VertexData.Float3);
			structure.add("vertexColor", VertexData.Float4);
			colorPState.inputLayout = [structure];
			
			colorPState.blendSource = BlendingFactor.SourceAlpha;
			colorPState.blendDestination = BlendingFactor.InverseSourceAlpha;
			colorPState.alphaBlendSource = BlendingFactor.SourceAlpha;
			colorPState.alphaBlendDestination = BlendingFactor.InverseSourceAlpha;
				
			colorPState.compile();

			_colorPipeline = new KPipe("colorPipeline", colorPState);
		}

		return _colorPipeline;
	}

	private static inline function get_textPipeline() : Pipeline
	{
		if(_textPipeline == null) {
			var textPState = new PipelineState();
			textPState.fragmentShader = Shaders.painter_text_frag;
			textPState.vertexShader = Shaders.painter_text_vert;

			var structure = new VertexStructure();
			structure.add("vertexPosition", VertexData.Float3);
			structure.add("texPosition", VertexData.Float2);
			structure.add("vertexColor", VertexData.Float4);
			textPState.inputLayout = [structure];
			
			textPState.blendSource = BlendingFactor.SourceAlpha;
			textPState.blendDestination = BlendingFactor.InverseSourceAlpha;
			textPState.alphaBlendSource = BlendingFactor.SourceAlpha;
			textPState.alphaBlendDestination = BlendingFactor.InverseSourceAlpha;
			
			textPState.compile();

			_textPipeline = new KPipe("textPipeline", textPState);
		}

		return _textPipeline;
	}

	private static var _colorPipeline :Pipeline = null;
	private static var _imagePipeline :Pipeline = null;
	private static var _textPipeline  :Pipeline = null;
}

private class KPipe implements Pipeline
{
	public var name :String;
	public var pipelineState :PipelineState;

	public function new(name :String, pipelineState :PipelineState) : Void
	{
		this.name = name;
		this.pipelineState = pipelineState;
	}
}




