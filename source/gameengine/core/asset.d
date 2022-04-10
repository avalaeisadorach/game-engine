module gameengine.core.asset;

import std.exception : enforce;

import unstd.memory.weakref;

import gameengine.utils;
import gameengine.core;

// TODO: Make better
struct AssetManager
{
private static:
    LoadFunction[string] sLoaders;
    WeakReference!Object[string] sCache;

public static:
    alias LoadFunction = Object function(string path);

    void initialize()
    {

    }

    void cleanup()
    {
        Logger.core.write(LogLevel.debug_, "Freeing all remaining assets...");

        foreach (weakref; sCache)
            if (weakref.alive)
                destroy(weakref.target);
    }

    T load(T)(string path)
    {
        LoadFunction* loader = T.mangleof in sLoaders;
        enforce(loader, sfmt!"No loader found for type '%s'."(T.stringof));

        immutable string cacheKey = T.mangle ~ path;
        
        Object asset = sCache.get(cacheKey);
        if (asset)
            return cast(T) asset;

        asset = loader(path);
        T realAsset = cast(T) asset;

        enforce(realAsset, sfmt!"Loader function returned null or wrong type for '%s'!"(T.stringof));

        sCache[cacheKey] = asset;
        return realAsset;
    }
}