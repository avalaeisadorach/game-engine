module gameengine.core.nativeobj;

interface NativeObject
{
    inout(void*) nativePtr() inout nothrow @nogc;
}