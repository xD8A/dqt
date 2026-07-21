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
module qt.gui.genericmatrix;
extern(C++):

import qt.config;
import qt.core.namespace;
import qt.helpers;

/// Binding for C++ class [QGenericMatrix](https://doc.qt.io/qt-6/qgenericmatrix.html).
extern(C++, class) struct QGenericMatrix(int N, int M, T)
{
public:
    @disable this();
    /+pragma(inline, true) this()
    {
        setToIdentity();
    }+/
    /+ explicit +/this(/+ Qt:: +/qt.core.namespace.Initialization) {}
    /+ explicit +/this(const(T)* values)
    {
        for (int col = 0; col < N; ++col)
            for (int row = 0; row < M; ++row)
                m[col][row] = values[row * N + col];
    }

    /+pragma(inline, true) ref const(T) operator ()(int row, int column) const
    {
        import qt.core.global;

        (mixin(Q_ASSERT(q{row >= 0 && row < M && column >= 0 && column < N})));
        return m[column][row];
    }+/
    /+pragma(inline, true) ref T operator ()(int row, int column)
    {
        import qt.core.global;

        (mixin(Q_ASSERT(q{row >= 0 && row < M && column >= 0 && column < N})));
        return m[column][row];
    }+/

    bool isIdentity() const
    {
        for (int col = 0; col < N; ++col) {
            for (int row = 0; row < M; ++row) {
                if (row == col) {
                    if (m[col][row] != 1.0f)
                        return false;
                } else {
                    if (m[col][row] != 0.0f)
                        return false;
                }
            }
        }
        return true;
    }
    void setToIdentity()
    {
        for (int col = 0; col < N; ++col) {
            for (int row = 0; row < M; ++row) {
                if (row == col)
                    m[col][row] = 1.0f;
                else
                    m[col][row] = 0.0f;
            }
        }
    }

    void fill(T value)
    {
        for (int col = 0; col < N; ++col)
            for (int row = 0; row < M; ++row)
                m[col][row] = value;
    }

    /+ [[nodiscard]] +/ QGenericMatrix!(M, N, T) transposed() const
    {
        auto result = QGenericMatrix!(M, N, T)(/+ Qt:: +/qt.core.namespace.Uninitialized);

        for (int row = 0; row < M; ++row)
            for (int col = 0; col < N; ++col)
                result.m[row][col] = m[col][row];
        return result;
    }

    ref QGenericMatrix!(N, M, T) opOpAssign(string op)(ref const(QGenericMatrix!(N, M, T)) other) if (op == "+")
    {
        for (int row = 0; row < M; ++row)
            for (int col = 0; col < N; ++col)
                m[col][row] += other.m[col][row];
        return this;
    }
    ref QGenericMatrix!(N, M, T) opOpAssign(string op)(ref const(QGenericMatrix!(N, M, T)) other) if (op == "-")
    {
        for (int row = 0; row < M; ++row)
            for (int col = 0; col < N; ++col)
                m[col][row] -= other.m[col][row];
        return this;
    }
    ref QGenericMatrix!(N, M, T) opOpAssign(string op)(T factor) if (op == "*")
    {
        for (int row = 0; row < M; ++row)
            for (int col = 0; col < N; ++col)
                m[col][row] *= factor;
        return this;
    }
    ref QGenericMatrix!(N, M, T) opOpAssign(string op)(T divisor) if (op == "/")
    {
        for (int row = 0; row < M; ++row)
            for (int col = 0; col < N; ++col)
                m[col][row] /= divisor;
        return this;
    }
    /+bool operator ==(ref const(QGenericMatrix!(N, M, T)) other) const
    {
        for (int row = 0; row < M; ++row)
            for (int col = 0; col < N; ++col)  {
                if (m[col][row] != other.m[col][row])
                    return false;
            }
        return true;
    }+/
    /+bool operator !=(ref const(QGenericMatrix!(N, M, T)) other) const
    {
        return !(this == other);
    }+/

    void copyDataTo(T* values) const
    {
        for (int col = 0; col < N; ++col)
            for (int row = 0; row < M; ++row)
                values[row * N + col] = T(m[col][row]);
    }

    T* data() { return m.ptr.ptr; }
    const(T)* data() const { return m.ptr.ptr; }
    const(T)* constData() const { return m.ptr.ptr; }

    /+ template<int NN, int MM, typename TT> +/
    /+ friend QGenericMatrix<NN, MM, TT> operator+(const QGenericMatrix<NN, MM, TT>& m1, const QGenericMatrix<NN, MM, TT>& m2); +/
    /+ template<int NN, int MM, typename TT> +/
    /+ friend QGenericMatrix<NN, MM, TT> operator-(const QGenericMatrix<NN, MM, TT>& m1, const QGenericMatrix<NN, MM, TT>& m2); +/
    /+ template<int NN, int M1, int M2, typename TT> +/
    /+ friend QGenericMatrix<M1, M2, TT> operator*(const QGenericMatrix<NN, M2, TT>& m1, const QGenericMatrix<M1, NN, TT>& m2); +/
    /+ template<int NN, int MM, typename TT> +/
    /+ friend QGenericMatrix<NN, MM, TT> operator-(const QGenericMatrix<NN, MM, TT>& matrix); +/
    /+ template<int NN, int MM, typename TT> +/
    /+ friend QGenericMatrix<NN, MM, TT> operator*(TT factor, const QGenericMatrix<NN, MM, TT>& matrix); +/
    /+ template<int NN, int MM, typename TT> +/
    /+ friend QGenericMatrix<NN, MM, TT> operator*(const QGenericMatrix<NN, MM, TT>& matrix, TT factor); +/
    /+ template<int NN, int MM, typename TT> +/
    /+ friend QGenericMatrix<NN, MM, TT> operator/(const QGenericMatrix<NN, MM, TT>& matrix, TT divisor); +/

private:
    T[M][N] m;    // Column-major order to match OpenGL.

    /+ template <int NN, int MM, typename TT> +/
    /+ friend class QGenericMatrix; +/
}
/+ template <int N, int M, typename T>
class QTypeInfo<QGenericMatrix<N, M, T> >
    : public QTypeInfoMerger<QGenericMatrix<N, M, T>, T>
{
};

QT_WARNING_PUSH
QT_WARNING_DISABLE_FLOAT_COMPARE

QT_WARNING_POP +/

/+QGenericMatrix!(N, M, T) operator +(int N, int M, T)(ref const(QGenericMatrix!(N, M, T)) m1, ref const(QGenericMatrix!(N, M, T)) m2)
{
    static if (#configValue!"merged")
    {
    auto result = QGenericMatrix!(N, M, T)(/+ Qt:: +/qt.core.namespace.Uninitialized);
    }
static if (#configValue!"merged")
{
QGenericMatrix!(N,M,T) result__1(qt.core.namespace.Initialization);
}
    for (int row = 0; row < M; ++row)
        for (int col = 0; col < N; ++col)
            result__1.m[col][row] = m1.m[col][row] + m2.m[col][row];
    return cast(QGenericMatrix!(int, int, T)) (result__1);
}+/

/+QGenericMatrix!(N, M, T) operator -(int N, int M, T)(ref const(QGenericMatrix!(N, M, T)) m1, ref const(QGenericMatrix!(N, M, T)) m2)
{
    static if (#configValue!"merged")
    {
    auto result = QGenericMatrix!(N, M, T)(/+ Qt:: +/qt.core.namespace.Uninitialized);
    }
static if (#configValue!"merged")
{
QGenericMatrix!(N,M,T) result__1(qt.core.namespace.Initialization);
}
    for (int row = 0; row < M; ++row)
        for (int col = 0; col < N; ++col)
            result__1.m[col][row] = m1.m[col][row] - m2.m[col][row];
    return cast(QGenericMatrix!(int, int, T)) (result__1);
}+/

/+QGenericMatrix!(M1, M2, T) operator *(int N, int M1, int M2, T)(ref const(QGenericMatrix!(N, M2, T)) m1, ref const(QGenericMatrix!(M1, N, T)) m2)
{
    static if (#configValue!"merged")
    {
    auto result = QGenericMatrix!(M1, M2, T)(/+ Qt:: +/qt.core.namespace.Uninitialized);
    }
static if (#configValue!"merged")
{
QGenericMatrix!(M1,M2,T) result__1(qt.core.namespace.Initialization);
}
    for (int row = 0; row < M2; ++row) {
        for (int col = 0; col < M1; ++col) {
            auto sum = T(0.0f);
            for (int j = 0; j < N; ++j)
                sum += m1.m[j][row] * m2.m[col][j];
            result__1.m[col][row] = sum;
        }
    }
    return cast(QGenericMatrix!(int, int, T)) (result__1);
}+/

/+QGenericMatrix!(N, M, T) operator -(int N, int M, T)(ref const(QGenericMatrix!(N, M, T)) matrix)
{
    static if (#configValue!"merged")
    {
    auto result = QGenericMatrix!(N, M, T)(/+ Qt:: +/qt.core.namespace.Uninitialized);
    }
static if (#configValue!"merged")
{
QGenericMatrix!(N,M,T) result__1(qt.core.namespace.Initialization);
}
    for (int row = 0; row < M; ++row)
        for (int col = 0; col < N; ++col)
            result__1.m[col][row] = -matrix.m[col][row];
    return cast(QGenericMatrix!(int, int, T)) (result__1);
}+/

/+QGenericMatrix!(N, M, T) operator *(int N, int M, T)(T factor, ref const(QGenericMatrix!(N, M, T)) matrix)
{
    static if (#configValue!"merged")
    {
    auto result = QGenericMatrix!(N, M, T)(/+ Qt:: +/qt.core.namespace.Uninitialized);
    }
static if (#configValue!"merged")
{
QGenericMatrix!(N,M,T) result__1(qt.core.namespace.Initialization);
}
    for (int row = 0; row < M; ++row)
        for (int col = 0; col < N; ++col)
            result__1.m[col][row] = matrix.m[col][row] * factor;
    return cast(QGenericMatrix!(int, int, T)) (result__1);
}+/

/+QGenericMatrix!(N, M, T) operator *(int N, int M, T)(ref const(QGenericMatrix!(N, M, T)) matrix, T factor)
{
    static if (#configValue!"merged")
    {
    auto result = QGenericMatrix!(N, M, T)(/+ Qt:: +/qt.core.namespace.Uninitialized);
    }
static if (#configValue!"merged")
{
QGenericMatrix!(N,M,T) result__1(qt.core.namespace.Initialization);
}
    for (int row = 0; row < M; ++row)
        for (int col = 0; col < N; ++col)
            result__1.m[col][row] = matrix.m[col][row] * factor;
    return cast(QGenericMatrix!(int, int, T)) (result__1);
}+/

/+QGenericMatrix!(N, M, T) operator /(int N, int M, T)(ref const(QGenericMatrix!(N, M, T)) matrix, T divisor)
{
    static if (#configValue!"merged")
    {
    auto result = QGenericMatrix!(N, M, T)(/+ Qt:: +/qt.core.namespace.Uninitialized);
    }
static if (#configValue!"merged")
{
QGenericMatrix!(N,M,T) result__1(qt.core.namespace.Initialization);
}
    for (int row = 0; row < M; ++row)
        for (int col = 0; col < N; ++col)
            result__1.m[col][row] = matrix.m[col][row] / divisor;
    return cast(QGenericMatrix!(int, int, T)) (result__1);
}+/

// Define aliases for the useful variants of QGenericMatrix.
alias QMatrix2x2 = QGenericMatrix!(2, 2, float);
alias QMatrix2x3 = QGenericMatrix!(2, 3, float);
alias QMatrix2x4 = QGenericMatrix!(2, 4, float);
alias QMatrix3x2 = QGenericMatrix!(3, 2, float);
alias QMatrix3x3 = QGenericMatrix!(3, 3, float);
alias QMatrix3x4 = QGenericMatrix!(3, 4, float);
alias QMatrix4x2 = QGenericMatrix!(4, 2, float);
alias QMatrix4x3 = QGenericMatrix!(4, 3, float);

/+ #ifndef QT_NO_DEBUG_STREAM

template <int N, int M, typename T>
QDebug operator<<(QDebug dbg, const QGenericMatrix<N, M, T> &m)
{
    QDebugStateSaver saver(dbg);
    dbg.nospace() << "QGenericMatrix<" << N << ", " << M
        << ", " << QMetaType::fromType<T>().name()
        << ">(" << Qt::endl << qSetFieldWidth(10);
    for (int row = 0; row < M; ++row) {
        for (int col = 0; col < N; ++col)
            dbg << m(row, col);
        dbg << Qt::endl;
    }
    dbg << qSetFieldWidth(0) << ')';
    return dbg;
}

#endif

#ifndef QT_NO_DATASTREAM

template <int N, int M, typename T>
QDataStream &operator<<(QDataStream &stream, const QGenericMatrix<N, M, T> &matrix)
{
    for (int row = 0; row < M; ++row)
        for (int col = 0; col < N; ++col)
            stream << double(matrix(row, col));
    return stream;
}

template <int N, int M, typename T>
QDataStream &operator>>(QDataStream &stream, QGenericMatrix<N, M, T> &matrix)
{
    double x;
    for (int row = 0; row < M; ++row) {
        for (int col = 0; col < N; ++col) {
            stream >> x;
            matrix(row, col) = T(x);
        }
    }
    return stream;
}

#endif


QT_DECL_METATYPE_EXTERN(QMatrix2x2, Q_GUI_EXPORT)
QT_DECL_METATYPE_EXTERN(QMatrix2x3, Q_GUI_EXPORT)
QT_DECL_METATYPE_EXTERN(QMatrix2x4, Q_GUI_EXPORT)
QT_DECL_METATYPE_EXTERN(QMatrix3x2, Q_GUI_EXPORT)
QT_DECL_METATYPE_EXTERN(QMatrix3x3, Q_GUI_EXPORT)
QT_DECL_METATYPE_EXTERN(QMatrix3x4, Q_GUI_EXPORT)
QT_DECL_METATYPE_EXTERN(QMatrix4x2, Q_GUI_EXPORT)
QT_DECL_METATYPE_EXTERN(QMatrix4x3, Q_GUI_EXPORT) +/
