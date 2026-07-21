module mainwindow;

import core.stdcpp.new_ : cpp_new;
import qt.config;
import qt.core.namespace : TextInteractionFlag;
import qt.core.point : QPointF;
import qt.core.rect : QRectF;
import qt.core.size : QSize;
import qt.core.string : QString;
import qt.gui.font : QFont;
import qt.gui.painter : QPainter;
import qt.helpers;
import qt.widgets.boxlayout : QVBoxLayout;
import qt.widgets.graphicsitem : QGraphicsItem, QGraphicsTextItem;
import qt.widgets.graphicsscene : QGraphicsScene;
import qt.widgets.graphicsview : QGraphicsView;
import qt.widgets.widget : QWidget;

import textitem : TextItem;


class MainWindow : QWidget
{
    mixin(Q_OBJECT_D);
public:
    this(QWidget parent = null)
    {
        super(parent);

        scene = cpp_new!QGraphicsScene(this);
        scene.setSceneRect(QRectF(0, 0, 400, 300));

        auto text = QString("Hello, World!");
        auto font = QFont.create();

        auto textItem1 = scene.addText(text, font);
        textItem1.setPos(QPointF(50, 50));
        textItem1.setFlags(QGraphicsItem.GraphicsItemFlags(
            QGraphicsItem.GraphicsItemFlag.ItemIsMovable |
            QGraphicsItem.GraphicsItemFlag.ItemIsSelectable
            ));
        //textItem1.setTextInteractionFlags(TextInteractionFlag.TextEditorInteraction);
        // assert(QGraphicsTextItem.Type == textItem1.type());

        auto textItem2 = cpp_new!QGraphicsTextItem(text);
        textItem2.setFont(font);
        textItem2.setPos(QPointF(50, 100));
        textItem2.setFlags(QGraphicsItem.GraphicsItemFlags(
            QGraphicsItem.GraphicsItemFlag.ItemIsMovable |
            QGraphicsItem.GraphicsItemFlag.ItemIsSelectable));
        //textItem2.setTextInteractionFlags(TextInteractionFlag.TextEditorInteraction);
        scene.addItem(textItem2);
        // assert(QGraphicsTextItem.Type == textItem2.type());

        auto textItem3 = cpp_new!TextItem(text);
        textItem3.setFont(font);
        textItem3.setPos(QPointF(50, 150));
        scene.addItem(textItem3);
        assert(TextItem.Type == textItem3.type());

        view = cpp_new!QGraphicsView(scene);
        view.setRenderHint(QPainter.RenderHint.Antialiasing);
        view.setMinimumSize(QSize(500, 400));

        auto layout = cpp_new!QVBoxLayout();
        layout.addWidget(view);
        setLayout(layout);

        setWindowTitle("Text Example");
    }

private:
    QGraphicsScene scene;
    QGraphicsView view;
}
