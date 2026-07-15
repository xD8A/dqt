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
module qt.printsupport.printdialog;
extern(C++):

import qt.config;
import qt.core.namespace;
import qt.core.object;
import qt.helpers;
import qt.printsupport.abstractprintdialog;
import qt.printsupport.printer;
import qt.widgets.widget;

/+ QT_REQUIRE_CONFIG(printdialog); +/

extern(C++, class) struct QPrintDialogPrivate;

/// Binding for C++ class [QPrintDialog](https://doc.qt.io/qt-6/qprintdialog.html).
class /+ Q_PRINTSUPPORT_EXPORT +/ QPrintDialog : QAbstractPrintDialog
{
    mixin(Q_OBJECT);

public:
    /+ explicit +/this(QPrinter printer, QWidget parent = null);
    /+ explicit +/this(QWidget parent = null);
    ~this();

    override int exec();
    version (linux)
    {
        override void accept();
    }
    override void done(int result);

    final void setOption(QAbstractPrintDialog.PrintDialogOption option, bool on = true);
    final bool testOption(QAbstractPrintDialog.PrintDialogOption option) const;
    final void setOptions(QAbstractPrintDialog.PrintDialogOptions options);
    final QAbstractPrintDialog.PrintDialogOptions options() const;

    version (Posix)
    {
        override void setVisible(bool visible);
    }
    else version (Windows)
    {
        override void setVisible(bool visible);
    }

    final void open(QObject receiver, const(char)* member);

    /+ using QDialog::accepted; +/

/+ Q_SIGNALS +/public:
    @QSignal final void accepted(QPrinter printer);

    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
