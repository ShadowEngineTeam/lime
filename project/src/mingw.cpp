#include <windows.h>
#include <oleauto.h>

namespace _com_util {

    BSTR WINAPI ConvertStringToBSTR(const char* input) {
        if (!input) return nullptr;

        int lenW = MultiByteToWideChar(CP_ACP, 0, input, -1, NULL, 0);
        if (lenW <= 0) return nullptr;

        BSTR bstr = SysAllocStringLen(0, lenW - 1);  // Exclude null terminator
        if (!bstr) return nullptr;

        MultiByteToWideChar(CP_ACP, 0, input, -1, bstr, lenW);
        return bstr;
    }

    char* WINAPI ConvertBSTRToString(BSTR bstr) {
        if (!bstr) return nullptr;

        int len = WideCharToMultiByte(CP_ACP, 0, bstr, -1, NULL, 0, NULL, NULL);
        if (len <= 0) return nullptr;

        char* result = new char[len];
        if (!result) return nullptr;

        WideCharToMultiByte(CP_ACP, 0, bstr, -1, result, len, NULL, NULL);
        return result;
    }

}
