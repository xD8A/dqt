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
module qt.widgets.graphicsscene;
extern(C++):

import qt.config;
import qt.core.coreevent;
import qt.core.flags;
import qt.core.global;
import qt.core.line;
import qt.core.list;
import qt.core.namespace;
import qt.core.object;
import qt.core.point;
import qt.core.rect;
import qt.core.string;
import qt.core.variant;
import qt.gui.action;
import qt.gui.brush;
import qt.gui.event;
import qt.gui.font;
import qt.gui.painter;
import qt.gui.painterpath;
import qt.gui.palette;
import qt.gui.pen;
import qt.gui.pixmap;
import qt.gui.polygon;
import qt.gui.transform;
import qt.helpers;
import qt.widgets.graphicsitem;
import qt.widgets.graphicssceneevent;
import qt.widgets.graphicsview;
import qt.widgets.style;
import qt.widgets.styleoption;
import qt.widgets.widget;

/+ QT_REQUIRE_CONFIG(graphicsview); +/


extern(C++, class) struct QGraphicsSceneIndex;

extern(C++, class) struct QGraphicsScenePrivate;
/// Binding for C++ class [QGraphicsScene](https://doc.qt.io/qt-6/qgraphicsscene.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsScene : QObject
{
    mixin(Q_OBJECT);
    /+ Q_PROPERTY(QBrush backgroundBrush READ backgroundBrush WRITE setBackgroundBrush)
    Q_PROPERTY(QBrush foregroundBrush READ foregroundBrush WRITE setForegroundBrush)
    Q_PROPERTY(ItemIndexMethod itemIndexMethod READ itemIndexMethod WRITE setItemIndexMethod)
    Q_PROPERTY(QRectF sceneRect READ sceneRect WRITE setSceneRect)
    Q_PROPERTY(int bspTreeDepth READ bspTreeDepth WRITE setBspTreeDepth)
    Q_PROPERTY(QPalette palette READ palette WRITE setPalette)
    Q_PROPERTY(QFont font READ font WRITE setFont)
    Q_PROPERTY(bool stickyFocus READ stickyFocus WRITE setStickyFocus)
    Q_PROPERTY(qreal minimumRenderSize READ minimumRenderSize WRITE setMinimumRenderSize)
    Q_PROPERTY(bool focusOnTouch READ focusOnTouch WRITE setFocusOnTouch) +/

public:
    enum ItemIndexMethod {
        BspTreeIndex,
        NoIndex = -1
    }
    /+ Q_ENUM(ItemIndexMethod) +/
    enum SceneLayer {
        ItemLayer = 0x1,
        BackgroundLayer = 0x2,
        ForegroundLayer = 0x4,
        AllLayers = 0xffff
    }
    /+ Q_DECLARE_FLAGS(SceneLayers, SceneLayer) +/
alias SceneLayers = QFlags!(SceneLayer);
    this(QObject parent = null);
    this(ref const(QRectF) sceneRect, QObject parent = null);
    this(qreal x, qreal y, qreal width, qreal height, QObject parent = null);
    /+ virtual +/~this();

    final QRectF sceneRect() const;
    pragma(inline, true) final qreal width() const { return sceneRect().width(); }
    pragma(inline, true) final qreal height() const { return sceneRect().height(); }
    final void setSceneRect(ref const(QRectF) rect);
    pragma(inline, true) final void setSceneRect(qreal x, qreal y, qreal w, qreal h)
    { auto tmp = QRectF(x, y, w, h); setSceneRect(tmp); }

    final void render(QPainter* painter,
                    ref const(QRectF) target = globalInitVar!QRectF, ref const(QRectF) source = globalInitVar!QRectF,
                    /+ Qt:: +/qt.core.namespace.AspectRatioMode aspectRatioMode = /+ Qt:: +/qt.core.namespace.AspectRatioMode.KeepAspectRatio);

    final ItemIndexMethod itemIndexMethod() const;
    final void setItemIndexMethod(ItemIndexMethod method);

    final int bspTreeDepth() const;
    final void setBspTreeDepth(int depth);

    final QRectF itemsBoundingRect() const;

    final QList!(QGraphicsItem) items(/+ Qt:: +/qt.core.namespace.SortOrder order = /+ Qt:: +/qt.core.namespace.SortOrder.DescendingOrder) const;

    final QList!(QGraphicsItem) items(ref const(QPointF) pos, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape, /+ Qt:: +/qt.core.namespace.SortOrder order = /+ Qt:: +/qt.core.namespace.SortOrder.DescendingOrder, ref const(QTransform) deviceTransform = globalInitVar!QTransform) const;
    final QList!(QGraphicsItem) items(ref const(QRectF) rect, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape, /+ Qt:: +/qt.core.namespace.SortOrder order = /+ Qt:: +/qt.core.namespace.SortOrder.DescendingOrder, ref const(QTransform) deviceTransform = globalInitVar!QTransform) const;
    final QList!(QGraphicsItem) items(ref const(QPolygonF) polygon, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape, /+ Qt:: +/qt.core.namespace.SortOrder order = /+ Qt:: +/qt.core.namespace.SortOrder.DescendingOrder, ref const(QTransform) deviceTransform = globalInitVar!QTransform) const;
    final QList!(QGraphicsItem) items(ref const(QPainterPath) path, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape, /+ Qt:: +/qt.core.namespace.SortOrder order = /+ Qt:: +/qt.core.namespace.SortOrder.DescendingOrder, ref const(QTransform) deviceTransform = globalInitVar!QTransform) const;
    pragma(inline, true) final QList!(QGraphicsItem) items(qreal x, qreal y, qreal w, qreal h, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode, /+ Qt:: +/qt.core.namespace.SortOrder order,
                                            ref const(QTransform) deviceTransform = globalInitVar!QTransform) const
    { auto tmp = QRectF(x, y, w, h); return items(tmp, mode, order, deviceTransform); }

    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final QList!(QGraphicsItem) collidingItems(const(QGraphicsItem) item, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape) const;
    }));
    final QGraphicsItem itemAt(ref const(QPointF) pos, ref const(QTransform) deviceTransform) const;
    pragma(inline, true) final QGraphicsItem itemAt(qreal x, qreal y, ref const(QTransform) deviceTransform) const
    { auto tmp = QPointF(x, y); return itemAt(tmp, deviceTransform); }

    final QList!(QGraphicsItem) selectedItems() const;
    final QPainterPath selectionArea() const;
    final void setSelectionArea(ref const(QPainterPath) path, ref const(QTransform) deviceTransform);
    final void setSelectionArea(ref const(QPainterPath) path, /+ Qt:: +/qt.core.namespace.ItemSelectionOperation selectionOperation = /+ Qt:: +/qt.core.namespace.ItemSelectionOperation.ReplaceSelection, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape, ref const(QTransform) deviceTransform = globalInitVar!QTransform);

    final QGraphicsItemGroup createItemGroup(ref const(QList!(QGraphicsItem)) items);
    final void destroyItemGroup(QGraphicsItemGroup group);

    final void addItem(QGraphicsItem item);
    pragma(inline, true) final void addItem(QGraphicsObject obj)
    {
        auto itm = obj.asGraphicsItem();
        this.addItem(itm);
    }
    final QGraphicsEllipseItem addEllipse(ref const(QRectF) rect, ref const(QPen) pen/* = globalInitVar!QPen */, ref const(QBrush) brush/* = globalInitVar!QBrush */);
    final QGraphicsLineItem addLine(ref const(QLineF) line, ref const(QPen) pen/* = globalInitVar!QPen */);
    final QGraphicsPathItem addPath(ref const(QPainterPath) path, ref const(QPen) pen/* = globalInitVar!QPen */, ref const(QBrush) brush/* = globalInitVar!QBrush */);
    final QGraphicsPixmapItem addPixmap(ref const(QPixmap) pixmap);
    final QGraphicsPolygonItem addPolygon(ref const(QPolygonF) polygon, ref const(QPen) pen/* = globalInitVar!QPen */, ref const(QBrush) brush/* = globalInitVar!QBrush */);
    final QGraphicsRectItem addRect(ref const(QRectF) rect, ref const(QPen) pen/* = globalInitVar!QPen */, ref const(QBrush) brush/* = globalInitVar!QBrush */);
    final QGraphicsTextItem addText(ref const(QString) text, ref const(QFont) font/* = globalInitVar!QFont */);
    final QGraphicsSimpleTextItem addSimpleText(ref const(QString) text, ref const(QFont) font/* = globalInitVar!QFont */);
    final QGraphicsProxyWidget* addWidget(QWidget widget, /+ Qt:: +/qt.core.namespace.WindowFlags wFlags = /+ Qt:: +/qt.core.namespace.WindowFlags());
    pragma(inline, true) final QGraphicsEllipseItem addEllipse(qreal x, qreal y, qreal w, qreal h, ref const(QPen) pen/* = globalInitVar!QPen */, ref const(QBrush) brush/* = globalInitVar!QBrush */)
    { auto tmp = QRectF(x, y, w, h); return addEllipse(tmp, pen, brush); }
    pragma(inline, true) final QGraphicsLineItem addLine(qreal x1, qreal y1, qreal x2, qreal y2, ref const(QPen) pen/* = globalInitVar!QPen */)
    { auto tmp = QLineF(x1, y1, x2, y2); return addLine(tmp, pen); }
    pragma(inline, true) final QGraphicsRectItem addRect(qreal x, qreal y, qreal w, qreal h, ref const(QPen) pen/* = globalInitVar!QPen */, ref const(QBrush) brush/* = globalInitVar!QBrush */)
    { auto tmp = QRectF(x, y, w, h); return addRect(tmp, pen, brush); }
    final void removeItem(QGraphicsItem item);

    final QGraphicsItem focusItem() const;
    final void setFocusItem(QGraphicsItem item, /+ Qt:: +/qt.core.namespace.FocusReason focusReason = /+ Qt:: +/qt.core.namespace.FocusReason.OtherFocusReason);
    final bool hasFocus() const;
    final void setFocus(/+ Qt:: +/qt.core.namespace.FocusReason focusReason = /+ Qt:: +/qt.core.namespace.FocusReason.OtherFocusReason);
    final void clearFocus();

    final void setStickyFocus(bool enabled);
    final bool stickyFocus() const;

    final QGraphicsItem mouseGrabberItem() const;

    final QBrush backgroundBrush() const;
    final void setBackgroundBrush(ref const(QBrush) brush);

    final QBrush foregroundBrush() const;
    final void setForegroundBrush(ref const(QBrush) brush);

    /+ virtual +/ QVariant inputMethodQuery(/+ Qt:: +/qt.core.namespace.InputMethodQuery query) const;

    final  QList!(QGraphicsView) views() const;

    pragma(inline, true) final void update(qreal x, qreal y, qreal w, qreal h)
    { auto tmp = QRectF(x, y, w, h); update(tmp); }
    pragma(inline, true) final void invalidate(qreal x, qreal y, qreal w, qreal h, SceneLayers layers = SceneLayer.AllLayers)
    { auto tmp = QRectF(x, y, w, h); invalidate(tmp, layers); }

    final QStyle style() const;
    final void setStyle(QStyle style);

    final QFont font() const;
    final void setFont(ref const(QFont) font);

    final QPalette palette() const;
    final void setPalette(ref const(QPalette) palette);

    final bool isActive() const;
    final QGraphicsItem activePanel() const;
    final void setActivePanel(QGraphicsItem item);
    final QGraphicsWidget* activeWindow() const;
    final void setActiveWindow(QGraphicsWidget* widget);

    final bool sendEvent(QGraphicsItem item, QEvent event);

    final qreal minimumRenderSize() const;
    final void setMinimumRenderSize(qreal minSize);

    final bool focusOnTouch() const;
    final void setFocusOnTouch(bool enabled);

public /+ Q_SLOTS +/:
    @QSlot final void update(ref const(QRectF) rect = globalInitVar!QRectF);
    @QSlot final void invalidate(ref const(QRectF) rect = globalInitVar!QRectF, SceneLayers layers = SceneLayer.AllLayers);
    @QSlot final void advance();
    @QSlot final void clearSelection();
    @QSlot final void clear();

protected:
    override bool event(QEvent event);
    override bool eventFilter(QObject watched, QEvent event);
    /+ virtual +/ void contextMenuEvent(QGraphicsSceneContextMenuEvent event);
    /+ virtual +/ void dragEnterEvent(QGraphicsSceneDragDropEvent event);
    /+ virtual +/ void dragMoveEvent(QGraphicsSceneDragDropEvent event);
    /+ virtual +/ void dragLeaveEvent(QGraphicsSceneDragDropEvent event);
    /+ virtual +/ void dropEvent(QGraphicsSceneDragDropEvent event);
    /+ virtual +/ void focusInEvent(QFocusEvent event);
    /+ virtual +/ void focusOutEvent(QFocusEvent event);
    /+ virtual +/ void helpEvent(QGraphicsSceneHelpEvent event);
    /+ virtual +/ void keyPressEvent(QKeyEvent event);
    /+ virtual +/ void keyReleaseEvent(QKeyEvent event);
    /+ virtual +/ void mousePressEvent(QGraphicsSceneMouseEvent event);
    /+ virtual +/ void mouseMoveEvent(QGraphicsSceneMouseEvent event);
    /+ virtual +/ void mouseReleaseEvent(QGraphicsSceneMouseEvent event);
    /+ virtual +/ void mouseDoubleClickEvent(QGraphicsSceneMouseEvent event);
    /+ virtual +/ void wheelEvent(QGraphicsSceneWheelEvent event);
    /+ virtual +/ void inputMethodEvent(QInputMethodEvent event);

    /+ virtual +/ void drawBackground(QPainter* painter, ref const(QRectF) rect);
    /+ virtual +/ void drawForeground(QPainter* painter, ref const(QRectF) rect);
    /+ virtual +/ void drawItems(QPainter* painter, int numItems,
                               QGraphicsItem/+[0]+/* items,
                               const(QStyleOptionGraphicsItem)/+[0]+/* options,
                               QWidget widget = null);

protected /+ Q_SLOTS +/:
    /+ virtual +/ @QSlot bool focusNextPrevChild(bool next);

/+ Q_SIGNALS +/public:
    @QSignal final void changed(ref const(QList!(QRectF)) region);
    @QSignal final void sceneRectChanged(ref const(QRectF) rect);
    @QSignal final void selectionChanged();
    @QSignal final void focusItemChanged(QGraphicsItem newFocus, QGraphicsItem oldFocus, /+ Qt:: +/qt.core.namespace.FocusReason reason);

private:
    /+ Q_DECLARE_PRIVATE(QGraphicsScene) +/
    /+ Q_DISABLE_COPY(QGraphicsScene) +/
    /+ Q_PRIVATE_SLOT(d_func(), void _q_emitUpdated())
    Q_PRIVATE_SLOT(d_func(), void _q_polishItems())
    Q_PRIVATE_SLOT(d_func(), void _q_processDirtyItems())
    Q_PRIVATE_SLOT(d_func(), void _q_updateScenePosDescendants()) +/
    /+ friend class QGraphicsItem; +/
    /+ friend class QGraphicsItemPrivate; +/
    /+ friend class QGraphicsObject; +/
    /+ friend class QGraphicsView; +/
    /+ friend class QGraphicsViewPrivate; +/
    /+ friend class QGraphicsWidget; +/
    /+ friend class QGraphicsWidgetPrivate; +/
    /+ friend class QGraphicsEffect; +/
    /+ friend class QGraphicsSceneIndex; +/
    /+ friend class QGraphicsSceneIndexPrivate; +/
    /+ friend class QGraphicsSceneBspTreeIndex; +/
    /+ friend class QGraphicsSceneBspTreeIndexPrivate; +/
    /+ friend class QGraphicsItemEffectSourcePrivate; +/
    version (QT_NO_GESTURES) {} else
    {
        /+ friend class QGesture; +/
    }
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
/+pragma(inline, true) QFlags!(QGraphicsScene.SceneLayers.enum_type) operator |(QGraphicsScene.SceneLayers.enum_type f1, QGraphicsScene.SceneLayers.enum_type f2)nothrow{return QFlags!(QGraphicsScene.SceneLayers.enum_type)(f1)|f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsScene.SceneLayers.enum_type) operator |(QGraphicsScene.SceneLayers.enum_type f1, QFlags!(QGraphicsScene.SceneLayers.enum_type) f2)nothrow{return f2|f1;}+/
/+pragma(inline, true) QFlags!(QGraphicsScene.SceneLayers.enum_type) operator &(QGraphicsScene.SceneLayers.enum_type f1, QGraphicsScene.SceneLayers.enum_type f2)nothrow{return QFlags!(QGraphicsScene.SceneLayers.enum_type)(f1)&f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsScene.SceneLayers.enum_type) operator &(QGraphicsScene.SceneLayers.enum_type f1, QFlags!(QGraphicsScene.SceneLayers.enum_type) f2)nothrow{return f2&f1;}+/
/+pragma(inline, true) QFlags!(QGraphicsScene.SceneLayers.enum_type) operator ^(QGraphicsScene.SceneLayers.enum_type f1, QGraphicsScene.SceneLayers.enum_type f2)nothrow{return QFlags!(QGraphicsScene.SceneLayers.enum_type)(f1)^f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsScene.SceneLayers.enum_type) operator ^(QGraphicsScene.SceneLayers.enum_type f1, QFlags!(QGraphicsScene.SceneLayers.enum_type) f2)nothrow{return f2^f1;}+/
/+pragma(inline, true) void operator +(QGraphicsScene.SceneLayers.enum_type f1, QGraphicsScene.SceneLayers.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QGraphicsScene.SceneLayers.enum_type f1, QFlags!(QGraphicsScene.SceneLayers.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QFlags!(QGraphicsScene.SceneLayers.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsScene.SceneLayers.enum_type f1, QGraphicsScene.SceneLayers.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsScene.SceneLayers.enum_type f1, QFlags!(QGraphicsScene.SceneLayers.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QFlags!(QGraphicsScene.SceneLayers.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QGraphicsScene.SceneLayers.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QGraphicsScene.SceneLayers.enum_type f1, int f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QGraphicsScene.SceneLayers.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsScene.SceneLayers.enum_type f1, int f2)nothrow;+/
static if (defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QGraphicsScene.SceneLayers operator ~(QGraphicsScene.SceneLayers.enum_type e)nothrow{return~QGraphicsScene.SceneLayers(e);}+/
/+pragma(inline, true) void operator |(QGraphicsScene.SceneLayers.enum_type f1, int f2)nothrow;+/
}
static if (!defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QIncompatibleFlag operator |(QGraphicsScene.SceneLayers.enum_type f1, int f2)nothrow{return QIncompatibleFlag(int(f1)|f2);}+/
}

/+ Q_DECLARE_OPERATORS_FOR_FLAGS(QGraphicsScene::SceneLayers) +/
