module gameengine.core.logger;

enum LogLevel
{
    off,
    fatal,
    error,
    warning,
    info,
    debug_,
    trace
}

class Logger
{
protected:
    LogSink[] mSinks;
    LogLevel mMinLogLevel;
    string mName;

    static Logger sCore;
    static Logger sClient;

package (gameengine):
    static Logger core() @safe nothrow
    {
        return sCore;
    }

public:
    this(string name, LogLevel minLogLevel)
    {
        mName = name;
        mMinLogLevel = minLogLevel;
    }

    static void initialize()
    {
        sCore = new Logger("Core", LogLevel.trace);
        sClient = new Logger("Client", LogLevel.trace);

        LogSink sink = new FileLogSink(stdout);

        sCore.addSink(sink);
        sClient.addSink(sink);
    }

    void write(LogLevel level, string msg)
    {
        if (level > mMinLogLevel)
            return;

        foreach (LogSink sink; mSinks)
            sink.write(msg);
    }

    void addSink(LogSink sink)
    {
        mSinks ~= sink;
    }

    static Logger client() @safe nothrow
    {
        return sClient;
    }
}

interface LogSink
{
    void write(string msg);
}

import std.stdio;

class FileLogSink : LogSink
{
protected:
    File mFile;

public:
    this(File file)
    {
        mFile = file;
    }

    void write(string msg)
    {
        mFile.writeln(msg);
    }
}