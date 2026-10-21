package lime.utils;

import lime.app.Future;

class DroppedFile
{
	public var path(default, null):String;

	@:noCompletion
	private function new(path:String):Void
	{
		this.path = path;
	}

	public function readFile():Future<Bytes>
	{
		return Bytes.loadFromFile(path);
	}
}
