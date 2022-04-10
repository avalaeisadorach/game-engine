module gameengine.rendering.native.window;

import gameengine.common;

struct WindowProperties
{
    string title = "AGE Window";
    vec2i size = vec2i(800, 600);
}

interface Window : NativeObject
{
    void update();
    void swapBuffers();
}