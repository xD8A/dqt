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
module qt.widgets.graphicssceneevent;
extern(C++):

import qt.config;
import qt.core.coreevent;
import qt.core.global;
import qt.core.mimedata;
import qt.core.namespace;
import qt.core.point;
import qt.core.scopedpointer;
import qt.core.size;
import qt.helpers;
import qt.widgets.widget;

/+ QT_REQUIRE_CONFIG(graphicsview); +/



extern(C++, class) struct QGraphicsSceneEventPrivate;
/// Binding for C++ class [QGraphicsSceneEvent](https://doc.qt.io/qt-6/qgraphicssceneevent.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsSceneEvent : QEvent
{
public:
    /+ explicit +/this(Type type);
    ~this();

    final QWidget widget() const;
    final void setWidget(QWidget widget);

    final quint64 timestamp() const;
    final void setTimestamp(quint64 ts);

protected:
    this(ref QGraphicsSceneEventPrivate dd, Type type = Type.None);
    QScopedPointer!(QGraphicsSceneEventPrivate) d_ptr;
    /+ Q_DECLARE_PRIVATE(QGraphicsSceneEvent) +/
private:
    /+ Q_DISABLE_COPY(QGraphicsSceneEvent) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsSceneMouseEventPrivate;
/// Binding for C++ class [QGraphicsSceneMouseEvent](https://doc.qt.io/qt-6/qgraphicsscenemouseevent.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsSceneMouseEvent : QGraphicsSceneEvent
{
public:
    /+ explicit +/this(Type type = Type.None);
    ~this();

    final QPointF pos() const;
    final void setPos(ref const(QPointF) pos);

    final QPointF scenePos() const;
    final void setScenePos(ref const(QPointF) pos);

    final QPoint screenPos() const;
    final void setScreenPos(ref const(QPoint) pos);

    final QPointF buttonDownPos(/+ Qt:: +/qt.core.namespace.MouseButton button) const;
    final void setButtonDownPos(/+ Qt:: +/qt.core.namespace.MouseButton button, ref const(QPointF) pos);

    final QPointF buttonDownScenePos(/+ Qt:: +/qt.core.namespace.MouseButton button) const;
    final void setButtonDownScenePos(/+ Qt:: +/qt.core.namespace.MouseButton button, ref const(QPointF) pos);

    final QPoint buttonDownScreenPos(/+ Qt:: +/qt.core.namespace.MouseButton button) const;
    final void setButtonDownScreenPos(/+ Qt:: +/qt.core.namespace.MouseButton button, ref const(QPoint) pos);

    final QPointF lastPos() const;
    final void setLastPos(ref const(QPointF) pos);

    final QPointF lastScenePos() const;
    final void setLastScenePos(ref const(QPointF) pos);

    final QPoint lastScreenPos() const;
    final void setLastScreenPos(ref const(QPoint) pos);

    final /+ Qt:: +/qt.core.namespace.MouseButtons buttons() const;
    final void setButtons(/+ Qt:: +/qt.core.namespace.MouseButtons buttons);

    final /+ Qt:: +/qt.core.namespace.MouseButton button() const;
    final void setButton(/+ Qt:: +/qt.core.namespace.MouseButton button);

    final /+ Qt:: +/qt.core.namespace.KeyboardModifiers modifiers() const;
    final void setModifiers(/+ Qt:: +/qt.core.namespace.KeyboardModifiers modifiers);

    final /+ Qt:: +/qt.core.namespace.MouseEventSource source() const;
    final void setSource(/+ Qt:: +/qt.core.namespace.MouseEventSource source);

    final /+ Qt:: +/qt.core.namespace.MouseEventFlags flags() const;
    final void setFlags(/+ Qt:: +/qt.core.namespace.MouseEventFlags);

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsSceneMouseEvent) +/
    /+ Q_DISABLE_COPY(QGraphicsSceneMouseEvent) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsSceneWheelEventPrivate;
/// Binding for C++ class [QGraphicsSceneWheelEvent](https://doc.qt.io/qt-6/qgraphicsscenewheelevent.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsSceneWheelEvent : QGraphicsSceneEvent
{
public:
    /+ explicit +/this(Type type = Type.None);
    ~this();

    final QPointF pos() const;
    final void setPos(ref const(QPointF) pos);

    final QPointF scenePos() const;
    final void setScenePos(ref const(QPointF) pos);

    final QPoint screenPos() const;
    final void setScreenPos(ref const(QPoint) pos);

    final /+ Qt:: +/qt.core.namespace.MouseButtons buttons() const;
    final void setButtons(/+ Qt:: +/qt.core.namespace.MouseButtons buttons);

    final /+ Qt:: +/qt.core.namespace.KeyboardModifiers modifiers() const;
    final void setModifiers(/+ Qt:: +/qt.core.namespace.KeyboardModifiers modifiers);

    final int delta() const;
    final void setDelta(int delta);

    final /+ Qt:: +/qt.core.namespace.Orientation orientation() const;
    final void setOrientation(/+ Qt:: +/qt.core.namespace.Orientation orientation);

    final /+ Qt:: +/qt.core.namespace.ScrollPhase phase() const;
    final void setPhase(/+ Qt:: +/qt.core.namespace.ScrollPhase scrollPhase);

    final QPoint pixelDelta() const;
    final void setPixelDelta(QPoint delta);

    final bool isInverted() const;
    final void setInverted(bool inverted);

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsSceneWheelEvent) +/
    /+ Q_DISABLE_COPY(QGraphicsSceneWheelEvent) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsSceneContextMenuEventPrivate;
/// Binding for C++ class [QGraphicsSceneContextMenuEvent](https://doc.qt.io/qt-6/qgraphicsscenecontextmenuevent.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsSceneContextMenuEvent : QGraphicsSceneEvent
{
public:
    enum Reason { Mouse, Keyboard, Other }

    /+ explicit +/this(Type type = Type.None);
    ~this();

    final QPointF pos() const;
    final void setPos(ref const(QPointF) pos);

    final QPointF scenePos() const;
    final void setScenePos(ref const(QPointF) pos);

    final QPoint screenPos() const;
    final void setScreenPos(ref const(QPoint) pos);

    final /+ Qt:: +/qt.core.namespace.KeyboardModifiers modifiers() const;
    final void setModifiers(/+ Qt:: +/qt.core.namespace.KeyboardModifiers modifiers);

    final Reason reason() const;
    final void setReason(Reason reason);

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsSceneContextMenuEvent) +/
    /+ Q_DISABLE_COPY(QGraphicsSceneContextMenuEvent) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsSceneHoverEventPrivate;
/// Binding for C++ class [QGraphicsSceneHoverEvent](https://doc.qt.io/qt-6/qgraphicsscenehoverevent.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsSceneHoverEvent : QGraphicsSceneEvent
{
public:
    /+ explicit +/this(Type type = Type.None);
    ~this();

    final QPointF pos() const;
    final void setPos(ref const(QPointF) pos);

    final QPointF scenePos() const;
    final void setScenePos(ref const(QPointF) pos);

    final QPoint screenPos() const;
    final void setScreenPos(ref const(QPoint) pos);

    final QPointF lastPos() const;
    final void setLastPos(ref const(QPointF) pos);

    final QPointF lastScenePos() const;
    final void setLastScenePos(ref const(QPointF) pos);

    final QPoint lastScreenPos() const;
    final void setLastScreenPos(ref const(QPoint) pos);

    final /+ Qt:: +/qt.core.namespace.KeyboardModifiers modifiers() const;
    final void setModifiers(/+ Qt:: +/qt.core.namespace.KeyboardModifiers modifiers);

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsSceneHoverEvent) +/
    /+ Q_DISABLE_COPY(QGraphicsSceneHoverEvent) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsSceneHelpEventPrivate;
/// Binding for C++ class [QGraphicsSceneHelpEvent](https://doc.qt.io/qt-6/qgraphicsscenehelpevent.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsSceneHelpEvent : QGraphicsSceneEvent
{
public:
    /+ explicit +/this(Type type = Type.None);
    ~this();

    final QPointF scenePos() const;
    final void setScenePos(ref const(QPointF) pos);

    final QPoint screenPos() const;
    final void setScreenPos(ref const(QPoint) pos);

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsSceneHelpEvent) +/
    /+ Q_DISABLE_COPY(QGraphicsSceneHelpEvent) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsSceneDragDropEventPrivate;
/// Binding for C++ class [QGraphicsSceneDragDropEvent](https://doc.qt.io/qt-6/qgraphicsscenedragdropevent.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsSceneDragDropEvent : QGraphicsSceneEvent
{
public:
    /+ explicit +/this(Type type = Type.None);
    ~this();

    final QPointF pos() const;
    final void setPos(ref const(QPointF) pos);

    final QPointF scenePos() const;
    final void setScenePos(ref const(QPointF) pos);

    final QPoint screenPos() const;
    final void setScreenPos(ref const(QPoint) pos);

    final /+ Qt:: +/qt.core.namespace.MouseButtons buttons() const;
    final void setButtons(/+ Qt:: +/qt.core.namespace.MouseButtons buttons);

    final /+ Qt:: +/qt.core.namespace.KeyboardModifiers modifiers() const;
    final void setModifiers(/+ Qt:: +/qt.core.namespace.KeyboardModifiers modifiers);

    final /+ Qt:: +/qt.core.namespace.DropActions possibleActions() const;
    final void setPossibleActions(/+ Qt:: +/qt.core.namespace.DropActions actions);

    final /+ Qt:: +/qt.core.namespace.DropAction proposedAction() const;
    final void setProposedAction(/+ Qt:: +/qt.core.namespace.DropAction action);
    final void acceptProposedAction();

    final /+ Qt:: +/qt.core.namespace.DropAction dropAction() const;
    final void setDropAction(/+ Qt:: +/qt.core.namespace.DropAction action);

    final QWidget source() const;
    final void setSource(QWidget source);

    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final const(QMimeData) mimeData() const;
    }));
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final void setMimeData(const(QMimeData) data);
    }));

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsSceneDragDropEvent) +/
    /+ Q_DISABLE_COPY(QGraphicsSceneDragDropEvent) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsSceneResizeEventPrivate;
/// Binding for C++ class [QGraphicsSceneResizeEvent](https://doc.qt.io/qt-6/qgraphicssceneresizeevent.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsSceneResizeEvent : QGraphicsSceneEvent
{
private:
    /+ Q_DECLARE_PRIVATE(QGraphicsSceneResizeEvent) +/
    /+ Q_DISABLE_COPY(QGraphicsSceneResizeEvent) +/
public:
    this();
    ~this();

    final QSizeF oldSize() const;
    final void setOldSize(ref const(QSizeF) size);

    final QSizeF newSize() const;
    final void setNewSize(ref const(QSizeF) size);
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsSceneMoveEventPrivate;
/// Binding for C++ class [QGraphicsSceneMoveEvent](https://doc.qt.io/qt-6/qgraphicsscenemoveevent.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsSceneMoveEvent : QGraphicsSceneEvent
{
private:
    /+ Q_DECLARE_PRIVATE(QGraphicsSceneMoveEvent) +/
    /+ Q_DISABLE_COPY(QGraphicsSceneMoveEvent) +/
public:
    this();
    ~this();

    final QPointF oldPos() const;
    final void setOldPos(ref const(QPointF) pos);

    final QPointF newPos() const;
    final void setNewPos(ref const(QPointF) pos);
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

/+ #ifndef QT_NO_DEBUG_STREAM
Q_WIDGETS_EXPORT QDebug operator<<(QDebug, const QGraphicsSceneEvent *);
#endif +/
