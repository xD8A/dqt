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
module qt.widgets.graphicstransform;
extern(C++):

import qt.config;
import qt.core.global;
import qt.core.namespace;
import qt.core.object;
import qt.gui.vector3d;
import qt.helpers;
static if (defined!"QT_NO_MATRIX4X4")
    import qt.core.metatype;
static if (!defined!"QT_NO_MATRIX4X4")
    import qt.gui.matrix4x4;

/+ QT_REQUIRE_CONFIG(graphicsview); +/


extern(C++, class) struct QGraphicsTransformPrivate;

/// Binding for C++ class [QGraphicsTransform](https://doc.qt.io/qt-6/qgraphicstransform.html).
abstract class /+ Q_WIDGETS_EXPORT +/ QGraphicsTransform : QObject
{
    mixin(Q_OBJECT);
public:
    mixin(changeItaniumMangling(q{mangleConstructorBaseObject}, q{
    this(QObject parent = null);
    }));
    ~this();

    /+ virtual +/ abstract void applyTo(QMatrix4x4* matrix) const;

protected /+ Q_SLOTS +/:
    @QSlot final void update();

protected:
    mixin(changeItaniumMangling(q{mangleConstructorBaseObject}, q{
    this(ref QGraphicsTransformPrivate p, QObject parent);
    }));

private:
    /+ friend class QGraphicsItem; +/
    /+ friend class QGraphicsItemPrivate; +/
    /+ Q_DECLARE_PRIVATE(QGraphicsTransform) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsScalePrivate;

/// Binding for C++ class [QGraphicsScale](https://doc.qt.io/qt-6/qgraphicsscale.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsScale : QGraphicsTransform
{
    mixin(Q_OBJECT);

    /+ Q_PROPERTY(QVector3D origin READ origin WRITE setOrigin NOTIFY originChanged)
    Q_PROPERTY(qreal xScale READ xScale WRITE setXScale NOTIFY xScaleChanged)
    Q_PROPERTY(qreal yScale READ yScale WRITE setYScale NOTIFY yScaleChanged)
    Q_PROPERTY(qreal zScale READ zScale WRITE setZScale NOTIFY zScaleChanged) +/
public:
    this(QObject parent = null);
    ~this();

    final QVector3D origin() const;
    final void setOrigin(ref const(QVector3D) point);

    final qreal xScale() const;
    final void setXScale(qreal);

    final qreal yScale() const;
    final void setYScale(qreal);

    final qreal zScale() const;
    final void setZScale(qreal);

    override void applyTo(QMatrix4x4* matrix) const;

/+ Q_SIGNALS +/public:
    @QSignal final void originChanged();
    @QSignal final void xScaleChanged();
    @QSignal final void yScaleChanged();
    @QSignal final void zScaleChanged();
    @QSignal final void scaleChanged();

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsScale) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsRotationPrivate;

/// Binding for C++ class [QGraphicsRotation](https://doc.qt.io/qt-6/qgraphicsrotation.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsRotation : QGraphicsTransform
{
    mixin(Q_OBJECT);

    /+ Q_PROPERTY(QVector3D origin READ origin WRITE setOrigin NOTIFY originChanged)
    Q_PROPERTY(qreal angle READ angle WRITE setAngle NOTIFY angleChanged)
    Q_PROPERTY(QVector3D axis READ axis WRITE setAxis NOTIFY axisChanged) +/
public:
    this(QObject parent = null);
    ~this();

    final QVector3D origin() const;
    final void setOrigin(ref const(QVector3D) point);

    final qreal angle() const;
    final void setAngle(qreal);

    final QVector3D axis() const;
    final void setAxis(ref const(QVector3D) axis);
    final void setAxis(/+ Qt:: +/qt.core.namespace.Axis axis);

    override void applyTo(QMatrix4x4* matrix) const;

/+ Q_SIGNALS +/public:
    @QSignal final void originChanged();
    @QSignal final void angleChanged();
    @QSignal final void axisChanged();

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsRotation) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
