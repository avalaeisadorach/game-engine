module gameengine.utils.memory;

import std.format;

string sfmt(Args...)(string fmt, Args args) pure
{
    static char[1024] buffer;

    return cast(string) sformat(buffer, fmt, args);
}