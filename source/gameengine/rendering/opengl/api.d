module gameengine.rendering.opengl.api;

import bindbc.sdl;
import bindbc.opengl;

import gameengine.common;
import gameengine.rendering.opengl;

class OpenGLRenderAPI : RenderAPI
{
public:
    Window createWindow(WindowProperties properties)
    {
        return new SDLWindow(properties);
    }

    void draw(size_t count)
    {

    }

    void loadLibraries()
    {
        SDLSupport sdlret = loadSDL();
        if (sdlret != sdlSupport)
        {
            switch (sdlret)
            {
            case SDLSupport.badLibrary:
                throw new Exception("Could not load specific symbols of SDL library!");

            case SDLSupport.noLibrary:
                throw new Exception("Could not find SDL library!");
            
            default:
            }
        }

        GLSupport glret = loadOpenGL();
        if (glret != glSupport)
        {
            switch (glret)
            {
            case GLSupport.badLibrary:
                throw new Exception("Could not load specific symbols of SDL library!");

            case GLSupport.noLibrary:
                throw new Exception("Could not find SDL library!");

            default:
            }
        }
    }

    void clear()
    {
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    }
}