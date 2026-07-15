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
module qt.printsupport.printpreviewdialog;
extern(C++):

import qt.config;
import qt.core.namespace;
import qt.core.object;
import qt.helpers;
import qt.printsupport.printer;
import qt.widgets.dialog;
import qt.widgets.widget;

/+ QT_REQUIRE_CONFIG(printpreviewdialog); +/

extern(C++, class) struct QPrintPreviewDialogPrivate;

/// Binding for C++ class [QPrintPreviewDialog](https://doc.qt.io/qt-6/qprintpreviewdialog.html).
class /+ Q_PRINTSUPPORT_EXPORT +/ QPrintPreviewDialog : QDialog
{
    mixin(Q_OBJECT);

public:
    /+ explicit +/this(QWidget parent = null, /+ Qt:: +/qt.core.namespace.WindowFlags flags = /+ Qt:: +/qt.core.namespace.WindowFlags());
    /+ explicit +/this(QPrinter printer, QWidget parent = null,
                             /+ Qt:: +/qt.core.namespace.WindowFlags flags = /+ Qt:: +/qt.core.namespace.WindowFlags());
    ~this();

    final void open(QObject receiver, const(char)* member);

    final QPrinter printer();

    override void setVisible(bool visible);
    override void done(int result);

/+ Q_SIGNALS +/public:
    @QSignal final void paintRequested(QPrinter printer);

    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
