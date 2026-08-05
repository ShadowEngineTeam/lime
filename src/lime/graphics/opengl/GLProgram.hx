package lime.graphics.opengl;

#if (!lime_doc_gen || lime_opengl || lime_opengles)
import lime.graphics.opengl.GL;
import lime.utils.Log;

@:forward(id, refs) abstract GLProgram(GLObject) from GLObject to GLObject
{
	@:from private static function fromInt(id:Int):GLProgram
	{
		return GLObject.fromInt(PROGRAM, id);
	}

	public static function fromSources(gl:Dynamic, vertexSource:String, fragmentSource:String):GLProgram
	{
		var vertexShader = GLShader.fromSource(gl, vertexSource, gl.VERTEX_SHADER);
		var fragmentShader = GLShader.fromSource(gl, fragmentSource, gl.FRAGMENT_SHADER);

		var program = gl.createProgram();
		gl.attachShader(program, vertexShader);
		gl.attachShader(program, fragmentShader);
		gl.linkProgram(program);

		if (gl.getProgramParameter(program, GL.LINK_STATUS) == 0)
		{
			var message = "Unable to initialize the shader program";
			var log = gl.getProgramInfoLog(program);
			if (log != null && log != "")
				message += "\n" + log;
			Log.error(message);
		}

		return program;
	}
}
#end
