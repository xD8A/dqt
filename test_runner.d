module test_runner;

// Importing the modules is enough: run with
// `dub run --build=unittest :unittest` (`-unittest`), so DRuntime runs every
// module's unittest blocks automatically before `main`.
import corelib.time.tst_calendar;
import corelib.time.tst_date;
import corelib.time.tst_time;
import corelib.time.tst_datetime;
import corelib.time.tst_timezone;

import qt_version : qtVersion;
import std.stdio : stdout, writeln;

// DRuntime calls module constructors before the module unittest blocks, so this
// is the first line of the CI log. Flush explicitly: stdout is block-buffered
// when redirected to a file in CI.
shared static this()
{
    writeln("Qt ", qtVersion);
    stdout.flush();
}

void main()
{
    // Empty on purpose: unittest blocks run automatically.
}
