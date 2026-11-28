package lime._internal.backend.emscripten;

#if emscripten
import haxe.io.Bytes;
import haxe.io.BytesData;
import lime.app.Future;
import lime.app.Promise;
import lime.net.HTTPRequest;
import lime.net.HTTPRequestHeader;
import sys.FileSystem;

@:headerCode("#include <emscripten/fetch.h>")
@:cppFileCode("
#include <map>
#include <vector>
#include <stdlib.h>
#include <string.h>

static std::map<int, emscripten_fetch_t *> lime_fetches;

static void lime_fetch_finish (emscripten_fetch_t *fetch, bool success) {

	int id = (int)(intptr_t)fetch->userData;

	// emscripten_fetch_close calls onerror before readyState is DONE (4) when a fetch is canceled, and frees it itself
	if (fetch->readyState != 4) {

		lime_fetches.erase (id);
		return;

	}

	::Array<unsigned char> data = null ();
	::String headers = null ();

	if (fetch->numBytes > 0 && fetch->data) {

		data = ::Array_obj<unsigned char>::fromData ((const unsigned char *)fetch->data, (int)fetch->numBytes);

	}

	size_t length = emscripten_fetch_get_response_headers_length (fetch);

	if (length > 0) {

		char *buffer = (char *)malloc (length + 1);
		emscripten_fetch_get_response_headers (fetch, buffer, length + 1);
		headers = ::String::create (buffer, (int)length);
		free (buffer);

	}

	int status = fetch->status;

	lime_fetches.erase (id);
	emscripten_fetch_close (fetch);

	::lime::_internal::backend::emscripten::EmscriptenHTTPRequest_obj::__onFetchDone (id, success, status, data, headers);

}

static void lime_fetch_onsuccess (emscripten_fetch_t *fetch) {

	lime_fetch_finish (fetch, true);

}

static void lime_fetch_onerror (emscripten_fetch_t *fetch) {

	lime_fetch_finish (fetch, false);

}

static void lime_fetch_onprogress (emscripten_fetch_t *fetch) {

	::lime::_internal::backend::emscripten::EmscriptenHTTPRequest_obj::__onFetchProgress ((int)(intptr_t)fetch->userData, (int)(fetch->dataOffset + fetch->numBytes), (int)fetch->totalBytes);

}

static bool lime_fetch_start (int id, ::String method, ::String url, ::Array< ::String > headers, ::Array<unsigned char> body, int timeout, bool withCredentials) {

	emscripten_fetch_attr_t attr;
	emscripten_fetch_attr_init (&attr);

	strncpy (attr.requestMethod, method.utf8_str (), sizeof (attr.requestMethod) - 1);
	attr.attributes = EMSCRIPTEN_FETCH_LOAD_TO_MEMORY;
	attr.onsuccess = lime_fetch_onsuccess;
	attr.onerror = lime_fetch_onerror;
	attr.onprogress = lime_fetch_onprogress;
	attr.userData = (void *)(intptr_t)id;
	attr.timeoutMSecs = timeout > 0 ? timeout : 0;
	attr.withCredentials = withCredentials;

	// Emscripten copies the headers and body before emscripten_fetch returns
	std::vector<const char *> requestHeaders;

	for (int i = 0; i < headers->length; i++) {

		requestHeaders.push_back (headers[i].utf8_str ());

	}

	requestHeaders.push_back (NULL);
	attr.requestHeaders = requestHeaders.data ();

	if (body.mPtr && body->length > 0) {

		attr.requestData = (const char *)body->getBase ();
		attr.requestDataSize = body->length;

	}

	emscripten_fetch_t *fetch = emscripten_fetch (&attr, url.utf8_str ());

	if (!fetch) return false;

	lime_fetches[id] = fetch;
	return true;

}

static void lime_fetch_cancel (int id) {

	std::map<int, emscripten_fetch_t *>::iterator it = lime_fetches.find (id);

	if (it != lime_fetches.end ()) {

		emscripten_fetch_t *fetch = it->second;
		lime_fetches.erase (it);
		emscripten_fetch_close (fetch);

	}

}
")
class EmscriptenHTTPRequest
{
	private static var nextID:Int = 1;
	private static var requests:Map<Int, EmscriptenHTTPRequest> = new Map();

	private var id:Int;
	private var parent:_IHTTPRequest;
	private var promise:Promise<Bytes>;

	public function new()
	{
		id = 0;
	}

	public function cancel():Void
	{
		if (id != 0)
		{
			var current:Int = id;
			requests.remove(current);
			id = 0;
			promise = null;
			untyped __cpp__("lime_fetch_cancel({0})", current);
		}
	}

	public function init(parent:_IHTTPRequest):Void
	{
		this.parent = parent;
	}

	public function loadData(uri:String, binary:Bool = true):Future<Bytes>
	{
		if (uri == null)
		{
			return cast Future.withError("The URI must not be null");
		}

		cancel();

		if (uri.indexOf("://") == -1 && FileSystem.exists(uri))
		{
			var bytes:Bytes = lime.utils.Bytes.fromFile(uri);

			if (bytes == null)
			{
				return cast Future.withError(new _HTTPRequestErrorResponse("Cannot load file: " + uri, null));
			}

			return Future.withValue(bytes);
		}

		var promise:Promise<Bytes> = new Promise<Bytes>();
		var method:String = Std.string(parent.method).toUpperCase();
		var body:Bytes = parent.data;
		var query:String = null;

		if (parent.formData != null)
		{
			var parameters:Array<String> = [];

			for (key in parent.formData.keys())
			{
				parameters.push(StringTools.urlEncode(key) + "=" + StringTools.urlEncode(Std.string(parent.formData.get(key))));
			}

			if (parameters.length > 0)
			{
				query = parameters.join("&");
			}
		}

		var contentType:String = parent.contentType;

		if (query != null)
		{
			if (method == "GET" || method == "HEAD" || body != null)
			{
				uri += (uri.indexOf("?") == -1 ? "?" : "&") + query;
			}
			else
			{
				body = Bytes.ofString(query);

				if (contentType == null)
				{
					contentType = "application/x-www-form-urlencoded";
				}
			}
		}

		var headers:Array<String> = [];

		if (parent.headers != null)
		{
			for (header in parent.headers)
			{
				if (header.name == "Content-Type")
				{
					contentType = header.value;
				}
				else
				{
					headers.push(header.name);
					headers.push(header.value);
				}
			}
		}

		if (contentType != null)
		{
			headers.push("Content-Type");
			headers.push(contentType);
		}

		var current:Int = nextID++;
		var bodyData:BytesData = body != null ? body.getData() : null;

		id = current;
		this.promise = promise;
		requests.set(current, this);

		var started:Bool = untyped __cpp__("lime_fetch_start({0}, {1}, {2}, {3}, {4}, {5}, {6})", current, method, uri, headers, bodyData, parent.timeout,
			parent.withCredentials);

		if (!started)
		{
			requests.remove(current);
			id = 0;
			this.promise = null;
			promise.error(new _HTTPRequestErrorResponse("Cannot start request: " + uri, null));
		}

		return promise.future;
	}

	public function loadText(uri:String):Future<String>
	{
		var promise:Promise<String> = new Promise<String>();
		var future:Future<Bytes> = loadData(uri, false);

		future.onProgress(promise.progress);
		future.onError(promise.error);
		future.onComplete(function(bytes:Bytes):Void
		{
			promise.complete(bytes != null ? bytes.getString(0, bytes.length) : null);
		});

		return promise.future;
	}

	@:keep @:noCompletion private static function __onFetchDone(id:Int, success:Bool, status:Int, data:BytesData, headers:String):Void
	{
		var request:EmscriptenHTTPRequest = requests.get(id);

		if (request == null)
		{
			return;
		}

		requests.remove(id);

		var promise:Promise<Bytes> = request.promise;
		var parent:_IHTTPRequest = request.parent;
		var bytes:Bytes = data != null ? Bytes.ofData(data) : Bytes.alloc(0);

		request.id = 0;
		request.promise = null;

		parent.responseStatus = status;

		if (parent.enableResponseHeaders)
		{
			parent.responseHeaders = [];

			if (headers != null)
			{
				for (line in headers.split("\n"))
				{
					var index:Int = line.indexOf(":");

					if (index > 0)
					{
						parent.responseHeaders.push(new HTTPRequestHeader(StringTools.trim(line.substr(0, index)), StringTools.trim(line.substr(index + 1))));
					}
				}
			}
		}

		if (success && status >= 200 && status < 400)
		{
			promise.complete(bytes);
		}
		else
		{
			promise.error(new _HTTPRequestErrorResponse(status == 0 ? "Network error" : "Status " + status, bytes));
		}
	}

	@:keep @:noCompletion private static function __onFetchProgress(id:Int, bytesLoaded:Int, bytesTotal:Int):Void
	{
		var request:EmscriptenHTTPRequest = requests.get(id);

		if (request != null && request.promise != null)
		{
			request.promise.progress(bytesLoaded, bytesTotal);
		}
	}
}
#end
