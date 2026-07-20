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
module qt.widgets.graphicseffect;
extern(C++):

import qt.config;
import qt.core.flags;
import qt.core.global;
import qt.core.namespace;
import qt.core.object;
import qt.core.point;
import qt.core.rect;
import qt.gui.brush;
import qt.gui.color;
import qt.gui.painter;
import qt.gui.pixmap;
import qt.helpers;

/+ QT_REQUIRE_CONFIG(graphicseffect); +/



extern(C++, class) struct QGraphicsEffectSource;

extern(C++, class) struct QGraphicsEffectPrivate;
/// Binding for C++ class [QGraphicsEffect](https://doc.qt.io/qt-6/qgraphicseffect.html).
abstract class /+ Q_WIDGETS_EXPORT +/ QGraphicsEffect : QObject
{
    mixin(Q_OBJECT);
    /+ Q_PROPERTY(bool enabled READ isEnabled WRITE setEnabled NOTIFY enabledChanged) +/
public:
    enum ChangeFlag {
        SourceAttached = 0x1,
        SourceDetached = 0x2,
        SourceBoundingRectChanged = 0x4,
        SourceInvalidated = 0x8
    }
    /+ Q_DECLARE_FLAGS(ChangeFlags, ChangeFlag) +/
alias ChangeFlags = QFlags!(ChangeFlag);    /+ Q_FLAG(ChangeFlags) +/

    enum PixmapPadMode {
        NoPad,
        PadToTransparentBorder,
        PadToEffectiveBoundingRect
    }

    mixin(changeItaniumMangling(q{mangleConstructorBaseObject}, q{
    this(QObject parent = null);
    }));
    /+ virtual +/~this();

    /+ virtual +/ QRectF boundingRectFor(ref const(QRectF) sourceRect) const;
    final QRectF boundingRect() const;

    final bool isEnabled() const;

public /+ Q_SLOTS +/:
    @QSlot final void setEnabled(bool enable);
    @QSlot final void update();

/+ Q_SIGNALS +/public:
    @QSignal final void enabledChanged(bool enabled);

protected:
    mixin(changeItaniumMangling(q{mangleConstructorBaseObject}, q{
    this(ref QGraphicsEffectPrivate d, QObject parent = null);
    }));
    /+ virtual +/ abstract void draw(QPainter* painter);
    /+ virtual +/ void sourceChanged(ChangeFlags flags);
    final void updateBoundingRect();

    final bool sourceIsPixmap() const;
    final QRectF sourceBoundingRect(/+ Qt:: +/qt.core.namespace.CoordinateSystem system = /+ Qt:: +/qt.core.namespace.CoordinateSystem.LogicalCoordinates) const;
    final void drawSource(QPainter* painter);
    final QPixmap sourcePixmap(/+ Qt:: +/qt.core.namespace.CoordinateSystem system = /+ Qt:: +/qt.core.namespace.CoordinateSystem.LogicalCoordinates,
                             QPoint* offset = null,
                             PixmapPadMode mode = PixmapPadMode.PadToEffectiveBoundingRect) const;

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsEffect) +/
    /+ Q_DISABLE_COPY(QGraphicsEffect) +/
    /+ friend class QGraphicsItem; +/
    /+ friend class QGraphicsItemPrivate; +/
    /+ friend class QGraphicsScenePrivate; +/
    /+ friend class QWidget; +/
    /+ friend class QWidgetPrivate; +/

public:
    final QGraphicsEffectSource* source() const; // internal

    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
/+pragma(inline, true) QFlags!(QGraphicsEffect.ChangeFlags.enum_type) operator |(QGraphicsEffect.ChangeFlags.enum_type f1, QGraphicsEffect.ChangeFlags.enum_type f2)nothrow{return QFlags!(QGraphicsEffect.ChangeFlags.enum_type)(f1)|f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsEffect.ChangeFlags.enum_type) operator |(QGraphicsEffect.ChangeFlags.enum_type f1, QFlags!(QGraphicsEffect.ChangeFlags.enum_type) f2)nothrow{return f2|f1;}+/
/+pragma(inline, true) QFlags!(QGraphicsEffect.ChangeFlags.enum_type) operator &(QGraphicsEffect.ChangeFlags.enum_type f1, QGraphicsEffect.ChangeFlags.enum_type f2)nothrow{return QFlags!(QGraphicsEffect.ChangeFlags.enum_type)(f1)&f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsEffect.ChangeFlags.enum_type) operator &(QGraphicsEffect.ChangeFlags.enum_type f1, QFlags!(QGraphicsEffect.ChangeFlags.enum_type) f2)nothrow{return f2&f1;}+/
/+pragma(inline, true) QFlags!(QGraphicsEffect.ChangeFlags.enum_type) operator ^(QGraphicsEffect.ChangeFlags.enum_type f1, QGraphicsEffect.ChangeFlags.enum_type f2)nothrow{return QFlags!(QGraphicsEffect.ChangeFlags.enum_type)(f1)^f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsEffect.ChangeFlags.enum_type) operator ^(QGraphicsEffect.ChangeFlags.enum_type f1, QFlags!(QGraphicsEffect.ChangeFlags.enum_type) f2)nothrow{return f2^f1;}+/
/+pragma(inline, true) void operator +(QGraphicsEffect.ChangeFlags.enum_type f1, QGraphicsEffect.ChangeFlags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QGraphicsEffect.ChangeFlags.enum_type f1, QFlags!(QGraphicsEffect.ChangeFlags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QFlags!(QGraphicsEffect.ChangeFlags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsEffect.ChangeFlags.enum_type f1, QGraphicsEffect.ChangeFlags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsEffect.ChangeFlags.enum_type f1, QFlags!(QGraphicsEffect.ChangeFlags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QFlags!(QGraphicsEffect.ChangeFlags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QGraphicsEffect.ChangeFlags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QGraphicsEffect.ChangeFlags.enum_type f1, int f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QGraphicsEffect.ChangeFlags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsEffect.ChangeFlags.enum_type f1, int f2)nothrow;+/
static if (defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QGraphicsEffect.ChangeFlags operator ~(QGraphicsEffect.ChangeFlags.enum_type e)nothrow{return~QGraphicsEffect.ChangeFlags(e);}+/
/+pragma(inline, true) void operator |(QGraphicsEffect.ChangeFlags.enum_type f1, int f2)nothrow;+/
}
static if (!defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QIncompatibleFlag operator |(QGraphicsEffect.ChangeFlags.enum_type f1, int f2)nothrow{return QIncompatibleFlag(int(f1)|f2);}+/
}
/+ Q_DECLARE_OPERATORS_FOR_FLAGS(QGraphicsEffect::ChangeFlags) +/
extern(C++, class) struct QGraphicsColorizeEffectPrivate;
/// Binding for C++ class [QGraphicsColorizeEffect](https://doc.qt.io/qt-6/qgraphicscolorizeeffect.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsColorizeEffect: QGraphicsEffect
{
    mixin(Q_OBJECT);
    /+ Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(qreal strength READ strength WRITE setStrength NOTIFY strengthChanged) +/
public:
    this(QObject parent = null);
    ~this();

    final QColor color() const;
    final qreal strength() const;

public /+ Q_SLOTS +/:
    @QSlot final void setColor(ref const(QColor) c);
    @QSlot final void setStrength(qreal strength);

/+ Q_SIGNALS +/public:
    @QSignal final void colorChanged(ref const(QColor) color);
    @QSignal final void strengthChanged(qreal strength);

protected:
    override void draw(QPainter* painter);

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsColorizeEffect) +/
    /+ Q_DISABLE_COPY(QGraphicsColorizeEffect) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsBlurEffectPrivate;
/// Binding for C++ class [QGraphicsBlurEffect](https://doc.qt.io/qt-6/qgraphicsblureffect.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsBlurEffect: QGraphicsEffect
{
    mixin(Q_OBJECT);
    /+ Q_PROPERTY(qreal blurRadius READ blurRadius WRITE setBlurRadius NOTIFY blurRadiusChanged)
    Q_PROPERTY(BlurHints blurHints READ blurHints WRITE setBlurHints NOTIFY blurHintsChanged) +/
public:
    enum BlurHint {
        PerformanceHint = 0x00,
        QualityHint = 0x01,
        AnimationHint = 0x02
    }
    /+ Q_ENUM(BlurHint) +/
    /+ Q_DECLARE_FLAGS(BlurHints, BlurHint) +/
alias BlurHints = QFlags!(BlurHint);    /+ Q_FLAG(BlurHints) +/

    this(QObject parent = null);
    ~this();

    override QRectF boundingRectFor(ref const(QRectF) rect) const;
    final qreal blurRadius() const;
    final BlurHints blurHints() const;

public /+ Q_SLOTS +/:
    @QSlot final void setBlurRadius(qreal blurRadius);
    @QSlot final void setBlurHints(BlurHints hints);

/+ Q_SIGNALS +/public:
    @QSignal final void blurRadiusChanged(qreal blurRadius);
    @QSignal final void blurHintsChanged(BlurHints hints);

protected:
    override void draw(QPainter* painter);

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsBlurEffect) +/
    /+ Q_DISABLE_COPY(QGraphicsBlurEffect) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
/+pragma(inline, true) QFlags!(QGraphicsBlurEffect.BlurHints.enum_type) operator |(QGraphicsBlurEffect.BlurHints.enum_type f1, QGraphicsBlurEffect.BlurHints.enum_type f2)nothrow{return QFlags!(QGraphicsBlurEffect.BlurHints.enum_type)(f1)|f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsBlurEffect.BlurHints.enum_type) operator |(QGraphicsBlurEffect.BlurHints.enum_type f1, QFlags!(QGraphicsBlurEffect.BlurHints.enum_type) f2)nothrow{return f2|f1;}+/
/+pragma(inline, true) QFlags!(QGraphicsBlurEffect.BlurHints.enum_type) operator &(QGraphicsBlurEffect.BlurHints.enum_type f1, QGraphicsBlurEffect.BlurHints.enum_type f2)nothrow{return QFlags!(QGraphicsBlurEffect.BlurHints.enum_type)(f1)&f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsBlurEffect.BlurHints.enum_type) operator &(QGraphicsBlurEffect.BlurHints.enum_type f1, QFlags!(QGraphicsBlurEffect.BlurHints.enum_type) f2)nothrow{return f2&f1;}+/
/+pragma(inline, true) QFlags!(QGraphicsBlurEffect.BlurHints.enum_type) operator ^(QGraphicsBlurEffect.BlurHints.enum_type f1, QGraphicsBlurEffect.BlurHints.enum_type f2)nothrow{return QFlags!(QGraphicsBlurEffect.BlurHints.enum_type)(f1)^f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsBlurEffect.BlurHints.enum_type) operator ^(QGraphicsBlurEffect.BlurHints.enum_type f1, QFlags!(QGraphicsBlurEffect.BlurHints.enum_type) f2)nothrow{return f2^f1;}+/
/+pragma(inline, true) void operator +(QGraphicsBlurEffect.BlurHints.enum_type f1, QGraphicsBlurEffect.BlurHints.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QGraphicsBlurEffect.BlurHints.enum_type f1, QFlags!(QGraphicsBlurEffect.BlurHints.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QFlags!(QGraphicsBlurEffect.BlurHints.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsBlurEffect.BlurHints.enum_type f1, QGraphicsBlurEffect.BlurHints.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsBlurEffect.BlurHints.enum_type f1, QFlags!(QGraphicsBlurEffect.BlurHints.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QFlags!(QGraphicsBlurEffect.BlurHints.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QGraphicsBlurEffect.BlurHints.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QGraphicsBlurEffect.BlurHints.enum_type f1, int f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QGraphicsBlurEffect.BlurHints.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsBlurEffect.BlurHints.enum_type f1, int f2)nothrow;+/
static if (defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QGraphicsBlurEffect.BlurHints operator ~(QGraphicsBlurEffect.BlurHints.enum_type e)nothrow{return~QGraphicsBlurEffect.BlurHints(e);}+/
/+pragma(inline, true) void operator |(QGraphicsBlurEffect.BlurHints.enum_type f1, int f2)nothrow;+/
}
static if (!defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QIncompatibleFlag operator |(QGraphicsBlurEffect.BlurHints.enum_type f1, int f2)nothrow{return QIncompatibleFlag(int(f1)|f2);}+/
}

/+ Q_DECLARE_OPERATORS_FOR_FLAGS(QGraphicsBlurEffect::BlurHints) +/
extern(C++, class) struct QGraphicsDropShadowEffectPrivate;
/// Binding for C++ class [QGraphicsDropShadowEffect](https://doc.qt.io/qt-6/qgraphicsdropshadoweffect.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsDropShadowEffect: QGraphicsEffect
{
    mixin(Q_OBJECT);
    /+ Q_PROPERTY(QPointF offset READ offset WRITE setOffset NOTIFY offsetChanged)
    Q_PROPERTY(qreal xOffset READ xOffset WRITE setXOffset NOTIFY offsetChanged)
    Q_PROPERTY(qreal yOffset READ yOffset WRITE setYOffset NOTIFY offsetChanged)
    Q_PROPERTY(qreal blurRadius READ blurRadius WRITE setBlurRadius NOTIFY blurRadiusChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged) +/
public:
    this(QObject parent = null);
    ~this();

    override QRectF boundingRectFor(ref const(QRectF) rect) const;
    final QPointF offset() const;

    pragma(inline, true) final qreal xOffset() const
    { return offset().x(); }

    pragma(inline, true) final qreal yOffset() const
    { return offset().y(); }

    final qreal blurRadius() const;
    final QColor color() const;

public /+ Q_SLOTS +/:
    @QSlot final void setOffset(ref const(QPointF) ofs);

    pragma(inline, true) @QSlot final void setOffset(qreal dx, qreal dy)
    { auto tmp = QPointF(dx, dy); setOffset(tmp); }

    pragma(inline, true) @QSlot final void setOffset(qreal d)
    { auto tmp = QPointF(d, d); setOffset(tmp); }

    pragma(inline, true) @QSlot final void setXOffset(qreal dx)
    { auto tmp = QPointF(dx, yOffset()); setOffset(tmp); }

    pragma(inline, true) @QSlot final void setYOffset(qreal dy)
    { auto tmp = QPointF(xOffset(), dy); setOffset(tmp); }

    @QSlot final void setBlurRadius(qreal blurRadius);
    @QSlot final void setColor(ref const(QColor) color);

/+ Q_SIGNALS +/public:
    @QSignal final void offsetChanged(ref const(QPointF) offset);
    @QSignal final void blurRadiusChanged(qreal blurRadius);
    @QSignal final void colorChanged(ref const(QColor) color);

protected:
    override void draw(QPainter* painter);

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsDropShadowEffect) +/
    /+ Q_DISABLE_COPY(QGraphicsDropShadowEffect) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsOpacityEffectPrivate;
/// Binding for C++ class [QGraphicsOpacityEffect](https://doc.qt.io/qt-6/qgraphicsopacityeffect.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsOpacityEffect: QGraphicsEffect
{
    mixin(Q_OBJECT);
    /+ Q_PROPERTY(qreal opacity READ opacity WRITE setOpacity NOTIFY opacityChanged)
    Q_PROPERTY(QBrush opacityMask READ opacityMask WRITE setOpacityMask NOTIFY opacityMaskChanged) +/
public:
    this(QObject parent = null);
    ~this();

    final qreal opacity() const;
    final QBrush opacityMask() const;

public /+ Q_SLOTS +/:
    @QSlot final void setOpacity(qreal opacity);
    @QSlot final void setOpacityMask(ref const(QBrush) mask);

/+ Q_SIGNALS +/public:
    @QSignal final void opacityChanged(qreal opacity);
    @QSignal final void opacityMaskChanged(ref const(QBrush) mask);

protected:
    override void draw(QPainter* painter);

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsOpacityEffect) +/
    /+ Q_DISABLE_COPY(QGraphicsOpacityEffect) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
