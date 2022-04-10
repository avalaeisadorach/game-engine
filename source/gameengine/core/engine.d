module gameengine.core.engine;

import core.thread;
import core.memory;

import gameengine.common;

struct CoreEngine
{
private static:
    Application sApplication;
    bool sRunning;
    RenderAPI sRenderAPI;

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

        import gameengine.rendering.opengl.api;
        sRenderAPI = new OpenGLRenderAPI();
        sRenderAPI.loadLibraries();

        sApplication = application;

        sApplication.mWindow = sRenderAPI.createWindow(sApplication.getWindowProperties());
        enforce(sApplication.mWindow, "Failed to create application window!");

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

    Application application()
    {
        return sApplication;
    }
}