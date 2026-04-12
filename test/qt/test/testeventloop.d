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
    /+ using QObject::QObject; +/

    pragma(inline, true) final void enterLoopMSecs(int ms)
    {
        import qt.core.global;

        (mixin(Q_ASSERT(q{!QTestEventLoop.loop})));

        scope l = new QEventLoop;

        _timeout = false;

        timerId = startTimer(ms);

        loop = l;
        l.exec();
        loop = null;
    }
    pragma(inline, true) final void enterLoop(int secs) { enterLoopMSecs(secs * 1000); }

    pragma(inline, true) final void changeInterval(int secs)
    { killTimer(timerId); timerId = startTimer(secs * 1000); }

    pragma(inline, true) final bool timeout() const
    { return _timeout; }

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
    /+ Q_DECL_UNUSED_MEMBER +/ bool inLoop; // ### Qt 6: remove
    bool _timeout = false;
    int timerId = -1;

    QEventLoop loop = null;
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

