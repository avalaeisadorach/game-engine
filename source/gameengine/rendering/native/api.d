module gameengine.rendering.native.api;

import gameengine.common;

interface RenderAPI
{
    Window createWindow(WindowProperties properties);

    void draw(size_t count);

    void loadLibraries();

    void clear();
}