module gameengine.core.asset;

import std.exception : enforce;

import gameengine.core.weakref;

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
        {
            Object asset = weakref.get;

            if (asset)
                destroy(asset);
        }
    }

    T load(T)(string path)
    {
        LoadFunction* loader = T.mangleof in sLoaders;
        enforce(loader, sfmt!"No loader found for type '%s'."(T.stringof));

        immutable string cacheKey = T.mangle ~ path;
        
        if (auto weakref = sCache.get(cacheKey))
            if (Object asset = weakref.get)
                return cast(T) asset;

        T newAsset = cast(T) loader(path);
        enforce(newAsset, sfmt!"Loader function returned null or wrong type for '%s'!"(T.stringof));

        sCache[cacheKey] = weak!Object(newAsset);
        return newAsset;
    }
}