module textitem;

import qt.core.namespace : TextInteractionFlag;
import qt.core.variant : QVariant;
import qt.core.string : QString;
import qt.gui.event : QFocusEvent;
import qt.helpers;
import qt.widgets.graphicsitem : QGraphicsItem, QGraphicsTextItem;
import qt.widgets.graphicssceneevent : QGraphicsSceneMouseEvent;

class TextItem : QGraphicsTextItem
{
    mixin(Q_OBJECT_D);

public:
    enum { Type = QGraphicsItem.UserType + 3 }

    this(ref const(QString) text, QGraphicsItem parent = null)
    {
        super(text, parent);
        setFlags(QGraphicsItem.GraphicsItemFlags(
            QGraphicsItem.GraphicsItemFlag.ItemIsMovable |
            QGraphicsItem.GraphicsItemFlag.ItemIsSelectable));
    }

    extern (C++) override int type() const { return Type; }

protected:
    extern (C++) override QVariant itemChange(GraphicsItemChange change, ref const(QVariant) value)
    {
        return value;
    }

    extern (C++) override void focusOutEvent(QFocusEvent event)
    {
        setTextInteractionFlags(TextInteractionFlag.NoTextInteraction);
        super.focusOutEvent(event);
    }

    extern (C++) override void mouseDoubleClickEvent(QGraphicsSceneMouseEvent event)
    {
        if (textInteractionFlags() == TextInteractionFlag.NoTextInteraction)
            setTextInteractionFlags(TextInteractionFlag.TextEditorInteraction);
        super.mouseDoubleClickEvent(event);
    }
}
