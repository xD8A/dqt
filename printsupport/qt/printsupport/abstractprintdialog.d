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
module qt.printsupport.abstractprintdialog;
extern(C++):

import qt.config;
import qt.core.flags;
import qt.core.list;
import qt.core.namespace;
import qt.core.object;
import qt.helpers;
import qt.printsupport.printer;
import qt.widgets.dialog;
import qt.widgets.widget;

/+ QT_REQUIRE_CONFIG(printdialog); +/

extern(C++, class) struct QAbstractPrintDialogPrivate;

/// Binding for C++ class [QAbstractPrintDialog](https://doc.qt.io/qt-6/qabstractprintdialog.html).
class /+ Q_PRINTSUPPORT_EXPORT +/ QAbstractPrintDialog : QDialog
{
    mixin(Q_OBJECT);

public:
    enum PrintRange {
        AllPages,
        Selection,
        PageRange,
        CurrentPage
    }

    enum PrintDialogOption {
        PrintToFile             = 0x0001,
        PrintSelection          = 0x0002,
        PrintPageRange          = 0x0004,
        PrintShowPageSize       = 0x0008,
        PrintCollateCopies      = 0x0010,
        PrintCurrentPage        = 0x0040
    }
    /+ Q_ENUM(PrintDialogOption) +/

    alias PrintDialogOptions = QFlags!(PrintDialogOption);

    /+ explicit +/this(QPrinter printer, QWidget parent = null);
    ~this();

    final void setOptionTabs(ref const(QList!(QWidget)) tabs);

    final void setPrintRange(PrintRange range);
    final PrintRange printRange() const;

    final void setMinMax(int min, int max);
    final int minPage() const;
    final int maxPage() const;

    final void setFromTo(int fromPage, int toPage);
    final int fromPage() const;
    final int toPage() const;

    final QPrinter printer() const;

protected:
    this(ref QAbstractPrintDialogPrivate ptr, QPrinter printer, QWidget parent = null);

    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
