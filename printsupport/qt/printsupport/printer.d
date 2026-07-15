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
module qt.printsupport.printer;
extern(C++):

import qt.config;
import qt.core.global;
import qt.core.list;
import qt.core.namespace;
import qt.core.rect;
import qt.core.string;
import qt.gui.pagedpaintdevice;
import qt.gui.paintdevice;
import qt.gui.paintengine;
import qt.helpers;

/+ #if defined(B0)
#undef B0 // Terminal hang-up.  We assume that you do not want that.
#endif +/

extern(C++, class) struct QPrinterPrivate;
class QPrintEngine;
extern(C++, class) struct QPrinterInfo;

/// Binding for C++ class [QPrinter](https://doc.qt.io/qt-6/qprinter.html).
class /+ Q_PRINTSUPPORT_EXPORT +/ QPrinter : QPagedPaintDevice
{
    /+ friend class QPrintDialogPrivate; +/
    /+ friend class QAbstractPrintDialog; +/
    /+ friend class QAbstractPrintDialogPrivate; +/
    /+ friend class QPrintPreviewWidgetPrivate; +/
    /+ friend class QTextDocument; +/
    /+ friend class QPageSetupWidget; +/

public:
    enum PrinterMode { ScreenResolution, PrinterResolution, HighResolution }

    /+ explicit +/this(PrinterMode mode = PrinterMode.ScreenResolution);
    /+ explicit +/this(ref const(QPrinterInfo) printer, PrinterMode mode = PrinterMode.ScreenResolution);
    ~this();

    enum PageOrder   { FirstPageFirst,
                       LastPageFirst }

    enum ColorMode   { GrayScale,
                       Color }

    enum PaperSource { OnlyOne,
                       Lower,
                       Middle,
                       Manual,
                       Envelope,
                       EnvelopeManual,
                       Auto,
                       Tractor,
                       SmallFormat,
                       LargeFormat,
                       LargeCapacity,
                       Cassette,
                       FormSource,
                       MaxPageSource,
                       CustomSource,
                       LastPaperSource = CustomSource,
                       Upper = OnlyOne
    }

    enum PrinterState { Idle,
                        Active,
                        Aborted,
                        Error }

    enum OutputFormat { NativeFormat, PdfFormat }

    enum PrintRange { AllPages, Selection, PageRange, CurrentPage }

    enum Unit {
        Millimeter,
        Point,
        Inch,
        Pica,
        Didot,
        Cicero,
        DevicePixel
    }

    enum DuplexMode {
        DuplexNone = 0,
        DuplexAuto,
        DuplexLongSide,
        DuplexShortSide
    }

    final void setOutputFormat(OutputFormat format);
    final OutputFormat outputFormat() const;

    final void setPdfVersion(QPagedPaintDevice.PdfVersion version_);
    final QPagedPaintDevice.PdfVersion pdfVersion() const;

    final void setPrinterName(ref const(QString));
    final QString printerName() const;

    final bool isValid() const;

    final void setOutputFileName(ref const(QString));
    final QString outputFileName() const;

    final void setPrintProgram(ref const(QString));
    final QString printProgram() const;

    final void setDocName(ref const(QString));
    final QString docName() const;

    final void setCreator(ref const(QString));
    final QString creator() const;

    final void setPageOrder(PageOrder);
    final PageOrder pageOrder() const;

    final void setResolution(int);
    final int resolution() const;

    final void setColorMode(ColorMode);
    final ColorMode colorMode() const;

    final void setCollateCopies(bool collate);
    final bool collateCopies() const;

    final void setFullPage(bool);
    final bool fullPage() const;

    final void setCopyCount(int);
    final int copyCount() const;
    final bool supportsMultipleCopies() const;

    final void setPaperSource(PaperSource);
    final PaperSource paperSource() const;

    final void setDuplex(DuplexMode duplex);
    final DuplexMode duplex() const;

    final QList!(int) supportedResolutions() const;

    /+ #if defined(Q_OS_WIN) || defined(Q_CLANG_QDOC) +/
    //final QList!(PaperSource) supportedPaperSources() const;
    /+ #endif +/

    final void setFontEmbeddingEnabled(bool enable);
    final bool fontEmbeddingEnabled() const;

    final QRectF paperRect(Unit) const;
    final QRectF pageRect(Unit) const;

    final QString printerSelectionOption() const;
    final void setPrinterSelectionOption(ref const(QString));

    override bool newPage();
    final bool abort();

    final PrinterState printerState() const;

    override QPaintEngine paintEngine() const;
    final QPrintEngine printEngine() const;

    final void setFromTo(int fromPage, int toPage);
    final int fromPage() const;
    final int toPage() const;

    final void setPrintRange(PrintRange range);
    final PrintRange printRange() const;

protected:
    override int metric(QPaintDevice.PaintDeviceMetric) const;
    final void setEngines(QPrintEngine printEngine, QPaintEngine paintEngine);

private:
    QPrinterPrivate* d_ptr;

public:
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

static assert(__traits(classInstanceSize, QPrinter) == (void*).sizeof * 4);
