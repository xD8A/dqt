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
module qt.widgets.graphicsitem;

import std.traits : Unqual;

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
import qt.core.scopedpointer;
import qt.core.size;
import qt.core.string;
import qt.core.variant;
import qt.gui.action;
import qt.gui.brush;
import qt.gui.color;
import qt.gui.event;
import qt.gui.font;
import qt.gui.painter;
import qt.gui.painterpath;
import qt.gui.pen;
import qt.gui.pixmap;
import qt.gui.polygon;
import qt.gui.region;
import qt.gui.textcursor;
import qt.gui.textdocument;
import qt.gui.transform;
import qt.helpers;
import qt.widgets.graphicseffect;
import qt.widgets.graphicsscene;
import qt.widgets.graphicssceneevent;
import qt.widgets.graphicstransform;
import qt.widgets.styleoption;
import qt.widgets.widget;
version (QT_NO_CURSOR) {} else
    import qt.gui.cursor;

extern(C++, class) struct tst_QGraphicsItem;

/+ QT_REQUIRE_CONFIG(graphicsview); +/



extern(C++, class) struct QGraphicsItemPrivate;

interface QGraphicsItemInterface
{
    // /+ virtual +/~this();
    /+ virtual +/ void advance(int phase);
    /+ virtual +/ QRectF boundingRect() const;
    /+ virtual +/ QPainterPath shape() const;
    /+ virtual +/ bool contains(ref const(QPointF) point) const;
    // mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    /+ virtual +/ bool collidesWithItem(const(QGraphicsItem) other, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape) const;
    // }));
    /+ virtual +/ bool collidesWithPath(ref const(QPainterPath) path, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape) const;
    // mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    /+ virtual +/ bool isObscuredBy(const(QGraphicsItem) item) const;
    // }));
    /+ virtual +/ QPainterPath opaqueArea() const;
    /+ virtual +/ void paint(QPainter* painter, const(QStyleOptionGraphicsItem)* option, QWidget widget = null);
    /+ virtual +/ int type() const;

//protected:
    /+ virtual +/ bool sceneEventFilter(QGraphicsItem watched, QEvent event);
    /+ virtual +/ bool sceneEvent(QEvent event);
    /+ virtual +/ void contextMenuEvent(QGraphicsSceneContextMenuEvent event);
    /+ virtual +/ void dragEnterEvent(QGraphicsSceneDragDropEvent event);
    /+ virtual +/ void dragLeaveEvent(QGraphicsSceneDragDropEvent event);
    /+ virtual +/ void dragMoveEvent(QGraphicsSceneDragDropEvent event);
    /+ virtual +/ void dropEvent(QGraphicsSceneDragDropEvent event);
    /+ virtual +/ void focusInEvent(QFocusEvent event);
    /+ virtual +/ void focusOutEvent(QFocusEvent event);
    /+ virtual +/ void hoverEnterEvent(QGraphicsSceneHoverEvent event);
    /+ virtual +/ void hoverMoveEvent(QGraphicsSceneHoverEvent event);
    /+ virtual +/ void hoverLeaveEvent(QGraphicsSceneHoverEvent event);
    /+ virtual +/ void keyPressEvent(QKeyEvent event);
    /+ virtual +/ void keyReleaseEvent(QKeyEvent event);
    /+ virtual +/ void mousePressEvent(QGraphicsSceneMouseEvent event);
    /+ virtual +/ void mouseMoveEvent(QGraphicsSceneMouseEvent event);
    /+ virtual +/ void mouseReleaseEvent(QGraphicsSceneMouseEvent event);
    /+ virtual +/ void mouseDoubleClickEvent(QGraphicsSceneMouseEvent event);
    /+ virtual +/ void wheelEvent(QGraphicsSceneWheelEvent event);
    /+ virtual +/ void inputMethodEvent(QInputMethodEvent event);
    /+ virtual +/ QVariant inputMethodQuery(/+ Qt:: +/qt.core.namespace.InputMethodQuery query) const;

    alias GraphicsItemChange = QGraphicsItem.GraphicsItemChange;
    /+ virtual +/ QVariant itemChange(GraphicsItemChange change, ref const(QVariant) value);

    alias Extension = QGraphicsItem.Extension;
    /+ virtual +/ bool supportsExtension(Extension extension) const;
    /+ virtual +/ void setExtension(Extension extension, ref const(QVariant) variant);
    /+ virtual +/ QVariant extension(ref const(QVariant) variant) const;
}

/// Binding for C++ class [QGraphicsItem](https://doc.qt.io/qt-6/qgraphicsitem.html).
abstract class /+ Q_WIDGETS_EXPORT +/ QGraphicsItem
{
public:
    enum GraphicsItemFlag {
        ItemIsMovable = 0x1,
        ItemIsSelectable = 0x2,
        ItemIsFocusable = 0x4,
        ItemClipsToShape = 0x8,
        ItemClipsChildrenToShape = 0x10,
        ItemIgnoresTransformations = 0x20,
        ItemIgnoresParentOpacity = 0x40,
        ItemDoesntPropagateOpacityToChildren = 0x80,
        ItemStacksBehindParent = 0x100,
        ItemUsesExtendedStyleOption = 0x200,
        ItemHasNoContents = 0x400,
        ItemSendsGeometryChanges = 0x800,
        ItemAcceptsInputMethod = 0x1000,
        ItemNegativeZStacksBehindParent = 0x2000,
        ItemIsPanel = 0x4000,
        ItemIsFocusScope = 0x8000, // internal
        ItemSendsScenePositionChanges = 0x10000,
        ItemStopsClickFocusPropagation = 0x20000,
        ItemStopsFocusHandling = 0x40000,
        ItemContainsChildrenInShape = 0x80000
        // NB! Don't forget to increase the d_ptr->flags bit field by 1 when adding a new flag.
    }
    /+ Q_DECLARE_FLAGS(GraphicsItemFlags, GraphicsItemFlag) +/
alias GraphicsItemFlags = QFlags!(GraphicsItemFlag);
    enum GraphicsItemChange {
        ItemPositionChange,
        ItemVisibleChange = 2,
        ItemEnabledChange,
        ItemSelectedChange,
        ItemParentChange,
        ItemChildAddedChange,
        ItemChildRemovedChange,
        ItemTransformChange,
        ItemPositionHasChanged,
        ItemTransformHasChanged,
        ItemSceneChange,
        ItemVisibleHasChanged,
        ItemEnabledHasChanged,
        ItemSelectedHasChanged,
        ItemParentHasChanged,
        ItemSceneHasChanged,
        ItemCursorChange,
        ItemCursorHasChanged,
        ItemToolTipChange,
        ItemToolTipHasChanged,
        ItemFlagsChange,
        ItemFlagsHaveChanged,
        ItemZValueChange,
        ItemZValueHasChanged,
        ItemOpacityChange,
        ItemOpacityHasChanged,
        ItemScenePositionHasChanged,
        ItemRotationChange,
        ItemRotationHasChanged,
        ItemScaleChange,
        ItemScaleHasChanged,
        ItemTransformOriginPointChange,
        ItemTransformOriginPointHasChanged
    }

    enum CacheMode {
        NoCache,
        ItemCoordinateCache,
        DeviceCoordinateCache
    }

    enum PanelModality
    {
        NonModal,
        PanelModal,
        SceneModal
    }

    mixin(changeItaniumMangling(q{mangleConstructorBaseObject}, q{
    /+ explicit +/this(QGraphicsItem parent = null);
    }));
    /+ virtual +/~this();

    final QGraphicsScene scene() const;

    final QGraphicsItem parentItem() const;
    final QGraphicsItem topLevelItem() const;
    final QGraphicsObject parentObject() const;
    final QGraphicsWidget* parentWidget() const;
    final QGraphicsWidget* topLevelWidget() const;
    final QGraphicsWidget* window() const;
    final QGraphicsItem panel() const;
    final void setParentItem(QGraphicsItem parent);
    final QList!(QGraphicsItem) childItems() const;
    final bool isWidget() const;
    final bool isWindow() const;
    final bool isPanel() const;

    final QGraphicsObject toGraphicsObject();
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final const(QGraphicsObject) toGraphicsObject() const;
    }));

    final QGraphicsItemGroup group() const;
    final void setGroup(QGraphicsItemGroup group);

    final GraphicsItemFlags flags() const;
    /+ void setFlag(GraphicsItemFlag flag, bool enabled = true); +/
    final void setFlags(GraphicsItemFlags flags);

    final CacheMode cacheMode() const;
    final void setCacheMode(CacheMode mode, ref const(QSize) cacheSize = globalInitVar!QSize);

    final PanelModality panelModality() const;
    final void setPanelModality(PanelModality panelModality);
    final bool isBlockedByModalPanel(QGraphicsItem* blockingPanel = null) const;

/+ #if QT_CONFIG(tooltip) +/
    final QString toolTip() const;
    final void setToolTip(ref const(QString) toolTip);
/+ #endif

#ifndef QT_NO_CURSOR +/
    version (QT_NO_CURSOR) {} else
    {
        final QCursor cursor() const;
        final void setCursor(ref const(QCursor) cursor);
        final bool hasCursor() const;
        final void unsetCursor();
    }
/+ #endif +/

    final bool isVisible() const;
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final bool isVisibleTo(const(QGraphicsItem) parent) const;
    }));
    final void setVisible(bool visible);
    pragma(inline, true) final void hide() { setVisible(false); }
    pragma(inline, true) final void show() { setVisible(true); }

    final bool isEnabled() const;
    final void setEnabled(bool enabled);

    final bool isSelected() const;
    final void setSelected(bool selected);

    final bool acceptDrops() const;
    final void setAcceptDrops(bool on);

    final qreal opacity() const;
    final qreal effectiveOpacity() const;
    final void setOpacity(qreal opacity);

/+ #if QT_CONFIG(graphicseffect) +/
    // Effect
    final QGraphicsEffect graphicsEffect() const;
    final void setGraphicsEffect(QGraphicsEffect effect);
/+ #endif +/ // QT_CONFIG(graphicseffect)

    final /+ Qt:: +/qt.core.namespace.MouseButtons acceptedMouseButtons() const;
    final void setAcceptedMouseButtons(/+ Qt:: +/qt.core.namespace.MouseButtons buttons);
    final bool acceptHoverEvents() const;
    final void setAcceptHoverEvents(bool enabled);
    final bool acceptTouchEvents() const;
    final void setAcceptTouchEvents(bool enabled);

    final bool filtersChildEvents() const;
    final void setFiltersChildEvents(bool enabled);

    final bool handlesChildEvents() const;
    final void setHandlesChildEvents(bool enabled);

    final bool isActive() const;
    final void setActive(bool active);

    final bool hasFocus() const;
    final void setFocus(/+ Qt:: +/qt.core.namespace.FocusReason focusReason = /+ Qt:: +/qt.core.namespace.FocusReason.OtherFocusReason);
    final void clearFocus();

    final QGraphicsItem focusProxy() const;
    final void setFocusProxy(QGraphicsItem item);

    final QGraphicsItem focusItem() const;
    final QGraphicsItem focusScopeItem() const;

    final void grabMouse();
    final void ungrabMouse();
    final void grabKeyboard();
    final void ungrabKeyboard();

    // Positioning in scene coordinates
    final QPointF pos() const;
    pragma(inline, true) final qreal x() const { return pos().x(); }
    final void setX(qreal x);
    pragma(inline, true) final qreal y() const { return pos().y(); }
    final void setY(qreal y);
    final QPointF scenePos() const;
    final void setPos(ref const(QPointF) pos);
    pragma(inline, true) final void setPos(qreal ax, qreal ay)
    { auto tmp = QPointF(ax, ay); setPos(tmp); }
    pragma(inline, true) final void moveBy(qreal dx, qreal dy) { setPos(pos().x() + dx, pos().y() + dy); }

    final void ensureVisible(ref const(QRectF) rect = globalInitVar!QRectF, int xmargin = 50, int ymargin = 50);
    pragma(inline, true) final void ensureVisible(qreal ax, qreal ay, qreal w, qreal h, int xmargin = 50, int ymargin = 50)
    { auto tmp = QRectF(ax, ay, w, h); ensureVisible(tmp, xmargin, ymargin); }

    // Local transformation
    final QTransform transform() const;
    final QTransform sceneTransform() const;
    final QTransform deviceTransform(ref const(QTransform) viewportTransform) const;
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final QTransform itemTransform(const(QGraphicsItem) other, bool* ok = null) const;
    }));
    final void setTransform(ref const(QTransform) matrix, bool combine = false);
    final void resetTransform();
    final void setRotation(qreal angle);
    final qreal rotation() const;

    final void setScale(qreal scale);
    final qreal scale() const;

    final QList!(QGraphicsTransform) transformations() const;
    final void setTransformations(ref const(QList!(QGraphicsTransform)) transformations);

    final QPointF transformOriginPoint() const;
    final void setTransformOriginPoint(ref const(QPointF) origin);
    pragma(inline, true) final void setTransformOriginPoint(qreal ax, qreal ay)
    { auto tmp = QPointF(ax,ay); setTransformOriginPoint(tmp); }

    /+ virtual +/ void advance(int phase);

    // Stacking order
    final qreal zValue() const;
    final void setZValue(qreal z);
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final void stackBefore(const(QGraphicsItem) sibling);
    }));

    // Hit test
    /+ virtual +/ abstract QRectF boundingRect() const;
    final QRectF childrenBoundingRect() const;
    final QRectF sceneBoundingRect() const;
    /+ virtual +/ QPainterPath shape() const;
    final bool isClipped() const;
    final QPainterPath clipPath() const;
    /+ virtual +/ bool contains(ref const(QPointF) point) const;
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    /+ virtual +/ bool collidesWithItem(const(QGraphicsItem) other, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape) const;
    }));
    /+ virtual +/ bool collidesWithPath(ref const(QPainterPath) path, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape) const;
    final QList!(QGraphicsItem) collidingItems(/+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape) const;
    final bool isObscured(ref const(QRectF) rect = globalInitVar!QRectF) const;
    pragma(inline, true) final bool isObscured(qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return isObscured(tmp); }
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    /+ virtual +/ bool isObscuredBy(const(QGraphicsItem) item) const;
    }));
    /+ virtual +/ QPainterPath opaqueArea() const;

    final QRegion boundingRegion(ref const(QTransform) itemToDeviceTransform) const;
    final qreal boundingRegionGranularity() const;
    final void setBoundingRegionGranularity(qreal granularity);

    // Drawing
    /+ virtual +/ abstract void paint(QPainter* painter, const(QStyleOptionGraphicsItem)* option, QWidget widget = null);
    final void update(ref const(QRectF) rect = globalInitVar!QRectF);
    pragma(inline, true) final void update(qreal ax, qreal ay, qreal width, qreal height)
    { auto tmp = QRectF(ax, ay, width, height); update(tmp); }
    final void scroll(qreal dx, qreal dy, ref const(QRectF) rect = globalInitVar!QRectF);

    // Coordinate mapping
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final QPointF mapToItem(const(QGraphicsItem) item, ref const(QPointF) point) const;
    }));
    final QPointF mapToParent(ref const(QPointF) point) const;
    final QPointF mapToScene(ref const(QPointF) point) const;
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final QPolygonF mapToItem(const(QGraphicsItem) item, ref const(QRectF) rect) const;
    }));
    final QPolygonF mapToParent(ref const(QRectF) rect) const;
    final QPolygonF mapToScene(ref const(QRectF) rect) const;
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final QRectF mapRectToItem(const(QGraphicsItem) item, ref const(QRectF) rect) const;
    }));
    final QRectF mapRectToParent(ref const(QRectF) rect) const;
    final QRectF mapRectToScene(ref const(QRectF) rect) const;
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final QPolygonF mapToItem(const(QGraphicsItem) item, ref const(QPolygonF) polygon) const;
    }));
    final QPolygonF mapToParent(ref const(QPolygonF) polygon) const;
    final QPolygonF mapToScene(ref const(QPolygonF) polygon) const;
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final QPainterPath mapToItem(const(QGraphicsItem) item, ref const(QPainterPath) path) const;
    }));
    final QPainterPath mapToParent(ref const(QPainterPath) path) const;
    final QPainterPath mapToScene(ref const(QPainterPath) path) const;
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final QPointF mapFromItem(const(QGraphicsItem) item, ref const(QPointF) point) const;
    }));
    final QPointF mapFromParent(ref const(QPointF) point) const;
    final QPointF mapFromScene(ref const(QPointF) point) const;
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final QPolygonF mapFromItem(const(QGraphicsItem) item, ref const(QRectF) rect) const;
    }));
    final QPolygonF mapFromParent(ref const(QRectF) rect) const;
    final QPolygonF mapFromScene(ref const(QRectF) rect) const;
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final QRectF mapRectFromItem(const(QGraphicsItem) item, ref const(QRectF) rect) const;
    }));
    final QRectF mapRectFromParent(ref const(QRectF) rect) const;
    final QRectF mapRectFromScene(ref const(QRectF) rect) const;
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final QPolygonF mapFromItem(const(QGraphicsItem) item, ref const(QPolygonF) polygon) const;
    }));
    final QPolygonF mapFromParent(ref const(QPolygonF) polygon) const;
    final QPolygonF mapFromScene(ref const(QPolygonF) polygon) const;
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final QPainterPath mapFromItem(const(QGraphicsItem) item, ref const(QPainterPath) path) const;
    }));
    final QPainterPath mapFromParent(ref const(QPainterPath) path) const;
    final QPainterPath mapFromScene(ref const(QPainterPath) path) const;

    pragma(inline, true) final QPointF mapToItem(const(QGraphicsItem) item, qreal ax, qreal ay) const
    { auto tmp = QPointF(ax, ay); return mapToItem(item, tmp); }
    pragma(inline, true) final QPointF mapToParent(qreal ax, qreal ay) const
    { auto tmp = QPointF(ax, ay); return mapToParent(tmp); }
    pragma(inline, true) final QPointF mapToScene(qreal ax, qreal ay) const
    { auto tmp = QPointF(ax, ay); return mapToScene(tmp);  }
    pragma(inline, true) final QPolygonF mapToItem(const(QGraphicsItem) item, qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return mapToItem(item, tmp); }
    pragma(inline, true) final QPolygonF mapToParent(qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return mapToParent(tmp); }
    pragma(inline, true) final QPolygonF mapToScene(qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return mapToScene(tmp); }
    pragma(inline, true) final QRectF mapRectToItem(const(QGraphicsItem) item, qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return mapRectToItem(item, tmp); }
    pragma(inline, true) final QRectF mapRectToParent(qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return mapRectToParent(tmp); }
    pragma(inline, true) final QRectF mapRectToScene(qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return mapRectToScene(tmp); }
    pragma(inline, true) final QPointF mapFromItem(const(QGraphicsItem) item, qreal ax, qreal ay) const
    { auto tmp = QPointF(ax, ay); return mapFromItem(item, tmp); }
    pragma(inline, true) final QPointF mapFromParent(qreal ax, qreal ay) const
    { auto tmp = QPointF(ax, ay); return mapFromParent(tmp);  }
    pragma(inline, true) final QPointF mapFromScene(qreal ax, qreal ay) const
    { auto tmp = QPointF(ax, ay); return mapFromScene(tmp);  }
    pragma(inline, true) final QPolygonF mapFromItem(const(QGraphicsItem) item, qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return mapFromItem(item, tmp); }
    pragma(inline, true) final QPolygonF mapFromParent(qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return mapFromParent(tmp); }
    pragma(inline, true) final QPolygonF mapFromScene(qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return mapFromScene(tmp); }
    pragma(inline, true) final QRectF mapRectFromItem(const(QGraphicsItem) item, qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return mapRectFromItem(item, tmp); }
    pragma(inline, true) final QRectF mapRectFromParent(qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return mapRectFromParent(tmp); }
    pragma(inline, true) final QRectF mapRectFromScene(qreal ax, qreal ay, qreal w, qreal h) const
    { auto tmp = QRectF(ax, ay, w, h); return mapRectFromScene(tmp); }

    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final bool isAncestorOf(const(QGraphicsItem) child) const;
    }));
    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    final QGraphicsItem commonAncestorItem(const(QGraphicsItem) other) const;
    }));
    final bool isUnderMouse() const;

    // Custom data
    final QVariant data(int key) const;
    final void setData(int key, ref const(QVariant) value);

    final /+ Qt:: +/qt.core.namespace.InputMethodHints inputMethodHints() const;
    final void setInputMethodHints(/+ Qt:: +/qt.core.namespace.InputMethodHints hints);

    enum {
        Type = 1,
        UserType = 65536
    }
    /+ virtual +/ int type() const;

    final void installSceneEventFilter(QGraphicsItem filterItem);
    final void removeSceneEventFilter(QGraphicsItem filterItem);

protected:
    final void updateMicroFocus();
    /+ virtual +/ bool sceneEventFilter(QGraphicsItem watched, QEvent event);
    /+ virtual +/ bool sceneEvent(QEvent event);
    /+ virtual +/ void contextMenuEvent(QGraphicsSceneContextMenuEvent event);
    /+ virtual +/ void dragEnterEvent(QGraphicsSceneDragDropEvent event);
    /+ virtual +/ void dragLeaveEvent(QGraphicsSceneDragDropEvent event);
    /+ virtual +/ void dragMoveEvent(QGraphicsSceneDragDropEvent event);
    /+ virtual +/ void dropEvent(QGraphicsSceneDragDropEvent event);
    /+ virtual +/ void focusInEvent(QFocusEvent event);
    /+ virtual +/ void focusOutEvent(QFocusEvent event);
    /+ virtual +/ void hoverEnterEvent(QGraphicsSceneHoverEvent event);
    /+ virtual +/ void hoverMoveEvent(QGraphicsSceneHoverEvent event);
    /+ virtual +/ void hoverLeaveEvent(QGraphicsSceneHoverEvent event);
    /+ virtual +/ void keyPressEvent(QKeyEvent event);
    /+ virtual +/ void keyReleaseEvent(QKeyEvent event);
    /+ virtual +/ void mousePressEvent(QGraphicsSceneMouseEvent event);
    /+ virtual +/ void mouseMoveEvent(QGraphicsSceneMouseEvent event);
    /+ virtual +/ void mouseReleaseEvent(QGraphicsSceneMouseEvent event);
    /+ virtual +/ void mouseDoubleClickEvent(QGraphicsSceneMouseEvent event);
    /+ virtual +/ void wheelEvent(QGraphicsSceneWheelEvent event);
    /+ virtual +/ void inputMethodEvent(QInputMethodEvent event);
    /+ virtual +/ QVariant inputMethodQuery(/+ Qt:: +/qt.core.namespace.InputMethodQuery query) const;

    /+ virtual +/ QVariant itemChange(GraphicsItemChange change, ref const(QVariant) value);

    enum Extension {
        UserExtension = 0x80000000
    }
    /+ virtual +/ bool supportsExtension(Extension extension) const;
    /+ virtual +/ void setExtension(Extension extension, ref const(QVariant) variant);
    /+ virtual +/ QVariant extension(ref const(QVariant) variant) const;

protected:
    mixin(changeItaniumMangling(q{mangleConstructorBaseObject}, q{
    this(ref QGraphicsItemPrivate dd, QGraphicsItem parent);
    }));
    QScopedPointer!(QGraphicsItemPrivate) d_ptr;

    final void addToIndex();
    final void removeFromIndex();
    final void prepareGeometryChange();

private:
    /+ Q_DISABLE_COPY(QGraphicsItem) +/
    /+ Q_DECLARE_PRIVATE(QGraphicsItem) +/
    /+ friend class QGraphicsItemGroup; +/
    /+ friend class QGraphicsScene; +/
    /+ friend class QGraphicsScenePrivate; +/
    /+ friend class QGraphicsSceneFindItemBspTreeVisitor; +/
    /+ friend class QGraphicsSceneBspTree; +/
    /+ friend class QGraphicsView; +/
    /+ friend class QGraphicsViewPrivate; +/
    /+ friend class QGraphicsObject; +/
    /+ friend class QGraphicsWidget; +/
    /+ friend class QGraphicsWidgetPrivate; +/
    /+ friend class QGraphicsProxyWidgetPrivate; +/
    /+ friend class QGraphicsSceneIndex; +/
    /+ friend class QGraphicsSceneIndexPrivate; +/
    /+ friend class QGraphicsSceneBspTreeIndex; +/
    /+ friend class QGraphicsSceneBspTreeIndexPrivate; +/
    /+ friend class QGraphicsItemEffectSourcePrivate; +/
    /+ friend class QGraphicsTransformPrivate; +/
    version (QT_NO_GESTURES) {} else
    {
        /+ friend class QGestureManager; +/
    }
    /+ friend class ::tst_QGraphicsItem; +/
    /+ friend bool qt_closestLeaf(const QGraphicsItem *, const QGraphicsItem *); +/
    /+ friend bool qt_closestItemFirst(const QGraphicsItem *, const QGraphicsItem *); +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
/+pragma(inline, true) QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type) operator |(QGraphicsItem.GraphicsItemFlags.enum_type f1, QGraphicsItem.GraphicsItemFlags.enum_type f2)nothrow{return QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type)(f1)|f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type) operator |(QGraphicsItem.GraphicsItemFlags.enum_type f1, QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type) f2)nothrow{return f2|f1;}+/
/+pragma(inline, true) QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type) operator &(QGraphicsItem.GraphicsItemFlags.enum_type f1, QGraphicsItem.GraphicsItemFlags.enum_type f2)nothrow{return QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type)(f1)&f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type) operator &(QGraphicsItem.GraphicsItemFlags.enum_type f1, QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type) f2)nothrow{return f2&f1;}+/
/+pragma(inline, true) QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type) operator ^(QGraphicsItem.GraphicsItemFlags.enum_type f1, QGraphicsItem.GraphicsItemFlags.enum_type f2)nothrow{return QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type)(f1)^f2;}+/
/+pragma(inline, true) QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type) operator ^(QGraphicsItem.GraphicsItemFlags.enum_type f1, QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type) f2)nothrow{return f2^f1;}+/
/+pragma(inline, true) void operator +(QGraphicsItem.GraphicsItemFlags.enum_type f1, QGraphicsItem.GraphicsItemFlags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QGraphicsItem.GraphicsItemFlags.enum_type f1, QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsItem.GraphicsItemFlags.enum_type f1, QGraphicsItem.GraphicsItemFlags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsItem.GraphicsItemFlags.enum_type f1, QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QFlags!(QGraphicsItem.GraphicsItemFlags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QGraphicsItem.GraphicsItemFlags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QGraphicsItem.GraphicsItemFlags.enum_type f1, int f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QGraphicsItem.GraphicsItemFlags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QGraphicsItem.GraphicsItemFlags.enum_type f1, int f2)nothrow;+/
static if (defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QGraphicsItem.GraphicsItemFlags operator ~(QGraphicsItem.GraphicsItemFlags.enum_type e)nothrow{return~QGraphicsItem.GraphicsItemFlags(e);}+/
/+pragma(inline, true) void operator |(QGraphicsItem.GraphicsItemFlags.enum_type f1, int f2)nothrow;+/
}
static if (!defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QIncompatibleFlag operator |(QGraphicsItem.GraphicsItemFlags.enum_type f1, int f2)nothrow{return QIncompatibleFlag(int(f1)|f2);}+/
}

/+ Q_DECLARE_OPERATORS_FOR_FLAGS(QGraphicsItem::GraphicsItemFlags)#ifndef Q_CLANG_QDOC
Q_DECLARE_INTERFACE(QGraphicsItem, "org.qt-project.Qt.QGraphicsItem")
#endif +/

static assert(__traits(classInstanceSize, QGraphicsItem) == (void*).sizeof * 2);
struct QGraphicsItemFakeInheritance
{
    static assert(__traits(classInstanceSize, QGraphicsItem) % (void*).sizeof == 0);
    void*[__traits(classInstanceSize, QGraphicsItem) / (void*).sizeof - 1] data;
}


/// Binding for C++ class [QGraphicsObject](https://doc.qt.io/qt-6/qgraphicsobject.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsObject : QObject, QGraphicsItemInterface
{
    QGraphicsItemFakeInheritance baseQGraphicsItemInterface;

    mixin(Q_OBJECT);
    /+ Q_PROPERTY(QGraphicsObject* parent READ parentObject WRITE setParentItem NOTIFY parentChanged
               DESIGNABLE false)
    Q_PROPERTY(qreal opacity READ opacity WRITE setOpacity NOTIFY opacityChanged FINAL)
    Q_PROPERTY(bool enabled READ isEnabled WRITE setEnabled NOTIFY enabledChanged)
    Q_PROPERTY(bool visible READ isVisible WRITE setVisible NOTIFY visibleChanged FINAL)
    Q_PROPERTY(QPointF pos READ pos WRITE setPos FINAL)
    Q_PROPERTY(qreal x READ x WRITE setX NOTIFY xChanged FINAL)
    Q_PROPERTY(qreal y READ y WRITE setY NOTIFY yChanged FINAL)
    Q_PROPERTY(qreal z READ zValue WRITE setZValue NOTIFY zChanged FINAL)
    Q_PROPERTY(qreal rotation READ rotation WRITE setRotation NOTIFY rotationChanged)
    Q_PROPERTY(qreal scale READ scale WRITE setScale NOTIFY scaleChanged)
    Q_PROPERTY(QPointF transformOriginPoint READ transformOriginPoint WRITE setTransformOriginPoint)
#if QT_CONFIG(graphicseffect)
    Q_PROPERTY(QGraphicsEffect *effect READ graphicsEffect WRITE setGraphicsEffect)
#endif
    Q_PRIVATE_PROPERTY(QGraphicsItem::d_func(), QDeclarativeListProperty<QGraphicsObject> children
                       READ childrenList DESIGNABLE false NOTIFY childrenChanged)
    Q_PRIVATE_PROPERTY(QGraphicsItem::d_func(), qreal width READ width WRITE setWidth
                       NOTIFY widthChanged RESET resetWidth FINAL)
    Q_PRIVATE_PROPERTY(QGraphicsItem::d_func(), qreal height READ height WRITE setHeight
                       NOTIFY heightChanged RESET resetHeight FINAL)
    Q_CLASSINFO("DefaultProperty", "children")
    Q_INTERFACES(QGraphicsItem) +/
public:
    /+ explicit +/this(QGraphicsItem parent = null);
    ~this();

    alias children = QObject.children;

    pragma(inline, true) final QGraphicsItem asGraphicsItem() 
    {
        return cast(QGraphicsItem)(cast(void*)(cast(byte*)&baseQGraphicsItemInterface - (void*).sizeof));
    }

    pragma(inline, true) final const(QGraphicsItem) asConstGraphicsItem() const
    {
        return cast(const(QGraphicsItem))(cast(void*)(cast(byte*)&baseQGraphicsItemInterface - (void*).sizeof));
    }

    override void advance(int phase)
    {
        // The default implementation does nothing.
        // https://github.com/qt/qtbase/blob/e3e40c44d3f998a433a6a1080297c5f28e9a768f/src/widgets/graphicsview/qgraphicsitem.cpp#L4537
    }
    override QRectF boundingRect() const
    {
        assert(0);
    }
    override QPainterPath shape() const
    {
        assert(0);
    }
    override bool contains(ref const(QPointF) point) const
    {
        assert(0);
    }
    override bool collidesWithItem(const(QGraphicsItem) other, qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape) const
    {
        assert(0);
    }
    override bool collidesWithPath(ref const(QPainterPath) path, /+ Qt:: +/qt.core.namespace.ItemSelectionMode mode = /+ Qt:: +/qt.core.namespace.ItemSelectionMode.IntersectsItemShape) const
    {
        assert(0);
    }
    override bool isObscuredBy(const(QGraphicsItem) item) const
    {
        assert(0);
    }
    override QPainterPath opaqueArea() const
    {
        assert(0);
    }
    override void paint(QPainter* painter, const(QStyleOptionGraphicsItem)* option, QWidget widget = null)
    {
        assert(0);
    }
    override int type() const
    {
        assert(0);
    }

    final void setPos(ref const(QPointF) pos)
    {
        asGraphicsItem().setPos(pos);
    }

    alias GraphicsItemFlags = QGraphicsItem.GraphicsItemFlags;
    final void setFlags(GraphicsItemFlags flags)
    {
        asGraphicsItem().setFlags(flags);
    }

    version (QT_NO_GESTURES) {} else
    {
        final void grabGesture(/+ Qt:: +/qt.core.namespace.GestureType type, /+ Qt:: +/qt.core.namespace.GestureFlags flags = /+ Qt:: +/qt.core.namespace.GestureFlags());
        final void ungrabGesture(/+ Qt:: +/qt.core.namespace.GestureType type);
    }

protected /+ Q_SLOTS +/:
    @QSlot final void updateMicroFocus();

/+ Q_SIGNALS +/public:
    @QSignal final void parentChanged();
    @QSignal final void opacityChanged();
    @QSignal final void visibleChanged();
    @QSignal final void enabledChanged();
    @QSignal final void xChanged();
    @QSignal final void yChanged();
    @QSignal final void zChanged();
    @QSignal final void rotationChanged();
    @QSignal final void scaleChanged();
    @QSignal final void childrenChanged();
    @QSignal final void widthChanged();
    @QSignal final void heightChanged();

protected:
    this(ref QGraphicsItemPrivate dd, QGraphicsItem parent);

    override bool event(QEvent ev);

    override bool sceneEventFilter(QGraphicsItem watched, QEvent event)
    {
        // https://github.com/qt/qtbase/blob/e3e40c44d3f998a433a6a1080297c5f28e9a768f/src/widgets/graphicsview/qgraphicsitem.cpp#L6607
        return false;
    }
    override bool sceneEvent(QEvent event)
    {
        assert(0);
    }
    override void contextMenuEvent(QGraphicsSceneContextMenuEvent event)
    {
        assert(0);
    }
    override void dragEnterEvent(QGraphicsSceneDragDropEvent event)
    {
        assert(0);
    }
    override void dragLeaveEvent(QGraphicsSceneDragDropEvent event)
    {
        assert(0);
    }
    override void dragMoveEvent(QGraphicsSceneDragDropEvent event)
    {
        assert(0);
    }
    override void dropEvent(QGraphicsSceneDragDropEvent event)
    {
        assert(0);
    }
    override void focusInEvent(QFocusEvent event)
    {
        assert(0);
    }
    override void focusOutEvent(QFocusEvent event)
    {
        assert(0);
    }
    override void hoverEnterEvent(QGraphicsSceneHoverEvent event)
    {
        assert(0);
    }
    override void hoverMoveEvent(QGraphicsSceneHoverEvent event)
    {
        assert(0);
    }
    override void hoverLeaveEvent(QGraphicsSceneHoverEvent event)
    {
        assert(0);
    }
    override void keyPressEvent(QKeyEvent event)
    {
        assert(0);
    }
    override void keyReleaseEvent(QKeyEvent event)
    {
        assert(0);
    }
    override void mousePressEvent(QGraphicsSceneMouseEvent event)
    {
        assert(0);
    }
    override void mouseMoveEvent(QGraphicsSceneMouseEvent event)
    {
        assert(0);
    }
    override void mouseReleaseEvent(QGraphicsSceneMouseEvent event)
    {
        assert(0);
    }
    override void mouseDoubleClickEvent(QGraphicsSceneMouseEvent event)
    {
        assert(0);
    }
    override void wheelEvent(QGraphicsSceneWheelEvent event)
    {
        assert(0);
    }
    override void inputMethodEvent(QInputMethodEvent event)
    {
        assert(0);
    }
    override QVariant inputMethodQuery(/+ Qt:: +/qt.core.namespace.InputMethodQuery query) const
    {
        assert(0);
    }

    // alias GraphicsItemChange = QGraphicsItem.GraphicsItemChange;
    override QVariant itemChange(GraphicsItemChange change, ref const(QVariant) value)
    {
        // https://github.com/qt/qtbase/blob/e3e40c44d3f998a433a6a1080297c5f28e9a768f/src/widgets/graphicsview/qgraphicsitem.cpp#L7367
        return value;
    }

    // alias Extension = QGraphicsItem.Extension;
    override bool supportsExtension(Extension extension) const
    {
        // https://github.com/qt/qtbase/blob/e3e40c44d3f998a433a6a1080297c5f28e9a768f/src/widgets/graphicsview/qgraphicsitem.cpp#L7379
        return false;
    }
    override void setExtension(Extension extension, ref const(QVariant) variant)
    {
        // https://github.com/qt/qtbase/blob/e3e40c44d3f998a433a6a1080297c5f28e9a768f/src/widgets/graphicsview/qgraphicsitem.cpp#L7390
    }
    override QVariant extension(ref const(QVariant) variant) const
    {
        // https://github.com/qt/qtbase/blob/e3e40c44d3f998a433a6a1080297c5f28e9a768f/src/widgets/graphicsview/qgraphicsitem.cpp#L7403
        return QVariant();
    }

private:
    /+ friend class QGraphicsItem; +/
    /+ friend class QGraphicsItemPrivate; +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}


extern(C++, class) struct QAbstractGraphicsShapeItemPrivate;
/// Binding for C++ class [QAbstractGraphicsShapeItem](https://doc.qt.io/qt-6/qabstractgraphicsshapeitem.html).
class /+ Q_WIDGETS_EXPORT +/ QAbstractGraphicsShapeItem : QGraphicsItem
{
public:
    /+ explicit +/this(QGraphicsItem parent = null);
    ~this();

    final QPen pen() const;
    final void setPen(ref const(QPen) pen);

    final QBrush brush() const;
    final void setBrush(ref const(QBrush) brush);

    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    override bool isObscuredBy(const(QGraphicsItem) item) const;
    }));
    override QPainterPath opaqueArea() const;

protected:
    this(ref QAbstractGraphicsShapeItemPrivate dd,
                                   QGraphicsItem parent);

private:
    /+ Q_DISABLE_COPY(QAbstractGraphicsShapeItem) +/
    /+ Q_DECLARE_PRIVATE(QAbstractGraphicsShapeItem) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsPathItemPrivate;
/// Binding for C++ class [QGraphicsPathItem](https://doc.qt.io/qt-6/qgraphicspathitem.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsPathItem : QAbstractGraphicsShapeItem
{
public:
    /+ explicit +/this(QGraphicsItem parent = null);
    /+ explicit +/this(ref const(QPainterPath) path, QGraphicsItem parent = null);
    ~this();

    final QPainterPath path() const;
    final void setPath(ref const(QPainterPath) path);

    override QRectF boundingRect() const;
    override QPainterPath shape() const;
    override bool contains(ref const(QPointF) point) const;

    override void paint(QPainter* painter, const(QStyleOptionGraphicsItem)* option, QWidget widget = null);

    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    override bool isObscuredBy(const(QGraphicsItem) item) const;
    }));
    override QPainterPath opaqueArea() const;

    enum { Type = 2 }
    override int type() const;

protected:
    override bool supportsExtension(Extension extension) const;
    override void setExtension(Extension extension, ref const(QVariant) variant);
    override QVariant extension(ref const(QVariant) variant) const;

private:
    /+ Q_DISABLE_COPY(QGraphicsPathItem) +/
    /+ Q_DECLARE_PRIVATE(QGraphicsPathItem) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsRectItemPrivate;
/// Binding for C++ class [QGraphicsRectItem](https://doc.qt.io/qt-6/qgraphicsrectitem.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsRectItem : QAbstractGraphicsShapeItem
{
public:
    /+ explicit +/this(QGraphicsItem parent = null);
    /+ explicit +/this(ref const(QRectF) rect, QGraphicsItem parent = null);
    /+ explicit +/this(qreal x, qreal y, qreal w, qreal h, QGraphicsItem parent = null);
    ~this();

    final QRectF rect() const;
    final void setRect(ref const(QRectF) rect);
    pragma(inline, true) final void setRect(qreal ax, qreal ay, qreal w, qreal h)
    { auto tmp = QRectF(ax, ay, w, h); setRect(tmp); }

    override QRectF boundingRect() const;
    override QPainterPath shape() const;
    override bool contains(ref const(QPointF) point) const;

    override void paint(QPainter* painter, const(QStyleOptionGraphicsItem)* option, QWidget widget = null);

    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    override bool isObscuredBy(const(QGraphicsItem) item) const;
    }));
    override QPainterPath opaqueArea() const;

    enum { Type = 3 }
    override int type() const;

protected:
    override bool supportsExtension(Extension extension) const;
    override void setExtension(Extension extension, ref const(QVariant) variant);
    override QVariant extension(ref const(QVariant) variant) const;

private:
    /+ Q_DISABLE_COPY(QGraphicsRectItem) +/
    /+ Q_DECLARE_PRIVATE(QGraphicsRectItem) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsEllipseItemPrivate;
/// Binding for C++ class [QGraphicsEllipseItem](https://doc.qt.io/qt-6/qgraphicsellipseitem.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsEllipseItem : QAbstractGraphicsShapeItem
{
public:
    /+ explicit +/this(QGraphicsItem parent = null);
    /+ explicit +/this(ref const(QRectF) rect, QGraphicsItem parent = null);
    /+ explicit +/this(qreal x, qreal y, qreal w, qreal h, QGraphicsItem parent = null);
    ~this();

    final QRectF rect() const;
    final void setRect(ref const(QRectF) rect);
    pragma(inline, true) final void setRect(qreal ax, qreal ay, qreal w, qreal h)
    { auto tmp = QRectF(ax, ay, w, h); setRect(tmp); }

    final int startAngle() const;
    final void setStartAngle(int angle);

    final int spanAngle() const;
    final void setSpanAngle(int angle);

    override QRectF boundingRect() const;
    override QPainterPath shape() const;
    override bool contains(ref const(QPointF) point) const;

    override void paint(QPainter* painter, const(QStyleOptionGraphicsItem)* option, QWidget widget = null);

    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    override bool isObscuredBy(const(QGraphicsItem) item) const;
    }));
    override QPainterPath opaqueArea() const;

    enum { Type = 4 }
    override int type() const;

protected:
    override bool supportsExtension(Extension extension) const;
    override void setExtension(Extension extension, ref const(QVariant) variant);
    override QVariant extension(ref const(QVariant) variant) const;

private:
    /+ Q_DISABLE_COPY(QGraphicsEllipseItem) +/
    /+ Q_DECLARE_PRIVATE(QGraphicsEllipseItem) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsPolygonItemPrivate;
/// Binding for C++ class [QGraphicsPolygonItem](https://doc.qt.io/qt-6/qgraphicspolygonitem.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsPolygonItem : QAbstractGraphicsShapeItem
{
public:
    /+ explicit +/this(QGraphicsItem parent = null);
    /+ explicit +/this(ref const(QPolygonF) polygon,
                                      QGraphicsItem parent = null);
    ~this();

    final QPolygonF polygon() const;
    final void setPolygon(ref const(QPolygonF) polygon);

    final /+ Qt:: +/qt.core.namespace.FillRule fillRule() const;
    final void setFillRule(/+ Qt:: +/qt.core.namespace.FillRule rule);

    override QRectF boundingRect() const;
    override QPainterPath shape() const;
    override bool contains(ref const(QPointF) point) const;

    override void paint(QPainter* painter, const(QStyleOptionGraphicsItem)* option, QWidget widget = null);

    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    override bool isObscuredBy(const(QGraphicsItem) item) const;
    }));
    override QPainterPath opaqueArea() const;

    enum { Type = 5 }
    override int type() const;

protected:
    override bool supportsExtension(Extension extension) const;
    override void setExtension(Extension extension, ref const(QVariant) variant);
    override QVariant extension(ref const(QVariant) variant) const;

private:
    /+ Q_DISABLE_COPY(QGraphicsPolygonItem) +/
    /+ Q_DECLARE_PRIVATE(QGraphicsPolygonItem) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsLineItemPrivate;
/// Binding for C++ class [QGraphicsLineItem](https://doc.qt.io/qt-6/qgraphicslineitem.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsLineItem : QGraphicsItem
{
public:
    /+ explicit +/this(QGraphicsItem parent = null);
    /+ explicit +/this(ref const(QLineF) line, QGraphicsItem parent = null);
    /+ explicit +/this(qreal x1, qreal y1, qreal x2, qreal y2, QGraphicsItem parent = null);
    ~this();

    final QPen pen() const;
    final void setPen(ref const(QPen) pen);

    final QLineF line() const;
    final void setLine(ref const(QLineF) line);
    pragma(inline, true) final void setLine(qreal x1, qreal y1, qreal x2, qreal y2)
    { auto tmp = QLineF(x1, y1, x2, y2); setLine(tmp); }

    override QRectF boundingRect() const;
    override QPainterPath shape() const;
    override bool contains(ref const(QPointF) point) const;

    override void paint(QPainter* painter, const(QStyleOptionGraphicsItem)* option, QWidget widget = null);

    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    override bool isObscuredBy(const(QGraphicsItem) item) const;
    }));
    override QPainterPath opaqueArea() const;

    enum { Type = 6 }
    override int type() const;

protected:
    override bool supportsExtension(Extension extension) const;
    override void setExtension(Extension extension, ref const(QVariant) variant);
    override QVariant extension(ref const(QVariant) variant) const;

private:
    /+ Q_DISABLE_COPY(QGraphicsLineItem) +/
    /+ Q_DECLARE_PRIVATE(QGraphicsLineItem) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsPixmapItemPrivate;
/// Binding for C++ class [QGraphicsPixmapItem](https://doc.qt.io/qt-6/qgraphicspixmapitem.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsPixmapItem : QGraphicsItem
{
public:
    enum ShapeMode {
        MaskShape,
        BoundingRectShape,
        HeuristicMaskShape
    }

    /+ explicit +/this(QGraphicsItem parent = null);
    /+ explicit +/this(ref const(QPixmap) pixmap, QGraphicsItem parent = null);
    ~this();

    final QPixmap pixmap() const;
    final void setPixmap(ref const(QPixmap) pixmap);

    final /+ Qt:: +/qt.core.namespace.TransformationMode transformationMode() const;
    final void setTransformationMode(/+ Qt:: +/qt.core.namespace.TransformationMode mode);

    final QPointF offset() const;
    final void setOffset(ref const(QPointF) offset);
    pragma(inline, true) final void setOffset(qreal ax, qreal ay)
    { auto tmp = QPointF(ax, ay); setOffset(tmp); }

    override QRectF boundingRect() const;
    override QPainterPath shape() const;
    override bool contains(ref const(QPointF) point) const;

    override void paint(QPainter* painter, const(QStyleOptionGraphicsItem)* option, QWidget widget);

    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    override bool isObscuredBy(const(QGraphicsItem) item) const;
    }));
    override QPainterPath opaqueArea() const;

    enum { Type = 7 }
    override int type() const;

    final ShapeMode shapeMode() const;
    final void setShapeMode(ShapeMode mode);

protected:
    override bool supportsExtension(Extension extension) const;
    override void setExtension(Extension extension, ref const(QVariant) variant);
    override QVariant extension(ref const(QVariant) variant) const;

private:
    /+ Q_DISABLE_COPY(QGraphicsPixmapItem) +/
    /+ Q_DECLARE_PRIVATE(QGraphicsPixmapItem) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsTextItemPrivate;
/// Binding for C++ class [QGraphicsTextItem](https://doc.qt.io/qt-6/qgraphicstextitem.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsTextItem : QGraphicsObject
{
    mixin(Q_OBJECT);
    /+ QDOC_PROPERTY(bool openExternalLinks READ openExternalLinks WRITE setOpenExternalLinks)
    QDOC_PROPERTY(QTextCursor textCursor READ textCursor WRITE setTextCursor) +/

public:
    /+ explicit +/this(QGraphicsItem parent = null);
    /+ explicit +/this(ref const(QString) text, QGraphicsItem parent = null);
    ~this();

    final QString toHtml() const;
    final void setHtml(ref const(QString) html);

    final QString toPlainText() const;
    final void setPlainText(ref const(QString) text);

    final QFont font() const;
    final void setFont(ref const(QFont) font);

    final void setDefaultTextColor(ref const(QColor) c);
    final QColor defaultTextColor() const;

    override QRectF boundingRect() const;
    override QPainterPath shape() const;
    override bool contains(ref const(QPointF) point) const;

    override void paint(QPainter* painter, const(QStyleOptionGraphicsItem)* option, QWidget widget);

    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    override bool isObscuredBy(const(QGraphicsItem) item) const;
    }));
    override QPainterPath opaqueArea() const;

    enum { Type = 8 }
    override int type() const;

    final void setTextWidth(qreal width);
    final qreal textWidth() const;

    final void adjustSize();

    final void setDocument(QTextDocument document);
    final QTextDocument document() const;

    final void setTextInteractionFlags(/+ Qt:: +/qt.core.namespace.TextInteractionFlags flags);
    final /+ Qt:: +/qt.core.namespace.TextInteractionFlags textInteractionFlags() const;

    final void setTabChangesFocus(bool b);
    final bool tabChangesFocus() const;

    final void setOpenExternalLinks(bool open);
    final bool openExternalLinks() const;

    final void setTextCursor(ref const(QTextCursor) cursor);
    final QTextCursor textCursor() const;

/+ Q_SIGNALS +/public:
    @QSignal final void linkActivated(ref const(QString) );
    @QSignal final void linkHovered(ref const(QString) );

protected:
    override bool sceneEvent(QEvent event);
    override void mousePressEvent(QGraphicsSceneMouseEvent event);
    override void mouseMoveEvent(QGraphicsSceneMouseEvent event);
    override void mouseReleaseEvent(QGraphicsSceneMouseEvent event);
    override void mouseDoubleClickEvent(QGraphicsSceneMouseEvent event);
    override void contextMenuEvent(QGraphicsSceneContextMenuEvent event);
    override void keyPressEvent(QKeyEvent event);
    override void keyReleaseEvent(QKeyEvent event);
    override void focusInEvent(QFocusEvent event);
    override void focusOutEvent(QFocusEvent event);
    override void dragEnterEvent(QGraphicsSceneDragDropEvent event);
    override void dragLeaveEvent(QGraphicsSceneDragDropEvent event);
    override void dragMoveEvent(QGraphicsSceneDragDropEvent event);
    override void dropEvent(QGraphicsSceneDragDropEvent event);
    override void inputMethodEvent(QInputMethodEvent event);
    override void hoverEnterEvent(QGraphicsSceneHoverEvent event);
    override void hoverMoveEvent(QGraphicsSceneHoverEvent event);
    override void hoverLeaveEvent(QGraphicsSceneHoverEvent event);

    override QVariant inputMethodQuery(/+ Qt:: +/qt.core.namespace.InputMethodQuery query) const;

    override bool supportsExtension(Extension extension) const;
    override void setExtension(Extension extension, ref const(QVariant) variant);
    override QVariant extension(ref const(QVariant) variant) const;

private:
    /+ Q_DISABLE_COPY(QGraphicsTextItem) +/
    QGraphicsTextItemPrivate* dd;
    /+ friend class QGraphicsTextItemPrivate; +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsSimpleTextItemPrivate;
/// Binding for C++ class [QGraphicsSimpleTextItem](https://doc.qt.io/qt-6/qgraphicssimpletextitem.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsSimpleTextItem : QAbstractGraphicsShapeItem
{
public:
    /+ explicit +/this(QGraphicsItem parent = null);
    /+ explicit +/this(ref const(QString) text, QGraphicsItem parent = null);
    ~this();

    final void setText(ref const(QString) text);
    final QString text() const;

    final void setFont(ref const(QFont) font);
    final QFont font() const;

    override QRectF boundingRect() const;
    override QPainterPath shape() const;
    override bool contains(ref const(QPointF) point) const;

    override void paint(QPainter* painter, const(QStyleOptionGraphicsItem)* option, QWidget widget);

    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    override bool isObscuredBy(const(QGraphicsItem) item) const;
    }));
    override QPainterPath opaqueArea() const;

    enum { Type = 9 }
    override int type() const;

protected:
    override bool supportsExtension(Extension extension) const;
    override void setExtension(Extension extension, ref const(QVariant) variant);
    override QVariant extension(ref const(QVariant) variant) const;

private:
    /+ Q_DISABLE_COPY(QGraphicsSimpleTextItem) +/
    /+ Q_DECLARE_PRIVATE(QGraphicsSimpleTextItem) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, class) struct QGraphicsItemGroupPrivate;
/// Binding for C++ class [QGraphicsItemGroup](https://doc.qt.io/qt-6/qgraphicsitemgroup.html).
class /+ Q_WIDGETS_EXPORT +/ QGraphicsItemGroup : QGraphicsItem
{
public:
    /+ explicit +/this(QGraphicsItem parent = null);
    ~this();

    final void addToGroup(QGraphicsItem item);
    final void removeFromGroup(QGraphicsItem item);

    override QRectF boundingRect() const;
    override void paint(QPainter* painter, const(QStyleOptionGraphicsItem)* option, QWidget widget = null);

    mixin(changeWindowsMangling(q{mangleClassesTailConst}, q{
    override bool isObscuredBy(const(QGraphicsItem) item) const;
    }));
    override QPainterPath opaqueArea() const;

    enum { Type = 10 }
    override int type() const;

private:
    /+ Q_DISABLE_COPY(QGraphicsItemGroup) +/
    /+ Q_DECLARE_PRIVATE(QGraphicsItemGroup) +/
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

pragma(inline, true) T qgraphicsitem_cast(T)(QGraphicsItem item)
{
    alias Item = Unqual!T;
    return int(Item.Type) == int(QGraphicsItem.Type)
        || (item && int(Item.Type) == item.type()) ? static_cast!(T)(item) : null;
}

pragma(inline, true) T qgraphicsitem_cast(T)(const(QGraphicsItem) item)
{
    alias Item = Unqual!T;
    return int(Item.Type) == int(QGraphicsItem.Type)
        || (item && int(Item.Type) == item.type()) ? static_cast!(T)(item) : null;
}

/+ #ifndef QT_NO_DEBUG_STREAM
Q_WIDGETS_EXPORT QDebug operator<<(QDebug debug, const QGraphicsItem *item);
Q_WIDGETS_EXPORT QDebug operator<<(QDebug debug, const QGraphicsObject *item);
Q_WIDGETS_EXPORT QDebug operator<<(QDebug debug, QGraphicsItem::GraphicsItemChange change);
Q_WIDGETS_EXPORT QDebug operator<<(QDebug debug, QGraphicsItem::GraphicsItemFlag flag);
Q_WIDGETS_EXPORT QDebug operator<<(QDebug debug, QGraphicsItem::GraphicsItemFlags flags);
#endif


QT_DECL_METATYPE_EXTERN_TAGGED(QGraphicsItem*, QGraphicsItem_ptr, Q_WIDGETS_EXPORT) +/
