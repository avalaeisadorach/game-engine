module gameengine.core.main;

import gameengine.core;

extern (C) Application createApplication(string[] args);

int main(string[] args)
{
    try
    {
        CoreEngine.initialize(createApplication(args));
        CoreEngine.start();
        CoreEngine.cleanup();
    }
    catch (Exception ex)
    {
        Logger.core.write(LogLevel.fatal, "Engine crashed!");
        Logger.core.write(LogLevel.fatal, ex.toString());
        Logger.core.write(LogLevel.fatal, "Please report this crash to Isadora Avalae. You know who.");
        
        return 1;
    }

    return 0;
}