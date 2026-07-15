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
module qt.printsupport.printpreviewwidget;
extern(C++):

import qt.config;
import qt.core.global;
import qt.core.namespace;
import qt.core.object;
import qt.gui.pagelayout;
import qt.helpers;
import qt.printsupport.printer;
import qt.widgets.widget;

/+ QT_REQUIRE_CONFIG(printpreviewwidget); +/

extern(C++, class) struct QPrintPreviewWidgetPrivate;

/// Binding for C++ class [QPrintPreviewWidget](https://doc.qt.io/qt-6/qprintpreviewwidget.html).
class /+ Q_PRINTSUPPORT_EXPORT +/ QPrintPreviewWidget : QWidget
{
    mixin(Q_OBJECT);

public:

    enum ViewMode {
        SinglePageView,
        FacingPagesView,
        AllPagesView
    }

    enum ZoomMode {
        CustomZoom,
        FitToWidth,
        FitInView
    }

    /+ explicit +/this(QPrinter printer, QWidget parent = null,
                             /+ Qt:: +/qt.core.namespace.WindowFlags flags = /+ Qt:: +/qt.core.namespace.WindowFlags());
    /+ explicit +/this(QWidget parent = null, /+ Qt:: +/qt.core.namespace.WindowFlags flags = /+ Qt:: +/qt.core.namespace.WindowFlags());
    ~this();

    final qreal zoomFactor() const;
    final QPageLayout.Orientation orientation() const;
    final ViewMode viewMode() const;
    final ZoomMode zoomMode() const;
    final int currentPage() const;
    final int pageCount() const;
    override void setVisible(bool visible);

public /+ Q_SLOTS +/:
    @QSlot final void print();

    @QSlot final void zoomIn(qreal zoom = 1.1);
    @QSlot final void zoomOut(qreal zoom = 1.1);
    @QSlot final void setZoomFactor(qreal zoomFactor);
    @QSlot final void setOrientation(QPageLayout.Orientation orientation);
    @QSlot final void setViewMode(ViewMode viewMode);
    @QSlot final void setZoomMode(ZoomMode zoomMode);
    @QSlot final void setCurrentPage(int pageNumber);

    @QSlot final void fitToWidth();
    @QSlot final void fitInView();
    @QSlot final void setLandscapeOrientation();
    @QSlot final void setPortraitOrientation();
    @QSlot final void setSinglePageViewMode();
    @QSlot final void setFacingPagesViewMode();
    @QSlot final void setAllPagesViewMode();

    @QSlot final void updatePreview();

/+ Q_SIGNALS +/public:
    @QSignal final void paintRequested(QPrinter printer);
    @QSignal final void previewChanged();

    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
