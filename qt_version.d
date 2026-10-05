module qt_version;

import std.string : strip;

// The Qt version the tests are built/run against, written by the CI workflow
// into `.qt_version.txt` and read at compile time via `-J`
// (`stringImportPaths` in dub.json). It reflects the Qt library actually loaded
// (the container image), not DQt's compile-time header version (`QT_VERSION`),
// so the `Qt6_x` flags below can gate behaviour that differs between releases.
enum qtVersion = import(".qt_version.txt").strip;

private bool versionAtLeast(int major, int minor)
{
    import std.conv : to;
    import std.string : split;

    auto parts = qtVersion.split(".");
    if (parts.length < 2) return false;

    int mj = parts[0].to!int;
    int mn = parts[1].to!int;

    return mj > major || (mj == major && mn >= minor);
}

enum Qt6_4  = versionAtLeast(6, 4);
enum Qt6_5  = versionAtLeast(6, 5);
enum Qt6_6  = versionAtLeast(6, 6);
enum Qt6_7  = versionAtLeast(6, 7);
enum Qt6_8  = versionAtLeast(6, 8);
enum Qt6_9  = versionAtLeast(6, 9);
enum Qt6_10 = versionAtLeast(6, 10);
enum Qt6_11 = versionAtLeast(6, 11);
enum Qt6_12 = versionAtLeast(6, 12);
