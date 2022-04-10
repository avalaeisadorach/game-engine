module gameengine.core.application;

abstract class Application
{
protected:
    string[] mProgramArgs;

public:
    this(string[] args)
    {
        mProgramArgs = args;
    }

    abstract void initialize();
    abstract void update();
    abstract void render();
    abstract void cleanup();
}