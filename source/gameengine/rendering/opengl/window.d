module gameengine.rendering.opengl.window;

import std.string : toStringz, fromStringz;

import bindbc.sdl;

import gameengine.common;

class SDLWindow : Window
{
protected:
    SDL_Window* mWindow;
    SDL_GLContext mGLContext;

public:
    this(in WindowProperties properties)
    {
        mWindow = SDL_CreateWindow(properties.title.toStringz, SDL_WINDOWPOS_CENTERED,
            SDL_WINDOWPOS_CENTERED, properties.size.x, properties.size.y, SDL_WINDOW_OPENGL);
        enforce(mWindow, sfmt("Failed to create window: %s", SDL_GetError().fromStringz));
        
        mGLContext = SDL_GL_CreateContext(mWindow);
        enforce(mGLContext, sfmt("Failed to create OpenGL context: %s", SDL_GetError().fromStringz));
    }

    ~this()
    {
        SDL_GL_DeleteContext(mGLContext);
        SDL_DestroyWindow(mWindow);
    }

    void update()
    {
        SDL_Event ev;

        while (SDL_PollEvent(&ev))
        {
            switch (ev.type)
            {
            case SDL_QUIT:
                CoreEngine.stop();
                break;

            default:
            }
        }
    }

    void swapBuffers()
    {
        SDL_GL_SwapWindow(mWindow);
    }

    inout(void*) nativePtr() inout nothrow @nogc
    {
        return mWindow;
    }
}