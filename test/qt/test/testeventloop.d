/*
 * DQt - D bindings for the Qt Toolkit
 *
 * GNU Lesser General Public License Usage
 * This file may be used under the terms of the GNU Lesser
 * General Public License version 3 as published by the Free Software
 * Foundation and appearing in the file LICENSE.LGPL3 included in the
 * packaging of this file. Please review the following information to
 * ensure the GNU Lesser General Public License version 3 requirements
 * will be met: https://www.gnu.org/licenses/lgpl-3.0.html.
 */
module qt.test.testeventloop;
extern(C++):

import qt.config;
import qt.core.coreevent;
import qt.core.eventloop;
import qt.core.object;
import qt.helpers;

class /+ Q_TESTLIB_EXPORT +/ QTestEventLoop : QObject
{
    mixin(Q_OBJECT);

public:
    this(QObject parent = null)
    {
        super(parent);
        this._timeout = false;
    }

    pragma(inline, true) final void enterLoopMSecs(int ms)
    {
        import qt.core.global;
        import qt.core.namespace;
        //import qt.test.testcase;

        (mixin(Q_ASSERT(q{!QTestEventLoop.loop})));
        _timeout = false;

        /+if (/+ QTest:: +/qt.test.testcase.runningTest() && /+ QTest:: +/qt.test.testcase.currentTestFailed())
            return;+/

        scope l = new QEventLoop;
        // if tests want to measure sub-second precision, use a precise timer
        timerId = startTimer(ms, ms < 1000 ? /+ Qt:: +/qt.core.namespace.TimerType.PreciseTimer : /+ Qt:: +/qt.core.namespace.TimerType.CoarseTimer);

        loop = l;
        l.exec();
        loop = null;
    }
    pragma(inline, true) final void enterLoop(int secs) { enterLoopMSecs(secs * 1000); }

    pragma(inline, true) final void changeInterval(int secs)
    { killTimer(timerId); timerId = startTimer(secs * 1000); }

    pragma(inline, true) final bool timeout() const
    { return (_timeout) != 0; }

    /+ inline static QTestEventLoop &instance()
    {
        static QPointer<QTestEventLoop> testLoop;
        if (testLoop.isNull())
            testLoop = new QTestEventLoop(QCoreApplication::instance());
        return *static_cast<QTestEventLoop *>(testLoop);
    } +/

public /+ Q_SLOTS +/:
    extern(D) pragma(inline, true) @QSlot final void exitLoop()
    {
        import qt.core.namespace;
        import qt.core.objectdefs;
        import qt.core.thread;

        if (thread() != QThread.currentThread())
        {
            QMetaObject.invokeMethod(this, "exitLoop", /+ Qt:: +/qt.core.namespace.ConnectionType.QueuedConnection);
            return;
        }

        if (timerId != -1)
            killTimer(timerId);
        timerId = -1;

        if (loop)
            loop.exit();
    }

protected:
    pragma(inline, true) override void timerEvent(QTimerEvent e)
    {
        if (e.timerId() != timerId)
            return;
        _timeout = true;
        exitLoop();
    }

private:
    QEventLoop loop = null;
    int timerId = -1;
    /+ uint _timeout   :1; +/
    uint bitfieldData__timeout;
    final uint _timeout() const nothrow
    {
        return (bitfieldData__timeout >> 0) & 0x1;
    }
    final uint _timeout(uint value) nothrow
    {
        bitfieldData__timeout = (bitfieldData__timeout & ~0x1) | ((value & 0x1) << 0);
        return value;
    }
    /+ Q_DECL_UNUSED_MEMBER +/ /+ uint reserved   :31; +/
    final uint reserved() const nothrow
    {
        return (bitfieldData__timeout >> 1) & 0x7fffffff;
    }
    final uint reserved(uint value) nothrow
    {
        bitfieldData__timeout = (bitfieldData__timeout & ~0xfffffffe) | ((value & 0x7fffffff) << 1);
        return value;
    }
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

