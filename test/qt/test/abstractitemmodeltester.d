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
module qt.test.abstractitemmodeltester;
extern(C++):

import qt.config;
import qt.core.abstractitemmodel;
import qt.core.object;
import qt.helpers;

/+ #ifdef QT_GUI_LIB
#endif

QT_REQUIRE_CONFIG(itemmodeltester); +/


extern(C++, class) struct QAbstractItemModelTesterPrivate;

/+ namespace QTestPrivate {
inline bool testDataGuiRoles(QAbstractItemModelTester *tester);
} +/

class /+ Q_TESTLIB_EXPORT +/ QAbstractItemModelTester : QObject
{
    mixin(Q_OBJECT);
    /+ Q_DECLARE_PRIVATE(QAbstractItemModelTester) +/

public:
    enum /+ class +/ FailureReportingMode {
        QtTest,
        Warning,
        Fatal
    }

    this(QAbstractItemModel model, QObject parent = null);
    this(QAbstractItemModel model, FailureReportingMode mode, QObject parent = null);

    final QAbstractItemModel model() const;
    final FailureReportingMode failureReportingMode() const;
    final void setUseFetchMore(bool value);

private:
    /+ friend inline bool QTestPrivate::testDataGuiRoles(QAbstractItemModelTester *tester); +/
    final bool verify(bool statement, const(char)* statementStr, const(char)* description, const(char)* file, int line);
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

extern(C++, "QTestPrivate") {
/+ #define MODELTESTER_VERIFY(statement) \
do { \
    if (!tester->verify(static_cast<bool>(statement), #statement, "", __FILE__, __LINE__)) \
        return false; \
} while (false) +/
extern(D) alias MODELTESTER_VERIFY = function string(string statement)
{
    return
    mixin(interpolateMixin(q{    do {
            if (!tester.verify(static_cast!(bool)($(statement)), $(stringifyMacroParameter(statement)), "", __FILE__, __LINE__))
                return false;
        } while (false);}));
};
pragma(inline, true) bool testDataGuiRoles(QAbstractItemModelTester tester)
{
    import qt.core.global;
    import qt.core.namespace;
    import qt.core.variant;
    import qt.gui.brush;
    import qt.gui.color;
    import qt.gui.font;
    import qt.gui.icon;
    import qt.gui.image;
    import qt.gui.pixmap;

/+ #ifdef QT_GUI_LIB

#define MODELTESTER_VERIFY(statement) \
do { \
    if (!tester->verify(static_cast<bool>(statement), #statement, "", __FILE__, __LINE__)) \
        return false; \
} while (false) +/

    const model = tester.model();
    (mixin(Q_ASSERT(q{model})));

    if (!model.hasChildren())
        return true;

    QVariant variant;

    auto index00 = model.index(0, 0);
    variant = model.data(index00, /+ Qt:: +/qt.core.namespace.ItemDataRole.DecorationRole);
    if (variant.isValid()) {
        mixin(MODELTESTER_VERIFY(q{variant.canConvert!(QPixmap)()
                               || variant.canConvert!(QImage)()
                               || variant.canConvert!(QIcon)()
                               || variant.canConvert!(QColor)()
                               || variant.canConvert!(QBrush)()}));
    }

    // General Purpose roles that should return a QFont
    variant = model.data(index00, /+ Qt:: +/qt.core.namespace.ItemDataRole.FontRole);
    if (variant.isValid())
        mixin(MODELTESTER_VERIFY(q{variant.canConvert!(QFont)()}));

    // General Purpose roles that should return a QColor or a QBrush
    variant = model.data(index00, /+ Qt:: +/qt.core.namespace.ItemDataRole.BackgroundRole);
    if (variant.isValid())
        mixin(MODELTESTER_VERIFY(q{variant.canConvert!(QColor)() || variant.canConvert!(QBrush)()}));

    variant = model.data(index00, /+ Qt:: +/qt.core.namespace.ItemDataRole.ForegroundRole);
    if (variant.isValid())
        mixin(MODELTESTER_VERIFY(q{variant.canConvert!(QColor)() || variant.canConvert!(QBrush)()}));

/+ #undef MODELTESTER_VERIFY

#else
    Q_UNUSED(tester);
#endif +/ // QT_GUI_LIB

    return true;
}
} // namespaceQTestPrivate

