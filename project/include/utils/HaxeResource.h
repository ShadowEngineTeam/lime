#pragma once

#include <string>
#include <vector>
#include <system/CFFI.h>

namespace lime
{

	class HaxeResource
	{
	  public:
		static void Init(AutoGCRoot *listNamesMethod, AutoGCRoot *getBytesMethod);
		static bool GetBytes(const char *name, std::vector<unsigned char> &outData);
		static bool GetString(const char *name, std::string &outString);
		static std::vector<std::string> ListNames();
	};

} // namespace lime
