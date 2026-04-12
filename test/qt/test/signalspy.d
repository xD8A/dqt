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
module qt.test.signalspy;
extern(C++):

import qt.config;
import qt.core.bytearray;
import qt.core.list;
import qt.core.metaobject;
import qt.core.object;
import qt.core.objectdefs;
import qt.core.variant;
import qt.helpers;
import qt.test.testeventloop;


class QSignalSpy: QObject
{
public:
    /+ explicit +/this(const(QObject) obj, const(char)* aSignal)
    {
        import qt.core.logging;
        this.m_waiting = false;
        sig = QByteArray.create;
        args = typeof(args).create;
        collectedSignals = typeof(collectedSignals).create;

        if (!isObjectValid(obj))
            return;

        if (!aSignal) {
            mixin(qWarning)("QSignalSpy: Null signal name is not valid");
            return;
        }

        if (((aSignal[0] - '0') & 0x03) != QSIGNAL_CODE) {
            mixin(qWarning)("QSignalSpy: Not a valid signal, use the SIGNAL macro");
            return;
        }

        const(QByteArray) ba = QMetaObject.normalizedSignature(aSignal + 1);
        const(QMetaObject * ) mo = obj.metaObject();
        const(int) sigIndex = mo.indexOfMethod(ba.constData());
        if (sigIndex < 0) {
            mixin(qWarning)("QSignalSpy: No such signal: '%s'".ptr, ba.constData());
            return;
        }

        if (!connectToSignal(obj, sigIndex))
            return;

        sig = ba;
        auto tmp = mo.method(sigIndex); initArgs(tmp, obj);
    }

/+ #ifdef Q_CLANG_QDOC
    template <typename PointerToMemberFunction>
    QSignalSpy(const QObject *object, PointerToMemberFunction signal);
#else +/
    extern(D) this(Signal)(Signal sender) if (is(Signal: DQtMember!P, P...))
    {
        import qt.core.logging;
        import qt.core.metamacros;
        this.m_waiting = false;
        sig = QByteArray.create;
        args = typeof(args).create;
        collectedSignals = typeof(collectedSignals).create;

        static assert(Signal.Members.length == 1);

        auto signal0 = getMemberFunctionAddress!(Signal.Members[0]);
        auto obj = sender.obj;

        if (!isObjectValid(obj))
            return;

        if (!signal0) {
            mixin(qWarning)("QSignalSpy: Null signal name is not valid");
            return;
        }

        const(QMetaObject * ) mo = obj.metaObject();
        const(QMetaMethod) signalMetaMethod = QMetaMethod.fromSignal(sender);
        const(int) sigIndex = signalMetaMethod.methodIndex();

        if (!isSignalMetaMethodValid(signalMetaMethod))
            return;

        if (!connectToSignal(obj, sigIndex))
            return;

        sig = signalMetaMethod.methodSignature();
        auto tmp = mo.method(sigIndex); initArgs(tmp, obj);
    }
/+ #endif +/ // Q_CLANG_QDOC

    this(const(QObject) obj, ref const(QMetaMethod) signal)
    {
        this.m_waiting = false;
        args = typeof(args).create;
        collectedSignals = typeof(collectedSignals).create;

        if (isObjectValid(obj) && isSignalMetaMethodValid(signal) &&
            connectToSignal(obj, signal.methodIndex())) {
            sig = signal.methodSignature();
            initArgs(signal, obj);
        }
        else
        {
            sig = QByteArray.create;
        }
    }

    pragma(inline, true) final bool isValid() const { return !sig.isEmpty(); }
    pragma(inline, true) final QByteArray signal() const { return sig; }

    final bool wait(int timeout = 5000)
    {
        import qt.core.global;

        scope loop = new QTestEventLoop;

        (mixin(Q_ASSERT(q{!m_waiting})));
        const(qsizetype) origCount = collectedSignals.size();
        m_waiting = true;
        m_loop = loop;
        m_loop.enterLoopMSecs(timeout);
        m_loop = null;
        m_waiting = false;
        return collectedSignals.size() > origCount;
    }

    override int qt_metacall(QMetaObject.Call call, int methodId, void** a)
    {
        methodId = QObject.qt_metacall(call, methodId, a);
        if (methodId < 0)
            return methodId;

        if (call == QMetaObject.Call.InvokeMetaMethod) {
            if (methodId == 0) {
                appendArgs(a);
            }
            --methodId;
        }
        return methodId;
    }

private:
    final bool connectToSignal(const(QObject) sender, int sigIndex)
    {
        import qt.core.logging;
        import qt.core.namespace;

        /*extern(D) static __gshared*/ const(int) memberOffset = QObject.staticMetaObject.methodCount();
        const(bool) connected = QMetaObject.connect(
            sender, sigIndex, this, memberOffset, /+ Qt:: +/qt.core.namespace.ConnectionType.DirectConnection, null).toBool();

        if (!connected)
            mixin(qWarning)("QSignalSpy: QMetaObject::connect returned false. Unable to connect.");

        return connected;
    }

    static bool isSignalMetaMethodValid(ref const(QMetaMethod) signal)
    {
        import qt.core.logging;

        const(bool) valid = signal.isValid() && signal.methodType() == QMetaMethod.MethodType.Signal;

        if (!valid)
            mixin(qWarning)("QSignalSpy: Not a valid signal: '%s'".ptr, signal.methodSignature().constData());

        return valid;
    }

    static bool isObjectValid(const(QObject) object)
    {
        import qt.core.logging;

        const(bool) valid = !!object;

        if (!valid)
            mixin(qWarning)("QSignalSpy: Cannot spy on a null object");

        return valid;
    }

    final void initArgs(ref const(QMetaMethod) member, const(QObject) obj)
    {
        import qt.core.logging;
        import qt.core.metatype;

        args.reserve(member.parameterCount());
        for (int i = 0; i < member.parameterCount(); ++i) {
            QMetaType tp = member.parameterMetaType(i);
            if (!tp.isValid() && obj) {
                void*[2] argv = [cast(void*)&tp, &i];
                QMetaObject.metacall(const_cast!(QObject)(obj),
                                      QMetaObject.Call.RegisterMethodArgumentMetaType,
                                      member.methodIndex(), argv.ptr);
            }
            if (!tp.isValid()) {
                mixin(qWarning)(("QSignalSpy: Unable to handle parameter '%s' of type '%s' of method '%s',"
                         ~ " use qRegisterMetaType to register it.").ptr,
                         member.parameterNames().at(i).constData(),
                         member.parameterTypes().at(i).constData(),
                         member.name().constData());
            }
            args ~= tp.id();
        }
    }

    final void appendArgs(void** a)
    {
        import qt.core.metatype;

        QList!(QVariant) list = QList!(QVariant).create;
        list.reserve(args.size());
        for (int i = 0; i < args.size(); ++i) {
            const(QMetaType.Type) type = static_cast!(QMetaType.Type)(args.at(i));
            if (type == QMetaType.Type.QVariant)
                list ~= *reinterpret_cast!(QVariant*)(a[i + 1]);
            else
                list ~= QVariant(QMetaType(type), a[i + 1]);
        }
        collectedSignals.append(list);

        if (m_waiting)
            m_loop.exitLoop();
    }

    // the full, normalized signal name
    QByteArray sig;
    // holds the QMetaType types for the argument list of the signal
    QList!(int) args;

    QTestEventLoop m_loop;
    bool m_waiting;

    public QList!(QList!(QVariant)) collectedSignals;

    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

