module test_runner;

// Importing the modules is enough: run with
// `dub run --build=unittest :unittest` (`-unittest`), so DRuntime runs every
// module's unittest blocks automatically before `main`.
import corelib.time.tst_calendar;
import corelib.time.tst_date;
import corelib.time.tst_time;
import corelib.time.tst_datetime;
import corelib.time.tst_timezone;

void main()
{
    // Empty on purpose: unittest blocks run automatically.
}
