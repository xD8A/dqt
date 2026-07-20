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
module qt.widgets.graphicsview;
extern(C++):

import qt.config;
import qt.core.coreevent;
import qt.core.flags;
import qt.core.global;
import qt.core.list;
import qt.core.namespace;
import qt.core.point;
import qt.core.rect;
import qt.core.size;
import qt.core.variant;
import qt.gui.brush;
import qt.gui.event;
import qt.gui.painter;
import qt.gui.painterpath;
import qt.gui.polygon;
import qt.gui.transform;
import qt.helpers;
import qt.widgets.abstractscrollarea;
import qt.widgets.graphicsitem;
import qt.widgets.graphicsscene;
import qt.widgets.styleoption;
import qt.widgets.widget;

/+ QT_REQUIRE_CONFIG(graphicsview); +/



extern(C++, class) struct QGraphicsViewPrivate;
/// Binding for C++ class [QGraphicsView](https://doc.qt.io/qt-6/qgraphicsview.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsView : QAbstractScrollArea
{
    mixin(Q_OBJECT);
    /+ Q_FLAGS(QPainter::RenderHints CacheMode OptimizationFlags)
    Q_PROPERTY(QBrush backgroundBrush READ backgroundBrush WRITE setBackgroundBrush)
    Q_PROPERTY(QBrush foregroundBrush READ foregroundBrush WRITE setForegroundBrush)
    Q_PROPERTY(bool interactive READ isInteractive WRITE setInteractive)
    Q_PROPERTY(QRectF sceneRect READ sceneRect WRITE setSceneRect)
    Q_PROPERTY(Qt::Alignment alignment READ alignment WRITE setAlignment)
    Q_PROPERTY(QPainter::RenderHints renderHints READ renderHints WRITE setRenderHints)
    Q_PROPERTY(DragMode dragMode READ dragMode WRITE setDragMode)
    Q_PROPERTY(CacheMode cacheMode READ cacheMode WRITE setCacheMode)
    Q_PROPERTY(ViewportAnchor transformationAnchor READ transformationAnchor
               WRITE setTransformationAnchor)
    Q_PROPERTY(ViewportAnchor resizeAnchor READ resizeAnchor WRITE setResizeAnchor)
    Q_PROPERTY(ViewportUpdateMode viewportUpdateMode READ viewportUpdateMode
               WRITE setViewportUpdateMode)
#if QT_CONFIG(rubberband)
    Q_PROPERTY(Qt::ItemSelectionMode rubberBandSelectionMode READ rubberBandSelectionMode
               WRITE setRubberBandSelectionMode)
#endif
    Q_PROPERTY(OptimizationFlags optimizationFlags READ optimizationFlags
               WRITE setOptimizationFlags) +/

public:
    enum ViewportAnchor {
        NoAnchor,
        AnchorViewCenter,
        AnchorUnderMouse
    }
    /+ Q_ENUM(ViewportAnchor) +/

    enum CacheModeFlag {
        CacheNone = 0x0,
        CacheBackground = 0x1
    }
    /+ Q_DECLARE_FLAGS(CacheMode, CacheModeFlag) +/
alias CacheMode = QFlags!(CacheModeFlag);
    enum DragMode {
        NoDrag,
        ScrollHandDrag,
        RubberBandDrag
    }
    /+ Q_ENUM(DragMode) +/

    enum ViewportUpdateMode {
        FullViewportUpdate,
        MinimalViewportUpdate,
        SmartViewportUpdate,
        NoViewportUpdate,
        BoundingRectViewportUpdate
    }
    /+ Q_ENUM(ViewportUpdateMode) +/

    enum OptimizationFlag {
        DontSavePainterState = 0x1,
        DontAdjustForAntialiasing = 0x2,
        IndirectPainting = 0x4
    }
    /+ Q_DECLARE_FLAGS(OptimizationFlags, OptimizationFlag) +/
alias OptimizationFlags = QFlags!(OptimizationFlag);
    this(QWidget parent = null);
    this(QGraphicsScene scene, QWidget parent = null);
    ~this();

    override QSize sizeHint() const;

    final QPainter.RenderHints renderHints() const;
    final void setRenderHint(QPainter.RenderHint hint, bool enabled = true);
    final void setRenderHints(QPainter.RenderHints hints);

    final /+ Qt:: +/qt.core.namespace.Alignment alignment() const;
    final void setAlignment(/+ Qt:: +/qt.core.namespace.Alignment alignment);

    final ViewportAnchor transformationAnchor() const;
    final void setTransformationAnchor(ViewportAnchor anchor);

    final ViewportAnchor resizeAnchor() const;
    final void setResizeAnchor(ViewportAnchor anchor);

    final ViewportUpdateMode viewportUpdateMode() const;
    final void setViewportUpdateMode(ViewportUpdateMode mode);

    final OptimizationFlags optimizationFlags() const;
    final void setOptimizationFlag(OptimizationFlag flag, bool enabled = true);
    final void setOptimizationFlags(OptimizationFlags flags);

    final DragMode dragMode() const;
    final void setDragMode(DragMode mode);

/+ #if QT_CONFIG(rubberband) +/
    final /+ Qt:: +/qt.core.namespace.ItemSelectionMode rubberBandSelectionMode() const;
    final void setRubberBandSelectionMode(/+ Qt:: +/qt.core.namespace.ItemSelectionMode mode);
    final QRect rubberBandRect() const;
/+ #endif +/

    final CacheMode cacheMode() const;
    final void setCacheMode(CacheMode mode);
    final void resetCachedContent();

    final bool isInteractive() const;
    final void setInteractive(bool allowed);

    final QGraphicsScene scene() const;
    final void setScene(QGraphicsScene scene);

    final QRectF sceneRect() const;
    final void setSceneRect(ref const(QRectF) rect);
    pragma(inline, true) final void setSceneRect(qreal ax, qreal ay, qreal aw, qreal ah)
    { auto tmp = QRectF(ax, ay, aw, ah); setSceneRect(tmp); }

    final QTransform transform() const;
    final QTransform viewportTransform() const;
    final bool isTransformed() const;
    final void setTransform(ref const(QTransform) matrix, bool combine = false);
    final void resetTransform();
    final void rotate(qreal angle);
    final void scale(qreal sx, qreal sy);
    final void shear(qreal sh, qreal sv);
    final void translate(qreal dx, qreal dy);

    final void centerOn(ref const(QPointF) pos);
    pragma(inline, true) final void centerOn(qreal ax, qreal ay)
    { auto tmp = QPointF(ax, ay); centerOn(tmp); }
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final void centerOn(const(QGraphicsItem) item);
    }));
    final void ensureVisible(ref const(QRectF) rect, int xmargin = 50, int ymargin = 50);
    pragma(inline, true) final void ensureVisible(qreal ax, qreal ay, qreal aw, qreal ah, int xmargin = 50, int ymargin = 50)
    { auto tmp = QRectF(ax, ay, aw, ah); ensureVisible(tmp, xmargin, ymargin); }
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final void ensureVisible(const(QGraphicsItem) item, int xmargin = 50, int ymargin = 50);
    }));
    final void fitInView(ref const(QRectF) rect, /+ Qt:: +/qt.core.namespace.AspectRatioMode aspectRadioMode = /+ Qt:: +/qt.core.namespace.AspectRatioMode.IgnoreAspectRatio);
    pragma(inline, true) final void fitInView(qreal ax, qreal ay, qreal w, qreal h,
                              /+ Qt:: +/qt.core.namespace.AspectRatioMode mode = /+ Qt:: +/qt.core.namespace.AspectRatioMode.IgnoreAspectRatio)
    { auto tmp = QRectF(ax, ay, w, h); fitInView(tmp, mode); }
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final void fitInView(const(QGraphicsItem) item,
                       /+ Qt:: +/qt.core.namespace.AspectRatioMode aspectRadioMode = /+ Qt:: +/qt.core.namespace.AspectRatioMode.IgnoreAspectRatio);
    }));

    final void render(QPainter* painter, ref const(QRectF) target = globalInitVar!QRectF, ref const(QRect) source = globalInitVar!QRect,
                    /+ Qt:: +/qt.core.namespace.AspectRatioMode aspectRatioMode = /+ Qt:: +/qt.core.namespace.AspectRatioMode.KeepAspectRatio);

    final QList!(QGraphicsItem) items() const;
    final QList!(QGraphicsItem) items(ref const(QPoint) pos) const;
    pragma(inline, true) final QList!(QGraphicsItem) items(int ax, int ay) const
    { auto tmp = QPoint(ax, ay); return items(tmp); }
    final QList!(QGraphicsItem) items(ref const(QRect) rect, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape) const;
    pragma(inline, true) final QList!(QGraphicsItem) items(int ax, int ay, int w, int h, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape) const
    { auto tmp = QRect(ax, ay, w, h); return items(tmp, mode); }
    final QList!(QGraphicsItem) items(ref const(QPolygon) polygon, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape) const;
    final QList!(QGraphicsItem) items(ref const(QPainterPath) path, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape) const;
    final QGraphicsItem itemAt(ref const(QPoint) pos) const;
    pragma(inline, true) final QGraphicsItem itemAt(int ax, int ay) const
    { auto tmp = QPoint(ax, ay); return itemAt(tmp); }

    final QPointF mapToScene(ref const(QPoint) point) const;
    final QPolygonF mapToScene(ref const(QRect) rect) const;
    final QPolygonF mapToScene(ref const(QPolygon) polygon) const;
    final QPainterPath mapToScene(ref const(QPainterPath) path) const;
    final QPoint mapFromScene(ref const(QPointF) point) const;
    final QPolygon mapFromScene(ref const(QRectF) rect) const;
    final QPolygon mapFromScene(ref const(QPolygonF) polygon) const;
    final QPainterPath mapFromScene(ref const(QPainterPath) path) const;
    pragma(inline, true) final QPointF mapToScene(int ax, int ay) const
    { auto tmp = QPoint(ax, ay); return mapToScene(tmp); }
    pragma(inline, true) final QPolygonF mapToScene(int ax, int ay, int w, int h) const
    { auto tmp = QRect(ax, ay, w, h); return mapToScene(tmp); }
    pragma(inline, true) final QPoint mapFromScene(qreal ax, qreal ay) const
    { auto tmp = QPointF(ax, ay); return mapFromScene(tmp); }
    pragma(inline, true) final QPolygon mapFromScene(qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return mapFromScene(tmp); }

    override QVariant inputMethodQuery(/+ Qt:: +/qt.core.namespace.InputMethodQuery query) const;

    final QBrush backgroundBrush() const;
    final void setBackgroundBrush(ref const(QBrush) brush);

    final QBrush foregroundBrush() const;
    final void setForegroundBrush(ref const(QBrush) brush);

public /+ Q_SLOTS +/:
    @QSlot final void updateScene(ref const(QList!(QRectF)) rects);
    @QSlot final void invalidateScene(ref const(QRectF) rect = globalInitVar!QRectF, QGraphicsScene.SceneLayers layers = QGraphicsScene.SceneLayer.AllLayers);
    @QSlot final void updateSceneRect(ref const(QRectF) rect);

/+ #if QT_CONFIG(rubberband) +/
/+ Q_SIGNALS +/public:
    @QSignal final void rubberBandChanged(QRect viewportRect, QPointF fromScenePoint, QPointF toScenePoint);
/+ #endif +/

protected /+ Q_SLOTS +/:
    @QSlot override void setupViewport(QWidget widget);

protected:
    this(ref QGraphicsViewPrivate , QWidget parent = null);
    override bool event(QEvent event);
    override bool viewportEvent(QEvent event);

/+ #ifndef QT_NO_CONTEXTMENU +/
    version (QT_NO_CONTEXTMENU) {} else
    {
        override void contextMenuEvent(QContextMenuEvent event);
    }
/+ #endif
#if QT_CONFIG(draganddrop) +/
    override void dragEnterEvent(QDragEnterEvent event);
    override void dragLeaveEvent(QDragLeaveEvent event);
    override void dragMoveEvent(QDragMoveEvent event);
    override void dropEvent(QDropEvent event);
/+ #endif +/
    override void focusInEvent(QFocusEvent event);
    override bool focusNextPrevChild(bool next);
    override void focusOutEvent(QFocusEvent event);
    override void keyPressEvent(QKeyEvent event);
    override void keyReleaseEvent(QKeyEvent event);
    override void mouseDoubleClickEvent(QMouseEvent event);
    override void mousePressEvent(QMouseEvent event);
    override void mouseMoveEvent(QMouseEvent event);
    override void mouseReleaseEvent(QMouseEvent event);
/+ #if QT_CONFIG(wheelevent) +/
    override void wheelEvent(QWheelEvent event);
/+ #endif +/
    override void paintEvent(QPaintEvent event);
    override void resizeEvent(QResizeEvent event);
    override void scrollContentsBy(int dx, int dy);
    override void showEvent(QShowEvent event);
    override void inputMethodEvent(QInputMethodEvent event);

    /+ virtual +/ void drawBackground(QPainter* painter, ref const(QRectF) rect);
    /+ virtual +/ void drawForeground(QPainter* painter, ref const(QRectF) rect);
    /+ virtual +/ void drawItems(QPainter* painter, int numItems,
                               QGraphicsItem/+[0]+/* items,
                               const(QStyleOptionGraphicsItem)/+[0]+/* options);

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsView) +/
    /+ Q_DISABLE_COPY(QGraphicsView) +/
/+ #ifndef QT_NO_CURSOR
    Q_PRIVATE_SLOT(d_func(), void _q_setViewportCursor(const QCursor &))
    Q_PRIVATE_SLOT(d_func(), void _q_unsetViewportCursor())
#endif +/
    /+ friend class QGraphicsSceneWidget; +/
    /+ friend class QGraphicsScene; +/
    /+ friend class QGraphicsScenePrivate; +/
    /+ friend class QGraphicsItemPrivate; +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
/+pragma(inline, true) QFlags!(QGraphicsView.CacheMode.enum_type) operator |(QGraphicsView.CacheMode.enum_type f1, QGraphicsView.CacheMode.enum_type f2)nothrow{return QFlags!(QGraphicsView.CacheMode.enum_type)(f1)|f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsView.CacheMode.enum_type) operator |(QGraphicsView.CacheMode.enum_type f1, QFlags!(QGraphicsView.CacheMode.enum_type) f2)nothrow{return f2|f1;}+/
/+pragma(inline, true) QFlags!(QGraphicsView.CacheMode.enum_type) operator &(QGraphicsView.CacheMode.enum_type f1, QGraphicsView.CacheMode.enum_type f2)nothrow{return QFlags!(QGraphicsView.CacheMode.enum_type)(f1)&f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsView.CacheMode.enum_type) operator &(QGraphicsView.CacheMode.enum_type f1, QFlags!(QGraphicsView.CacheMode.enum_type) f2)nothrow{return f2&f1;}+/
/+pragma(inline, true) QFlags!(QGraphicsView.CacheMode.enum_type) operator ^(QGraphicsView.CacheMode.enum_type f1, QGraphicsView.CacheMode.enum_type f2)nothrow{return QFlags!(QGraphicsView.CacheMode.enum_type)(f1)^f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsView.CacheMode.enum_type) operator ^(QGraphicsView.CacheMode.enum_type f1, QFlags!(QGraphicsView.CacheMode.enum_type) f2)nothrow{return f2^f1;}+/
/+pragma(inline, true) void operator +(QGraphicsView.CacheMode.enum_type f1, QGraphicsView.CacheMode.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QGraphicsView.CacheMode.enum_type f1, QFlags!(QGraphicsView.CacheMode.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QFlags!(QGraphicsView.CacheMode.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsView.CacheMode.enum_type f1, QGraphicsView.CacheMode.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsView.CacheMode.enum_type f1, QFlags!(QGraphicsView.CacheMode.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QFlags!(QGraphicsView.CacheMode.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QGraphicsView.CacheMode.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QGraphicsView.CacheMode.enum_type f1, int f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QGraphicsView.CacheMode.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsView.CacheMode.enum_type f1, int f2)nothrow;+/
static if (defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QGraphicsView.CacheMode operator ~(QGraphicsView.CacheMode.enum_type e)nothrow{return~QGraphicsView.CacheMode(e);}+/
/+pragma(inline, true) void operator |(QGraphicsView.CacheMode.enum_type f1, int f2)nothrow;+/
}
static if (!defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QIncompatibleFlag operator |(QGraphicsView.CacheMode.enum_type f1, int f2)nothrow{return QIncompatibleFlag(int(f1)|f2);}+/
}

/+ Q_DECLARE_OPERATORS_FOR_FLAGS(QGraphicsView::CacheMode) +/
/+pragma(inline, true) QFlags!(QGraphicsView.OptimizationFlags.enum_type) operator |(QGraphicsView.OptimizationFlags.enum_type f1, QGraphicsView.OptimizationFlags.enum_type f2)nothrow{return QFlags!(QGraphicsView.OptimizationFlags.enum_type)(f1)|f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsView.OptimizationFlags.enum_type) operator |(QGraphicsView.OptimizationFlags.enum_type f1, QFlags!(QGraphicsView.OptimizationFlags.enum_type) f2)nothrow{return f2|f1;}+/
/+pragma(inline, true) QFlags!(QGraphicsView.OptimizationFlags.enum_type) operator &(QGraphicsView.OptimizationFlags.enum_type f1, QGraphicsView.OptimizationFlags.enum_type f2)nothrow{return QFlags!(QGraphicsView.OptimizationFlags.enum_type)(f1)&f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsView.OptimizationFlags.enum_type) operator &(QGraphicsView.OptimizationFlags.enum_type f1, QFlags!(QGraphicsView.OptimizationFlags.enum_type) f2)nothrow{return f2&f1;}+/
/+pragma(inline, true) QFlags!(QGraphicsView.OptimizationFlags.enum_type) operator ^(QGraphicsView.OptimizationFlags.enum_type f1, QGraphicsView.OptimizationFlags.enum_type f2)nothrow{return QFlags!(QGraphicsView.OptimizationFlags.enum_type)(f1)^f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsView.OptimizationFlags.enum_type) operator ^(QGraphicsView.OptimizationFlags.enum_type f1, QFlags!(QGraphicsView.OptimizationFlags.enum_type) f2)nothrow{return f2^f1;}+/
/+pragma(inline, true) void operator +(QGraphicsView.OptimizationFlags.enum_type f1, QGraphicsView.OptimizationFlags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QGraphicsView.OptimizationFlags.enum_type f1, QFlags!(QGraphicsView.OptimizationFlags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QFlags!(QGraphicsView.OptimizationFlags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsView.OptimizationFlags.enum_type f1, QGraphicsView.OptimizationFlags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsView.OptimizationFlags.enum_type f1, QFlags!(QGraphicsView.OptimizationFlags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QFlags!(QGraphicsView.OptimizationFlags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QGraphicsView.OptimizationFlags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QGraphicsView.OptimizationFlags.enum_type f1, int f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QGraphicsView.OptimizationFlags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsView.OptimizationFlags.enum_type f1, int f2)nothrow;+/
static if (defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QGraphicsView.OptimizationFlags operator ~(QGraphicsView.OptimizationFlags.enum_type e)nothrow{return~QGraphicsView.OptimizationFlags(e);}+/
/+pragma(inline, true) void operator |(QGraphicsView.OptimizationFlags.enum_type f1, int f2)nothrow;+/
}
static if (!defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QIncompatibleFlag operator |(QGraphicsView.OptimizationFlags.enum_type f1, int f2)nothrow{return QIncompatibleFlag(int(f1)|f2);}+/
}
/+ Q_DECLARE_OPERATORS_FOR_FLAGS(QGraphicsView::OptimizationFlags) +/
