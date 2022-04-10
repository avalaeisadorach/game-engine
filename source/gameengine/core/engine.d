module gameengine.core.engine;

import core.thread;
import core.memory;

import gameengine.core;

struct CoreEngine
{
private static:
    Application sApplication;
    bool sRunning;

    void run()
    {
        // TODO: Make game loop somewhat representable

        while (sRunning)
        {
            sApplication.update();
            sApplication.render();

            Thread.sleep(msecs(1000 / 60));
        }
    }

public static:
    void initialize(Application application)
    {
        GC.disable();

        Logger.initialize();
        Logger.core.write(LogLevel.debug_, "Initializing engine...");

        sApplication = application;

        sApplication.initialize();
    }

    void start()
    {
        sRunning = true;

        run();
    }

    void stop()
    {
        sRunning = false;
    }

    void cleanup()
    {
        sApplication.cleanup();
    }
}