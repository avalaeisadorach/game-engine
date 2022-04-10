module gameengine.core.application;

import gameengine.common;

abstract class Application
{
protected:
    string[] mProgramArgs;

package(gameengine.core):
    Window mWindow;

public:
    this(string[] args)
    {
        mProgramArgs = args;
    }

    abstract WindowProperties getWindowProperties();

    abstract void initialize();
    abstract void update();
    abstract void render();
    abstract void cleanup();

    Window window()
    {
        return mWindow;
    }
}