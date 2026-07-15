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
module qt.printsupport.pagesetupdialog;
extern(C++):

import qt.config;
import qt.core.namespace;
import qt.core.object;
import qt.helpers;
import qt.printsupport.printer;
import qt.widgets.dialog;
import qt.widgets.widget;

/+ QT_REQUIRE_CONFIG(printdialog); +/

extern(C++, class) struct QPageSetupDialogPrivate;

/// Binding for C++ class [QPageSetupDialog](https://doc.qt.io/qt-6/qpagesetupdialog.html).
class /+ Q_PRINTSUPPORT_EXPORT +/ QPageSetupDialog : QDialog
{
    mixin(Q_OBJECT);

public:
    /+ explicit +/this(QPrinter printer, QWidget parent = null);
    /+ explicit +/this(QWidget parent = null);
    ~this();

    version (OSX)
    {
        override void setVisible(bool visible);
    }
    else version (Windows)
    {
        override void setVisible(bool visible);
    }

    override int exec();

    final void open(QObject receiver, const(char)* member);

    override void done(int result);

    final QPrinter printer();

    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
