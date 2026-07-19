// QT_MODULES: gui
module testgui1;

import qt.config;
import qt.core.coreevent;
import qt.gui.backingstore;
import qt.gui.event;
import qt.gui.guiapplication;
import qt.gui.window;
import qt.helpers;

QGuiApplication app;
version (Android)
{}
else
{
shared static this()
{
    import core.runtime;
    import core.stdcpp.new_;

    static __gshared int argc_copy; // Needs to be global, because the application stores a reference.
    argc_copy = Runtime.cArgs.argc;

    app = cpp_new!QGuiApplication(argc_copy, Runtime.cArgs.argv);
}
shared static ~this()
{
    import core.stdcpp.new_;

    cpp_delete(app);
    app = null;
}
}

class TestWindow : QWindow
{
    mixin(Q_OBJECT_D);
public:
    /+ explicit +/this()
    {
        import core.stdcpp.new_;

        backingStore = cpp_new!QBackingStore(this);
        resize(400, 400);
    }
    ~this()
    {
        import core.stdcpp.new_;

        cpp_delete(backingStore);
    }

protected:
    final void renderNow()
    {
        import qt.core.namespace;
        import qt.core.rect;
        import qt.gui.brush;
        import qt.gui.color;
        import qt.gui.paintdevice;
        import qt.gui.painter;
        import qt.gui.region;

        if (!isExposed())
            return;

        auto rect = QRect(0, 0, width(), height());
        backingStore.beginPaint(QRegion(rect));

        QPaintDevice device = backingStore.paintDevice();
        auto painter = QPainter(device);
        painter.setRenderHint(QPainter.RenderHint.Antialiasing);

        painter.fillRect(QRectF(0, 0, width(), height()), QBrush(QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.blue)));
        painter.fillRect(QRectF(10, 10, 50, 50), QBrush(QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.red)));

        painter.end();
        backingStore.endPaint();
        backingStore.flush(QRegion(rect));

        /+ emit +/ rendered();
    }

    extern(C++) override bool event(QEvent event)
    {
        if (event.type() == QEvent.Type.UpdateRequest)
        {
            renderNow();
            return true;
        }
        return QWindow.event(event);
    }

    extern(C++) override void resizeEvent(QResizeEvent event)
    {
        backingStore.resize(event.size());
    }

    extern(C++) override void exposeEvent(QExposeEvent event)
    {
        if (isExposed())
            renderNow();
    }

/+ signals +/public:
    @QSignal final void rendered() {mixin(Q_SIGNAL_IMPL_D);}

private:
    QBackingStore* backingStore;
}

unittest
{
    import core.stdcpp.new_;
    import qt.core.metatype;
    import qt.core.namespace;
    import qt.core.string;
    import qt.core.variant;
    import qt.gui.brush;
    import qt.gui.color;
    import qt.gui.standarditemmodel;

    QStandardItem item = cpp_new!QStandardItem;
    QString tmp = QString("test");
    item.setText(tmp);
    QString text = item.text();
    assert(text == "test");
    assert(qMetaTypeId!(QString)() == QVariant.Type.String);
    assert(item.data(/+ Qt:: +/qt.core.namespace.ItemDataRole.DisplayRole).userType() == qMetaTypeId!(QString)());
    QVariant variant = QVariant.fromValue(text);
    item.setData(variant, /+ Qt:: +/qt.core.namespace.ItemDataRole.DisplayRole);
    text = item.text();
    assert(text == "test");

    auto tmp2 = QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.red); QBrush brush = QBrush(tmp2);
    item.setBackground(brush);
    brush = item.background();
    assert(brush.color() == QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.red));

    QColor color2 = QColor.fromRgb(101, 102, 103, 104);
    assert(color2.red() == 101);
    assert(color2.green() == 102);
    assert(color2.blue() == 103);
    assert(color2.alpha() == 104);

    QBrush brush2 = QBrush(color2);
    item.setBackground(brush2);
    brush2 = item.background();
    assert(brush2.color() == color2);

    cpp_delete(item);
}

unittest
{
    import qt.core.list;
    import qt.core.variant;
    import qt.gui.brush;
    import qt.gui.color;

    QBrushData* data;
    {
        QBrush b = QBrush(QColor(1, 2, 3));
        data = *cast(QBrushData**)&b;
        assert(data.ref_.loadRelaxed() == 1);
        data.ref_.ref_(); // Add reference, so it is not freed and we can check the count at the end.
        assert(data.ref_.loadRelaxed() == 2);
        QBrush b2 = b;
        assert(data.ref_.loadRelaxed() == 3);
    }
    assert(data.ref_.loadRelaxed() == 1); // Only our extra reference remains.
    {
        QBrush b = QBrush.create;
        *cast(QBrushData**)&b = data;
        data = null;
    }

    {
        QBrush b = QBrush(QColor(1, 2, 3));
        data = *cast(QBrushData**)&b;
        assert(data.ref_.loadRelaxed() == 1);
        data.ref_.ref_(); // Add reference, so it is not freed and we can check the count at the end.
        assert(data.ref_.loadRelaxed() == 2);
        QVariant v = QVariant.fromValue(b);
        assert(data.ref_.loadRelaxed() == 3);
        QVariant v2 = v;
        assert(data.ref_.loadRelaxed() == 4);
    }
    assert(data.ref_.loadRelaxed() == 1); // Only our extra reference remains.
    {
        QBrush b = QBrush.create;
        *cast(QBrushData**)&b = data;
        data = null;
    }

    {
        QBrush b = QBrush(QColor(1, 2, 3));
        data = *cast(QBrushData**)&b;
        assert(data.ref_.loadRelaxed() == 1);
        data.ref_.ref_(); // Add reference, so it is not freed and we can check the count at the end.
        assert(data.ref_.loadRelaxed() == 2);
        QList!(QBrush) l = QList!(QBrush).create();
        l.append(b);
        assert(data.ref_.loadRelaxed() == 3);
    }
    assert(data.ref_.loadRelaxed() == 1); // Only our extra reference remains.
    {
        QBrush b = QBrush.create;
        *cast(QBrushData**)&b = data;
        data = null;
    }
}

unittest
{
    import core.stdcpp.new_;
    import qt.core.string;
    import qt.core.url;
    import qt.gui.textdocument;

    QTextDocument document = cpp_new!QTextDocument;
    QUrl url = QUrl(QString("https://dlang.org/"));
    assert(url.toString().toConstWString == "https://dlang.org/"w);
    document.setBaseUrl(url);
    assert(document.baseUrl().toString().toConstWString == "https://dlang.org/"w);

    cpp_delete(document);
}

unittest
{
    import qt.gui.image;

    QImage image = QImage.create();
    assert(image.isNull());

    image = QImage(200, 100, QImage.Format.Format_ARGB32_Premultiplied);
    assert(!image.isNull());
    assert(image.width() == 200);
    assert(image.height() == 100);

    image = QImage.create();
    assert(image.isNull());
}

version (Android)
{}
else
unittest
{
    import qt.gui.pixmap;

    QPixmap pixmap = QPixmap.create();
    assert(pixmap.isNull());

    pixmap = QPixmap(200, 100);
    assert(!pixmap.isNull());
    assert(pixmap.width() == 200);
    assert(pixmap.height() == 100);

    pixmap = QPixmap.create();
    assert(pixmap.isNull());
}

extern (C++) void cleanupFunc(void* data)
{
    (*cast(int*)data)++;
}

unittest
{
    import qt.core.global;
    import qt.gui.color;
    import qt.gui.image;

    ubyte[3 * 16 * 32] data;
    data[] = 0x55;
    int cleanupCalled = 0;
    QImage image = QImage(data.ptr, 16, 32, QImage.Format.Format_RGB888, &cleanupFunc, &cleanupCalled);
    assert(cleanupCalled == 0);
    assert(image.constBits() == data.ptr);
    assert(cleanupCalled == 0);
    assert(image.bits() == data.ptr);
    assert(cleanupCalled == 0);

    image.setPixelColor(0, 0, QColor(0x10, 0x20, 0x30));
    assert(cleanupCalled == 0);
    assert(image.constBits() == data.ptr);
    assert(data[0] == 0x10);
    assert(data[1] == 0x20);
    assert(data[2] == 0x30);

    image = QImage.create();
    assert(image.isNull());
    assert(cleanupCalled == 1);
}

unittest
{
    import qt.core.global;
    import qt.gui.color;
    import qt.gui.image;

    ubyte[3 * 16 * 32] data;
    data[] = 0x55;
    int cleanupCalled = 0;
    QImage image = QImage(cast(const(ubyte)*)data.ptr, 16, 32, QImage.Format.Format_RGB888, &cleanupFunc, &cleanupCalled);
    assert(cleanupCalled == 0);
    assert(image.constBits() == data.ptr);
    assert(cleanupCalled == 0);

    image.setPixelColor(0, 0, QColor(0x10, 0x20, 0x30));
    assert(cleanupCalled == 1); // setPixel creates a copy, because data was const. The original image is cleaned up.
    assert(image.constBits() != data.ptr);
    assert(data[0] == 0x55);
    assert(data[1] == 0x55);
    assert(data[2] == 0x55);

    image = QImage.create();
    assert(image.isNull());
    assert(cleanupCalled == 1);
}

unittest
{
    import qt.core.global;
    import qt.gui.color;
    import qt.gui.image;

    ubyte[3 * 16 * 32] data;
    data[] = 0x55;
    int cleanupCalled = 0;
    QImage image = QImage(cast(const(ubyte)*)data.ptr, 16, 32, QImage.Format.Format_RGB888, &cleanupFunc, &cleanupCalled);
    assert(cleanupCalled == 0);
    assert(image.constBits() == data.ptr);
    assert(cleanupCalled == 0);

    QImage image2 = image;
    assert(cleanupCalled == 0);
    assert(image2.constBits() == data.ptr);
    assert(cleanupCalled == 0);

    image.setPixelColor(0, 0, QColor(0x10, 0x20, 0x30));
    assert(cleanupCalled == 0);
    assert(image.constBits() != data.ptr);
    assert(image2.constBits() == data.ptr);
    assert(data[0] == 0x55); // Data was not modified.
    assert(data[1] == 0x55);
    assert(data[2] == 0x55);

    image = QImage.create();
    assert(image.isNull());
    assert(cleanupCalled == 0);

    image2 = QImage.create();
    assert(image2.isNull());
    assert(cleanupCalled == 1);
}

unittest
{
    import qt.core.namespace;
    import qt.core.rect;
    import qt.gui.brush;
    import qt.gui.color;
    import qt.gui.image;
    import qt.gui.painter;

    auto image = QImage(100, 100, QImage.Format.Format_ARGB32_Premultiplied);
    image.fill(/+ Qt:: +/qt.core.namespace.GlobalColor.transparent);

    {
        auto painter = QPainter(image.paintDevice);
        painter.fillRect(QRect(0, 0, image.width(), image.height()), QBrush(QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.blue)));
        painter.fillRect(QRect(10, 10, 50, 50), QBrush(QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.red)));
    }

    assert(image.pixelColor(5, 5) == QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.blue));
    assert(image.pixelColor(30, 30) == QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.red));
}

version (Android)
{}
else
unittest
{
    import qt.core.namespace;
    import qt.core.rect;
    import qt.gui.brush;
    import qt.gui.color;
    import qt.gui.image;
    import qt.gui.painter;
    import qt.gui.pixmap;

    auto pixmap = QPixmap(100, 100);
    pixmap.fill(/+ Qt:: +/qt.core.namespace.GlobalColor.transparent);

    {
        auto painter = QPainter(pixmap.paintDevice);
        painter.fillRect(QRect(0, 0, pixmap.width(), pixmap.height()), QBrush(QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.blue)));
        painter.fillRect(QRect(10, 10, 50, 50), QBrush(QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.red)));
    }

    QImage image = pixmap.toImage();
    assert(image.pixelColor(5, 5) == QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.blue));
    assert(image.pixelColor(30, 30) == QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.red));
}

version (Android)
{}
else
unittest
{
    import qt.core.eventloop;
    import qt.core.namespace;
    import qt.core.object;
    import qt.gui.color;
    import qt.gui.image;
    import qt.gui.paintdevice;
    import qt.gui.region;

    scope window = new TestWindow;
    window.show();

    scope eventLoop = new QEventLoop;
    QObject.connect(window.signal!"rendered", eventLoop.slot!"quit", /+ Qt:: +/qt.core.namespace.ConnectionType.QueuedConnection);
    eventLoop.exec();

    QBackingStore* bs = window.backingStore;
    assert(bs !is null);

    bs.flush(QRegion(0, 0, window.width(), window.height()));

    const(QPaintDevice) device = bs.paintDevice();
    assert(device.devType() == QInternal.PaintDeviceFlags.Image);
    const(QImage)* image = static_cast!(const(QImage)*)(device);
    assert(image !is null);
    assert(!image.isNull());

    assert(image.pixelColor(5, 5) == QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.blue));
    assert(image.pixelColor(30, 30) == QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.red));
}

version (Android)
{}
else
unittest
{
    import qt.core.global;
    import qt.core.namespace;
    import qt.core.point;
    import qt.core.string;
    import qt.core.vector;
    import qt.gui.brush;
    import qt.gui.color;
    import qt.gui.font;
    import qt.gui.fontdatabase;
    import qt.gui.fontmetrics;
    import qt.gui.textlayout;
    import qt.gui.textoption;

    QString text = cast(QString) ("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod"
                   ~ " tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim"
                   ~ " veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea"
                   ~ " commodo consequat. Duis aute irure dolor in reprehenderit in voluptate"
                   ~ " velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat"
                   ~ " cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est"
                   ~ " laborum.");

    QVector!(QTextLayout.FormatRange) formats = QVector!(QTextLayout.FormatRange).create();

    QFont font1 = QFontDatabase.systemFont(QFontDatabase.SystemFont.FixedFont);
    font1.setPixelSize(14);
    font1.setStyleHint(QFont.StyleHint.Monospace, QFont.StyleStrategy.PreferMatch);
    font1.setHintingPreference(QFont.HintingPreference.PreferNoHinting);

    QFont font2 = font1;
    font2.setPixelSize(28);

    auto fm = QFontMetricsF(font1);
    int lineWidth = cast(int) (fm.averageCharWidth() * 80.5);

    QTextLayout.FormatRange fr;
    fr.start = 120;
    fr.length = 50;
    fr.format.setBackground(QColor(255, 255, 0, 180));
    fr.format.setForeground(QBrush(QColor(/+ Qt:: +/qt.core.namespace.GlobalColor.black)));
    fr.format.setFont(font2);
    formats.append(fr);

    auto layout = QTextLayout(text, font1);
    QTextOption textOption;
    textOption.setWrapMode(QTextOption.WrapMode.WordWrap);
    textOption.setAlignment(/+ Qt:: +/qt.core.namespace.AlignmentFlag.AlignCenter);
    layout.setTextOption(textOption);
    layout.setFormats(formats);

    layout.beginLayout();
    qreal y = 0;
    while (true)
    {
        QTextLine line = layout.createLine();
        if (!line.isValid())
            break;
        line.setLineWidth(lineWidth);
        line.setPosition(QPointF(0, y));
        y += line.height();
    }
    layout.endLayout();

    assert(layout.lineCount() >= 5);
    assert(layout.lineCount() <= 9);

    int covered = 0;
    for (int i = 0; i < layout.lineCount(); ++i) {
        QTextLine ln = layout.lineAt(i);
        assert(ln.textStart() == covered);
        assert(ln.textLength() > 0);
        if (i == 1 || i == 2)
            assert(ln.height() > fm.height() * 1.6);
        else
            assert(ln.height() < fm.height() * 1.4);
        covered += ln.textLength();
    }
    assert(covered == text.length());

    assert(layout.boundingRect().width() == lineWidth);
    assert(layout.boundingRect().height() >= fm.height() * (layout.lineCount() + 2) * 0.9);
    assert(layout.boundingRect().height() <= fm.height() * (layout.lineCount() + 2) * 1.1);
}
