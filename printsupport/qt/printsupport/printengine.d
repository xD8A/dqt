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
module qt.printsupport.printengine;
extern(C++):

import qt.config;
import qt.core.variant;
import qt.gui.paintdevice;
import qt.helpers;
import qt.printsupport.printer;

/// Binding for C++ class [QPrintEngine](https://doc.qt.io/qt-6/qprintengine.html).
class /+ Q_PRINTSUPPORT_EXPORT +/ QPrintEngine
{
public:
    // ~this(); // inline in C++ (virtual ~QPrintEngine() {}), not exported

    enum PrintEnginePropertyKey {
        PPK_CollateCopies,
        PPK_ColorMode,
        PPK_Creator,
        PPK_DocumentName,
        PPK_FullPage,
        PPK_NumberOfCopies,
        PPK_Orientation,
        PPK_OutputFileName,
        PPK_PageOrder,
        PPK_PageRect,
        PPK_PageSize,
        PPK_PaperRect,
        PPK_PaperSource,
        PPK_PrinterName,
        PPK_PrinterProgram,
        PPK_Resolution,
        PPK_SelectionOption,
        PPK_SupportedResolutions,

        PPK_WindowsPageSize,
        PPK_FontEmbedding,

        PPK_Duplex,

        PPK_PaperSources,
        PPK_CustomPaperSize,
        PPK_PageMargins,
        PPK_CopyCount,
        PPK_SupportsMultipleCopies,
        PPK_PaperName,
        PPK_QPageSize,
        PPK_QPageMargins,
        PPK_QPageLayout,
        PPK_PaperSize = PPK_PageSize,

        PPK_CustomBase = 0xff00
    }

    abstract void setProperty(PrintEnginePropertyKey key, ref const(QVariant) value);
    abstract QVariant property(PrintEnginePropertyKey key) const;

    abstract bool newPage();
    abstract bool abort();

    abstract int metric(QPaintDevice.PaintDeviceMetric) const;

    abstract QPrinter.PrinterState printerState() const;

    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
