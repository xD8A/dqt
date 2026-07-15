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
module qt.printsupport.printerinfo;
extern(C++):

import qt.config;
import qt.core.list;
import qt.core.string;
import qt.core.stringlist;
import qt.gui.pagesize;
import qt.helpers;
import qt.printsupport.printer;

/+ class QDebug; +/

extern(C++, class) struct /+ Q_PRINTSUPPORT_EXPORT +/ QPrinterInfo
{
public:
    @disable this();
    pragma(mangle, defaultConstructorMangling(__traits(identifier, typeof(this))))
    ref typeof(this) rawConstructor();
    static typeof(this) create()
    {
        typeof(this) r = typeof(this).init;
        r.rawConstructor();
        return r;
    }

    this(ref const(QPrinterInfo) other);
    // explicit QPrinterInfo(const QPrinter &printer) - not bound due to class vs value type mismatch
    ~this();

    ref QPrinterInfo opAssign(ref const(QPrinterInfo) other);

    final QString printerName() const;
    final QString description() const;
    final QString location() const;
    final QString makeAndModel() const;

    final bool isNull() const;
    final bool isDefault() const;
    final bool isRemote() const;

    final QPrinter.PrinterState state() const;

    final QList!(QPageSize) supportedPageSizes() const;
    final QPageSize defaultPageSize() const;

    final bool supportsCustomPageSizes() const;

    final QPageSize minimumPhysicalPageSize() const;
    final QPageSize maximumPhysicalPageSize() const;

    final QList!(int) supportedResolutions() const;

    final QPrinter.DuplexMode defaultDuplexMode() const;
    final QList!(QPrinter.DuplexMode) supportedDuplexModes() const;

    final QPrinter.ColorMode defaultColorMode() const;
    final QList!(QPrinter.ColorMode) supportedColorModes() const;

    static QStringList availablePrinterNames();
    static QList!(QPrinterInfo) availablePrinters();

    static QString defaultPrinterName();
    static QPrinterInfo defaultPrinter();

    static QPrinterInfo printerInfo(ref const(QString) printerName);

    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
