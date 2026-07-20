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
module qt.gui.matrix4x4;
extern(C++):

import qt.config;
import qt.helpers;
static if (!defined!"QT_NO_MATRIX4X4" && !defined!"QT_NO_QUATERNION")
    import qt.gui.quaternion;
static if (!defined!"QT_NO_MATRIX4X4" && !versionIsSet!("QT_NO_VECTOR3D"))
    import qt.gui.vector3d;
static if (!defined!"QT_NO_MATRIX4X4" && !versionIsSet!("QT_NO_VECTOR4D"))
    import qt.gui.vector4d;
static if (!defined!"QT_NO_MATRIX4X4")
{
    import qt.core.flags;
    import qt.core.namespace;
    import qt.core.point;
    import qt.core.rect;
    import qt.core.typeinfo;
    import qt.core.variant;
    import qt.gui.genericmatrix;
    import qt.gui.transform;
}

extern(C++, class) struct tst_QMatrixNxN;



static if (!defined!"QT_NO_MATRIX4X4")
{


/// Binding for C++ class [QMatrix4x4](https://doc.qt.io/qt-6/qmatrix4x4.html).
@Q_PRIMITIVE_TYPE extern(C++, class) struct /+ Q_GUI_EXPORT +/ QMatrix4x4
{
public:
    @disable this();
    /+pragma(inline, true) this() { setToIdentity(); }+/
    /+ explicit +/this(/+ Qt:: +/qt.core.namespace.Initialization)
    {
        this.flagBits = Flag.General;
    }
    /+ explicit +/this(const(float)* values);
    pragma(inline, true) this(float m11, float m12, float m13, float m14,
                          float m21, float m22, float m23, float m24,
                          float m31, float m32, float m33, float m34,
                          float m41, float m42, float m43, float m44)
    {
        m[0][0] = m11; m[0][1] = m21; m[0][2] = m31; m[0][3] = m41;
        m[1][0] = m12; m[1][1] = m22; m[1][2] = m32; m[1][3] = m42;
        m[2][0] = m13; m[2][1] = m23; m[2][2] = m33; m[2][3] = m43;
        m[3][0] = m14; m[3][1] = m24; m[3][2] = m34; m[3][3] = m44;
        flagBits = Flag.General;
    }

    /+ template <int N, int M> +/
    /+ explicit +/pragma(inline, true) this(int N,int M)(ref const(QGenericMatrix!(N, M, float)) matrix)
    {
        const(float)* values = cast(const(float)*) (matrix.constData());
        for (int matrixCol = 0; matrixCol < 4; ++matrixCol) {
            for (int matrixRow = 0; matrixRow < 4; ++matrixRow) {
                if (matrixCol < N && matrixRow < M)
                    m[matrixCol][matrixRow] = values[matrixCol * M + matrixRow];
                else if (matrixCol == matrixRow)
                    m[matrixCol][matrixRow] = 1.0f;
                else
                    m[matrixCol][matrixRow] = 0.0f;
            }
        }
        flagBits = Flag.General;
    }

    this(const(float)* values, int cols, int rows);
    this(ref const(QTransform) transform);

    /+pragma(inline, true) ref const(float) operator ()(int aRow, int aColumn) const
    {
        import qt.core.global;

        (mixin(Q_ASSERT(q{aRow >= 0 && aRow < 4 && aColumn >= 0 && aColumn < 4})));
        return m[aColumn][aRow];
    }+/
    /+pragma(inline, true) ref float operator ()(int aRow, int aColumn)
    {
        import qt.core.global;

        (mixin(Q_ASSERT(q{aRow >= 0 && aRow < 4 && aColumn >= 0 && aColumn < 4})));
        flagBits = Flag.General;
        return m[aColumn][aRow];
    }+/

    version (QT_NO_VECTOR4D) {} else
    {
        pragma(inline, true) QVector4D column(int index) const
        {
            import qt.core.global;

            (mixin(Q_ASSERT(q{index >= 0 && index < 4})));
            return QVector4D(m[index][0], m[index][1], m[index][2], m[index][3]);
        }
        pragma(inline, true) void setColumn(int index, ref const(QVector4D) value)
        {
            import qt.core.global;

            (mixin(Q_ASSERT(q{index >= 0 && index < 4})));
            m[index][0] = value.x();
            m[index][1] = value.y();
            m[index][2] = value.z();
            m[index][3] = value.w();
            flagBits = Flag.General;
        }

        pragma(inline, true) QVector4D row(int index) const
        {
            import qt.core.global;

            (mixin(Q_ASSERT(q{index >= 0 && index < 4})));
            return QVector4D(m[0][index], m[1][index], m[2][index], m[3][index]);
        }
        pragma(inline, true) void setRow(int index, ref const(QVector4D) value)
        {
            import qt.core.global;

            (mixin(Q_ASSERT(q{index >= 0 && index < 4})));
            m[0][index] = value.x();
            m[1][index] = value.y();
            m[2][index] = value.z();
            m[3][index] = value.w();
            flagBits = Flag.General;
        }
    }

    pragma(inline, true) bool isAffine() const
    {
        return m[0][3] == 0.0f && m[1][3] == 0.0f && m[2][3] == 0.0f && m[3][3] == 1.0f;
    }

    pragma(inline, true) bool isIdentity() const
    {
        if (flagBits == Flag.Identity)
            return true;
        if (m[0][0] != 1.0f || m[0][1] != 0.0f || m[0][2] != 0.0f)
            return false;
        if (m[0][3] != 0.0f || m[1][0] != 0.0f || m[1][1] != 1.0f)
            return false;
        if (m[1][2] != 0.0f || m[1][3] != 0.0f || m[2][0] != 0.0f)
            return false;
        if (m[2][1] != 0.0f || m[2][2] != 1.0f || m[2][3] != 0.0f)
            return false;
        if (m[3][0] != 0.0f || m[3][1] != 0.0f || m[3][2] != 0.0f)
            return false;
        return (m[3][3] == 1.0f);
    }
    pragma(inline, true) void setToIdentity()
    {
        m[0][0] = 1.0f;
        m[0][1] = 0.0f;
        m[0][2] = 0.0f;
        m[0][3] = 0.0f;
        m[1][0] = 0.0f;
        m[1][1] = 1.0f;
        m[1][2] = 0.0f;
        m[1][3] = 0.0f;
        m[2][0] = 0.0f;
        m[2][1] = 0.0f;
        m[2][2] = 1.0f;
        m[2][3] = 0.0f;
        m[3][0] = 0.0f;
        m[3][1] = 0.0f;
        m[3][2] = 0.0f;
        m[3][3] = 1.0f;
        flagBits = Flag.Identity;
    }

    pragma(inline, true) void fill(float value)
    {
        m[0][0] = value;
        m[0][1] = value;
        m[0][2] = value;
        m[0][3] = value;
        m[1][0] = value;
        m[1][1] = value;
        m[1][2] = value;
        m[1][3] = value;
        m[2][0] = value;
        m[2][1] = value;
        m[2][2] = value;
        m[2][3] = value;
        m[3][0] = value;
        m[3][1] = value;
        m[3][2] = value;
        m[3][3] = value;
        flagBits = Flag.General;
    }

    double determinant() const;
    QMatrix4x4 inverted(bool* invertible = null) const;
    QMatrix4x4 transposed() const;
    QMatrix3x3 normalMatrix() const;

    pragma(inline, true) ref QMatrix4x4 opOpAssign(string op)(ref const(QMatrix4x4) other) if (op == "+")
    {
        m[0][0] += other.m[0][0];
        m[0][1] += other.m[0][1];
        m[0][2] += other.m[0][2];
        m[0][3] += other.m[0][3];
        m[1][0] += other.m[1][0];
        m[1][1] += other.m[1][1];
        m[1][2] += other.m[1][2];
        m[1][3] += other.m[1][3];
        m[2][0] += other.m[2][0];
        m[2][1] += other.m[2][1];
        m[2][2] += other.m[2][2];
        m[2][3] += other.m[2][3];
        m[3][0] += other.m[3][0];
        m[3][1] += other.m[3][1];
        m[3][2] += other.m[3][2];
        m[3][3] += other.m[3][3];
        flagBits = Flag.General;
        return this;
    }
    pragma(inline, true) ref QMatrix4x4 opOpAssign(string op)(ref const(QMatrix4x4) other) if (op == "-")
    {
        m[0][0] -= other.m[0][0];
        m[0][1] -= other.m[0][1];
        m[0][2] -= other.m[0][2];
        m[0][3] -= other.m[0][3];
        m[1][0] -= other.m[1][0];
        m[1][1] -= other.m[1][1];
        m[1][2] -= other.m[1][2];
        m[1][3] -= other.m[1][3];
        m[2][0] -= other.m[2][0];
        m[2][1] -= other.m[2][1];
        m[2][2] -= other.m[2][2];
        m[2][3] -= other.m[2][3];
        m[3][0] -= other.m[3][0];
        m[3][1] -= other.m[3][1];
        m[3][2] -= other.m[3][2];
        m[3][3] -= other.m[3][3];
        flagBits = Flag.General;
        return this;
    }
    pragma(inline, true) ref QMatrix4x4 opOpAssign(string op)(ref const(QMatrix4x4) o) if (op == "*")
    {
        const(QMatrix4x4) other = o; // prevent aliasing when &o == this ### Qt 6: take o by value
        flagBits |= other.flagBits;

        if (flagBits.toInt() < Flag.Rotation2D) {
            m[3][0] += m[0][0] * other.m[3][0];
            m[3][1] += m[1][1] * other.m[3][1];
            m[3][2] += m[2][2] * other.m[3][2];

            m[0][0] *= other.m[0][0];
            m[1][1] *= other.m[1][1];
            m[2][2] *= other.m[2][2];
            return this;
        }

        float m0; float m1; float m2;
        m0 = m[0][0] * other.m[0][0]
                + m[1][0] * other.m[0][1]
                + m[2][0] * other.m[0][2]
                + m[3][0] * other.m[0][3];
        m1 = m[0][0] * other.m[1][0]
                + m[1][0] * other.m[1][1]
                + m[2][0] * other.m[1][2]
                + m[3][0] * other.m[1][3];
        m2 = m[0][0] * other.m[2][0]
                + m[1][0] * other.m[2][1]
                + m[2][0] * other.m[2][2]
                + m[3][0] * other.m[2][3];
        m[3][0] = m[0][0] * other.m[3][0]
                + m[1][0] * other.m[3][1]
                + m[2][0] * other.m[3][2]
                + m[3][0] * other.m[3][3];
        m[0][0] = m0;
        m[1][0] = m1;
        m[2][0] = m2;

        m0 = m[0][1] * other.m[0][0]
                + m[1][1] * other.m[0][1]
                + m[2][1] * other.m[0][2]
                + m[3][1] * other.m[0][3];
        m1 = m[0][1] * other.m[1][0]
                + m[1][1] * other.m[1][1]
                + m[2][1] * other.m[1][2]
                + m[3][1] * other.m[1][3];
        m2 = m[0][1] * other.m[2][0]
                + m[1][1] * other.m[2][1]
                + m[2][1] * other.m[2][2]
                + m[3][1] * other.m[2][3];
        m[3][1] = m[0][1] * other.m[3][0]
                + m[1][1] * other.m[3][1]
                + m[2][1] * other.m[3][2]
                + m[3][1] * other.m[3][3];
        m[0][1] = m0;
        m[1][1] = m1;
        m[2][1] = m2;

        m0 = m[0][2] * other.m[0][0]
                + m[1][2] * other.m[0][1]
                + m[2][2] * other.m[0][2]
                + m[3][2] * other.m[0][3];
        m1 = m[0][2] * other.m[1][0]
                + m[1][2] * other.m[1][1]
                + m[2][2] * other.m[1][2]
                + m[3][2] * other.m[1][3];
        m2 = m[0][2] * other.m[2][0]
                + m[1][2] * other.m[2][1]
                + m[2][2] * other.m[2][2]
                + m[3][2] * other.m[2][3];
        m[3][2] = m[0][2] * other.m[3][0]
                + m[1][2] * other.m[3][1]
                + m[2][2] * other.m[3][2]
                + m[3][2] * other.m[3][3];
        m[0][2] = m0;
        m[1][2] = m1;
        m[2][2] = m2;

        m0 = m[0][3] * other.m[0][0]
                + m[1][3] * other.m[0][1]
                + m[2][3] * other.m[0][2]
                + m[3][3] * other.m[0][3];
        m1 = m[0][3] * other.m[1][0]
                + m[1][3] * other.m[1][1]
                + m[2][3] * other.m[1][2]
                + m[3][3] * other.m[1][3];
        m2 = m[0][3] * other.m[2][0]
                + m[1][3] * other.m[2][1]
                + m[2][3] * other.m[2][2]
                + m[3][3] * other.m[2][3];
        m[3][3] = m[0][3] * other.m[3][0]
                + m[1][3] * other.m[3][1]
                + m[2][3] * other.m[3][2]
                + m[3][3] * other.m[3][3];
        m[0][3] = m0;
        m[1][3] = m1;
        m[2][3] = m2;
        return this;
    }
    pragma(inline, true) ref QMatrix4x4 opOpAssign(string op)(float factor) if (op == "*")
    {
        m[0][0] *= factor;
        m[0][1] *= factor;
        m[0][2] *= factor;
        m[0][3] *= factor;
        m[1][0] *= factor;
        m[1][1] *= factor;
        m[1][2] *= factor;
        m[1][3] *= factor;
        m[2][0] *= factor;
        m[2][1] *= factor;
        m[2][2] *= factor;
        m[2][3] *= factor;
        m[3][0] *= factor;
        m[3][1] *= factor;
        m[3][2] *= factor;
        m[3][3] *= factor;
        flagBits = Flag.General;
        return this;
    }
    ref QMatrix4x4 opOpAssign(string op)(float divisor) if (op == "/");
    /+pragma(inline, true) bool operator ==(ref const(QMatrix4x4) other) const
    {
        return m[0][0] == other.m[0][0] &&
               m[0][1] == other.m[0][1] &&
               m[0][2] == other.m[0][2] &&
               m[0][3] == other.m[0][3] &&
               m[1][0] == other.m[1][0] &&
               m[1][1] == other.m[1][1] &&
               m[1][2] == other.m[1][2] &&
               m[1][3] == other.m[1][3] &&
               m[2][0] == other.m[2][0] &&
               m[2][1] == other.m[2][1] &&
               m[2][2] == other.m[2][2] &&
               m[2][3] == other.m[2][3] &&
               m[3][0] == other.m[3][0] &&
               m[3][1] == other.m[3][1] &&
               m[3][2] == other.m[3][2] &&
               m[3][3] == other.m[3][3];
    }+/
    /+pragma(inline, true) bool operator !=(ref const(QMatrix4x4) other) const
    {
        return m[0][0] != other.m[0][0] ||
               m[0][1] != other.m[0][1] ||
               m[0][2] != other.m[0][2] ||
               m[0][3] != other.m[0][3] ||
               m[1][0] != other.m[1][0] ||
               m[1][1] != other.m[1][1] ||
               m[1][2] != other.m[1][2] ||
               m[1][3] != other.m[1][3] ||
               m[2][0] != other.m[2][0] ||
               m[2][1] != other.m[2][1] ||
               m[2][2] != other.m[2][2] ||
               m[2][3] != other.m[2][3] ||
               m[3][0] != other.m[3][0] ||
               m[3][1] != other.m[3][1] ||
               m[3][2] != other.m[3][2] ||
               m[3][3] != other.m[3][3];
    }+/

    /+ friend QMatrix4x4 operator+(const QMatrix4x4& m1, const QMatrix4x4& m2); +/
    /+ friend QMatrix4x4 operator-(const QMatrix4x4& m1, const QMatrix4x4& m2); +/
    /+ friend QMatrix4x4 operator*(const QMatrix4x4& m1, const QMatrix4x4& m2); +/
/+ #ifndef QT_NO_VECTOR3D
#if QT_DEPRECATED_SINCE(6, 1) +/
    version (QT_NO_VECTOR3D) {} else
    {
        /+ friend QVector3D operator*(const QMatrix4x4& matrix, const QVector3D& vector); +/
        /+ friend QVector3D operator*(const QVector3D& vector, const QMatrix4x4& matrix); +/
    }
/+ #endif
#endif
#ifndef QT_NO_VECTOR4D +/
    version (QT_NO_VECTOR4D) {} else
    {
        /+ friend QVector4D operator*(const QVector4D& vector, const QMatrix4x4& matrix); +/
        /+ friend QVector4D operator*(const QMatrix4x4& matrix, const QVector4D& vector); +/
    }
/+ #endif +/
    /+ friend QPoint operator*(const QPoint& point, const QMatrix4x4& matrix); +/
    /+ friend QPointF operator*(const QPointF& point, const QMatrix4x4& matrix); +/
    /+ friend QMatrix4x4 operator-(const QMatrix4x4& matrix); +/
/+ #if QT_DEPRECATED_SINCE(6, 1) +/
    /+ friend QPoint operator*(const QMatrix4x4& matrix, const QPoint& point); +/
    /+ friend QPointF operator*(const QMatrix4x4& matrix, const QPointF& point); +/
/+ #endif +/
    /+ friend QMatrix4x4 operator*(float factor, const QMatrix4x4& matrix); +/
    /+ friend QMatrix4x4 operator*(const QMatrix4x4& matrix, float factor); +/
    /+ friend Q_GUI_EXPORT QMatrix4x4 operator/(const QMatrix4x4& matrix, float divisor); +/

    /+ friend Q_GUI_EXPORT bool qFuzzyCompare(const QMatrix4x4& m1, const QMatrix4x4& m2); +/

    version (QT_NO_VECTOR3D) {} else
    {
        void scale(ref const(QVector3D) vector);
        void translate(ref const(QVector3D) vector);
        void rotate(float angle, ref const(QVector3D) vector);
    }
    void scale(float x, float y);
    void scale(float x, float y, float z);
    void scale(float factor);
    void translate(float x, float y);
    void translate(float x, float y, float z);
    void rotate(float angle, float x, float y, float z = 0.0f);
    static if (!defined!"QT_NO_QUATERNION")
    {
        void rotate(ref const(QQuaternion) quaternion);
    }

    void ortho(ref const(QRect) rect);
    void ortho(ref const(QRectF) rect);
    void ortho(float left, float right, float bottom, float top, float nearPlane, float farPlane);
    void frustum(float left, float right, float bottom, float top, float nearPlane, float farPlane);
    void perspective(float verticalAngle, float aspectRatio, float nearPlane, float farPlane);
    version (QT_NO_VECTOR3D) {} else
    {
        void lookAt(ref const(QVector3D) eye, ref const(QVector3D) center, ref const(QVector3D) up);
    }
    pragma(inline, true) void viewport(ref const(QRectF) rect)
    {
        viewport(float(rect.x()), float(rect.y()), float(rect.width()), float(rect.height()));
    }
    void viewport(float left, float bottom, float width, float height, float nearPlane = 0.0f, float farPlane = 1.0f);
    void flipCoordinates();

    void copyDataTo(float* values) const;

    QTransform toTransform() const;
    QTransform toTransform(float distanceToPlane) const;

    pragma(inline, true) QPoint map(ref const(QPoint) point) const
    {
        import qt.core.global;

        float xin; float yin;
        float x; float y; float w;
        xin = point.x();
        yin = point.y();
        if (flagBits == QMatrix4x4.Flag.Identity) {
            return point;
        } else if (flagBits.toInt() < QMatrix4x4.Flag.Rotation2D) {
            // Translation | Scale
            return QPoint(qRound(xin * m[0][0] + m[3][0]),
                          qRound(yin * m[1][1] + m[3][1]));
        } else if (flagBits.toInt() < QMatrix4x4.Flag.Perspective) {
            return QPoint(qRound(xin * m[0][0] + yin * m[1][0] + m[3][0]),
                          qRound(xin * m[0][1] + yin * m[1][1] + m[3][1]));
        } else {
            x = xin * m[0][0] +
                yin * m[1][0] +
                m[3][0];
            y = xin * m[0][1] +
                yin * m[1][1] +
                m[3][1];
            w = xin * m[0][3] +
                yin * m[1][3] +
                m[3][3];
            if (w == 1.0f)
                return QPoint(qRound(x), qRound(y));
            else
                return QPoint(qRound(x / w), qRound(y / w));
        }
    }
    pragma(inline, true) QPointF map(ref const(QPointF) point) const
    {
        import qt.core.global;

        qreal xin; qreal yin;
        qreal x; qreal y; qreal w;
        xin = point.x();
        yin = point.y();
        if (flagBits == QMatrix4x4.Flag.Identity) {
            return point;
        } else if (flagBits.toInt() < QMatrix4x4.Flag.Rotation2D) {
            // Translation | Scale
            return QPointF(xin * qreal(m[0][0]) + qreal(m[3][0]),
                           yin * qreal(m[1][1]) + qreal(m[3][1]));
        } else if (flagBits.toInt() < QMatrix4x4.Flag.Perspective) {
            return QPointF(xin * qreal(m[0][0]) + yin * qreal(m[1][0]) +
                           qreal(m[3][0]),
                           xin * qreal(m[0][1]) + yin * qreal(m[1][1]) +
                           qreal(m[3][1]));
        } else {
            x = xin * qreal(m[0][0]) +
                yin * qreal(m[1][0]) +
                qreal(m[3][0]);
            y = xin * qreal(m[0][1]) +
                yin * qreal(m[1][1]) +
                qreal(m[3][1]);
            w = xin * qreal(m[0][3]) +
                yin * qreal(m[1][3]) +
                qreal(m[3][3]);
            if (w == 1.0) {
                return QPointF(qreal(x), qreal(y));
            } else {
                return QPointF(qreal(x / w), qreal(y / w));
            }
        }
    }
/+ #ifndef QT_NO_VECTOR3D +/
    version (QT_NO_VECTOR3D) {} else
    {
        pragma(inline, true) QVector3D map(ref const(QVector3D) point) const
        {
            float x; float y; float z; float w;
            if (flagBits == QMatrix4x4.Flag.Identity) {
                return point;
            } else if (flagBits.toInt() < QMatrix4x4.Flag.Rotation2D) {
                // Translation | Scale
                return QVector3D(point.x() * m[0][0] + m[3][0],
                                 point.y() * m[1][1] + m[3][1],
                                 point.z() * m[2][2] + m[3][2]);
            } else if (flagBits.toInt() < QMatrix4x4.Flag.Rotation) {
                // Translation | Scale | Rotation2D
                return QVector3D(point.x() * m[0][0] + point.y() * m[1][0] + m[3][0],
                                 point.x() * m[0][1] + point.y() * m[1][1] + m[3][1],
                                 point.z() * m[2][2] + m[3][2]);
            } else {
                x = point.x() * m[0][0] +
                    point.y() * m[1][0] +
                    point.z() * m[2][0] +
                    m[3][0];
                y = point.x() * m[0][1] +
                    point.y() * m[1][1] +
                    point.z() * m[2][1] +
                    m[3][1];
                z = point.x() * m[0][2] +
                    point.y() * m[1][2] +
                    point.z() * m[2][2] +
                    m[3][2];
                w = point.x() * m[0][3] +
                    point.y() * m[1][3] +
                    point.z() * m[2][3] +
                    m[3][3];
                if (w == 1.0f)
                    return QVector3D(x, y, z);
                else
                    return QVector3D(x / w, y / w, z / w);
            }
        }
        pragma(inline, true) QVector3D mapVector(ref const(QVector3D) vector) const
        {
            if (flagBits.toInt() < Flag.Scale) {
                // Translation
                return vector;
            } else if (flagBits.toInt() < Flag.Rotation2D) {
                // Translation | Scale
                return QVector3D(vector.x() * m[0][0],
                                 vector.y() * m[1][1],
                                 vector.z() * m[2][2]);
            } else {
                return QVector3D(vector.x() * m[0][0] +
                                 vector.y() * m[1][0] +
                                 vector.z() * m[2][0],
                                 vector.x() * m[0][1] +
                                 vector.y() * m[1][1] +
                                 vector.z() * m[2][1],
                                 vector.x() * m[0][2] +
                                 vector.y() * m[1][2] +
                                 vector.z() * m[2][2]);
            }
        }
    }
/+ #endif
#ifndef QT_NO_VECTOR4D +/
    version (QT_NO_VECTOR4D) {} else
    {
        pragma(inline, true) QVector4D map(ref const(QVector4D) point) const
        {
            return this * point;
        }
    }
/+ #endif +/
    QRect mapRect(ref const(QRect) rect) const;
    QRectF mapRect(ref const(QRectF) rect) const;

    /+ template <int N, int M> +/
    QGenericMatrix!(N, M, float) toGenericMatrix(int N,int M)() const
    {
        QGenericMatrix!(N, M, float) result;
        float* values = cast(float*) (result.data());
        for (int matrixCol = 0; matrixCol < N; ++matrixCol) {
            for (int matrixRow = 0; matrixRow < M; ++matrixRow) {
                if (matrixCol < 4 && matrixRow < 4)
                    values[matrixCol * M + matrixRow] = m[matrixCol][matrixRow];
                else if (matrixCol == matrixRow)
                    values[matrixCol * M + matrixRow] = 1.0f;
                else
                    values[matrixCol * M + matrixRow] = 0.0f;
            }
        }
        return result;
    }

    pragma(inline, true) float* data()
    {
        // We have to assume that the caller will modify the matrix elements,
        // so we flip it over to "General" mode.
        flagBits = Flag.General;
        return *m.ptr.ptr;
    }
    pragma(inline, true) const(float)* data() const { return *m.ptr.ptr; }
    pragma(inline, true) const(float)* constData() const { return *m.ptr.ptr; }

    void optimize();

    /+auto opCast(T : QVariant)() const;+/

/+ #ifndef QT_NO_DEBUG_STREAM
    friend Q_GUI_EXPORT QDebug operator<<(QDebug dbg, const QMatrix4x4 &m);
#endif +/

    void projectedRotate(float angle, float x, float y, float z);

    // When matrices are multiplied, the flag bits are or-ed together.
    // Note that the ordering of the bit values matters. (ident < t < s < r2d < r < p)
    enum Flag {
        Identity        = 0x0000, // Identity matrix
        Translation     = 0x0001, // Contains a translation
        Scale           = 0x0002, // Contains a scale
        Rotation2D      = 0x0004, // Contains a rotation about the Z axis
        Rotation        = 0x0008, // Contains an arbitrary rotation
        Perspective     = 0x0010, // Last row is different from (0, 0, 0, 1)
        General         = 0x001f  // General matrix, unknown contents
    }
    /+ Q_DECLARE_FLAGS(Flags, Flag) +/
alias Flags = QFlags!(Flag);
    Flags flags() const { return flagBits; }

private:
    float[4][4] m;          // Column-major order to match OpenGL.
    Flags flagBits;

    QMatrix4x4 orthonormalInverse() const;

    /+ friend class ::tst_QMatrixNxN; +/ // for access to flagBits
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}
/+pragma(inline, true) QFlags!(QMatrix4x4.Flags.enum_type) operator |(QMatrix4x4.Flags.enum_type f1, QMatrix4x4.Flags.enum_type f2)nothrow{return QFlags!(QMatrix4x4.Flags.enum_type)(f1)|f2;}+/
/+pragma(inline, true) QFlags!(QMatrix4x4.Flags.enum_type) operator |(QMatrix4x4.Flags.enum_type f1, QFlags!(QMatrix4x4.Flags.enum_type) f2)nothrow{return f2|f1;}+/
/+pragma(inline, true) QFlags!(QMatrix4x4.Flags.enum_type) operator &(QMatrix4x4.Flags.enum_type f1, QMatrix4x4.Flags.enum_type f2)nothrow{return QFlags!(QMatrix4x4.Flags.enum_type)(f1)&f2;}+/
/+pragma(inline, true) QFlags!(QMatrix4x4.Flags.enum_type) operator &(QMatrix4x4.Flags.enum_type f1, QFlags!(QMatrix4x4.Flags.enum_type) f2)nothrow{return f2&f1;}+/
/+pragma(inline, true) QFlags!(QMatrix4x4.Flags.enum_type) operator ^(QMatrix4x4.Flags.enum_type f1, QMatrix4x4.Flags.enum_type f2)nothrow{return QFlags!(QMatrix4x4.Flags.enum_type)(f1)^f2;}+/
/+pragma(inline, true) QFlags!(QMatrix4x4.Flags.enum_type) operator ^(QMatrix4x4.Flags.enum_type f1, QFlags!(QMatrix4x4.Flags.enum_type) f2)nothrow{return f2^f1;}+/
/+pragma(inline, true) void operator +(QMatrix4x4.Flags.enum_type f1, QMatrix4x4.Flags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QMatrix4x4.Flags.enum_type f1, QFlags!(QMatrix4x4.Flags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QFlags!(QMatrix4x4.Flags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(QMatrix4x4.Flags.enum_type f1, QMatrix4x4.Flags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QMatrix4x4.Flags.enum_type f1, QFlags!(QMatrix4x4.Flags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QFlags!(QMatrix4x4.Flags.enum_type) f2)nothrow;+/
/+pragma(inline, true) void operator +(int f1, QMatrix4x4.Flags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator +(QMatrix4x4.Flags.enum_type f1, int f2)nothrow;+/
/+pragma(inline, true) void operator -(int f1, QMatrix4x4.Flags.enum_type f2)nothrow;+/
/+pragma(inline, true) void operator -(QMatrix4x4.Flags.enum_type f1, int f2)nothrow;+/
static if (defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QMatrix4x4.Flags operator ~(QMatrix4x4.Flags.enum_type e)nothrow{return~QMatrix4x4.Flags(e);}+/
/+pragma(inline, true) void operator |(QMatrix4x4.Flags.enum_type f1, int f2)nothrow;+/
}
static if (!defined!"QT_TYPESAFE_FLAGS")
{
/+pragma(inline, true) QIncompatibleFlag operator |(QMatrix4x4.Flags.enum_type f1, int f2)nothrow{return QIncompatibleFlag(int(f1)|f2);}+/
}

/+ Q_DECLARE_OPERATORS_FOR_FLAGS(QMatrix4x4::Flags)
QT_WARNING_PUSH
QT_WARNING_DISABLE_FLOAT_COMPARE

Q_DECLARE_TYPEINFO(QMatrix4x4, Q_PRIMITIVE_TYPE);

#ifndef QT_NO_VECTOR4D
#endif +/

/+/+ Q_GUI_EXPORT +/ QMatrix4x4 operator /(ref const(QMatrix4x4) matrix, float divisor);+/

/+pragma(inline, true) QMatrix4x4 operator +(ref const(QMatrix4x4) m1, ref const(QMatrix4x4) m2)
{
    static if (#configValue!"merged")
    {
    auto m = QMatrix4x4(/+ Qt:: +/qt.core.namespace.Uninitialized);
    }
static if (#configValue!"merged")
{
QMatrix4x4 m__1(qt.core.namespace.Initialization);
}
    m__1.m[0][0] = m1.m[0][0] + m2.m[0][0];
    m__1.m[0][1] = m1.m[0][1] + m2.m[0][1];
    m__1.m[0][2] = m1.m[0][2] + m2.m[0][2];
    m__1.m[0][3] = m1.m[0][3] + m2.m[0][3];
    m__1.m[1][0] = m1.m[1][0] + m2.m[1][0];
    m__1.m[1][1] = m1.m[1][1] + m2.m[1][1];
    m__1.m[1][2] = m1.m[1][2] + m2.m[1][2];
    m__1.m[1][3] = m1.m[1][3] + m2.m[1][3];
    m__1.m[2][0] = m1.m[2][0] + m2.m[2][0];
    m__1.m[2][1] = m1.m[2][1] + m2.m[2][1];
    m__1.m[2][2] = m1.m[2][2] + m2.m[2][2];
    m__1.m[2][3] = m1.m[2][3] + m2.m[2][3];
    m__1.m[3][0] = m1.m[3][0] + m2.m[3][0];
    m__1.m[3][1] = m1.m[3][1] + m2.m[3][1];
    m__1.m[3][2] = m1.m[3][2] + m2.m[3][2];
    m__1.m[3][3] = m1.m[3][3] + m2.m[3][3];
    return cast(QMatrix4x4) (m__1);
}+/

/+pragma(inline, true) QMatrix4x4 operator -(ref const(QMatrix4x4) m1, ref const(QMatrix4x4) m2)
{
    static if (#configValue!"merged")
    {
    auto m = QMatrix4x4(/+ Qt:: +/qt.core.namespace.Uninitialized);
    }
static if (#configValue!"merged")
{
QMatrix4x4 m__1(qt.core.namespace.Initialization);
}
    m__1.m[0][0] = m1.m[0][0] - m2.m[0][0];
    m__1.m[0][1] = m1.m[0][1] - m2.m[0][1];
    m__1.m[0][2] = m1.m[0][2] - m2.m[0][2];
    m__1.m[0][3] = m1.m[0][3] - m2.m[0][3];
    m__1.m[1][0] = m1.m[1][0] - m2.m[1][0];
    m__1.m[1][1] = m1.m[1][1] - m2.m[1][1];
    m__1.m[1][2] = m1.m[1][2] - m2.m[1][2];
    m__1.m[1][3] = m1.m[1][3] - m2.m[1][3];
    m__1.m[2][0] = m1.m[2][0] - m2.m[2][0];
    m__1.m[2][1] = m1.m[2][1] - m2.m[2][1];
    m__1.m[2][2] = m1.m[2][2] - m2.m[2][2];
    m__1.m[2][3] = m1.m[2][3] - m2.m[2][3];
    m__1.m[3][0] = m1.m[3][0] - m2.m[3][0];
    m__1.m[3][1] = m1.m[3][1] - m2.m[3][1];
    m__1.m[3][2] = m1.m[3][2] - m2.m[3][2];
    m__1.m[3][3] = m1.m[3][3] - m2.m[3][3];
    return cast(QMatrix4x4) (m__1);
}+/

/+pragma(inline, true) QMatrix4x4 operator *(ref const(QMatrix4x4) m1, ref const(QMatrix4x4) m2)
{
    QMatrix4x4.Flags flagBits = m1.flagBits | m2.flagBits;
    if (flagBits.toInt() < QMatrix4x4.Flag.Rotation2D) {
        QMatrix4x4 m = m1;
        m.m[3][0] += m.m[0][0] * m2.m[3][0];
        m.m[3][1] += m.m[1][1] * m2.m[3][1];
        m.m[3][2] += m.m[2][2] * m2.m[3][2];

        m.m[0][0] *= m2.m[0][0];
        m.m[1][1] *= m2.m[1][1];
        m.m[2][2] *= m2.m[2][2];
        m.flagBits = flagBits;
        return m;
    }

    static if (#configValue!"merged")
    {
    auto m = QMatrix4x4(/+ Qt:: +/qt.core.namespace.Uninitialized);
    }
static if (#configValue!"merged")
{
QMatrix4x4 m__1(qt.core.namespace.Initialization);
}
    m__1.m[0][0] = m1.m[0][0] * m2.m[0][0]
              + m1.m[1][0] * m2.m[0][1]
              + m1.m[2][0] * m2.m[0][2]
              + m1.m[3][0] * m2.m[0][3];
    m__1.m[0][1] = m1.m[0][1] * m2.m[0][0]
              + m1.m[1][1] * m2.m[0][1]
              + m1.m[2][1] * m2.m[0][2]
              + m1.m[3][1] * m2.m[0][3];
    m__1.m[0][2] = m1.m[0][2] * m2.m[0][0]
              + m1.m[1][2] * m2.m[0][1]
              + m1.m[2][2] * m2.m[0][2]
              + m1.m[3][2] * m2.m[0][3];
    m__1.m[0][3] = m1.m[0][3] * m2.m[0][0]
              + m1.m[1][3] * m2.m[0][1]
              + m1.m[2][3] * m2.m[0][2]
              + m1.m[3][3] * m2.m[0][3];

    m__1.m[1][0] = m1.m[0][0] * m2.m[1][0]
              + m1.m[1][0] * m2.m[1][1]
              + m1.m[2][0] * m2.m[1][2]
              + m1.m[3][0] * m2.m[1][3];
    m__1.m[1][1] = m1.m[0][1] * m2.m[1][0]
              + m1.m[1][1] * m2.m[1][1]
              + m1.m[2][1] * m2.m[1][2]
              + m1.m[3][1] * m2.m[1][3];
    m__1.m[1][2] = m1.m[0][2] * m2.m[1][0]
              + m1.m[1][2] * m2.m[1][1]
              + m1.m[2][2] * m2.m[1][2]
              + m1.m[3][2] * m2.m[1][3];
    m__1.m[1][3] = m1.m[0][3] * m2.m[1][0]
              + m1.m[1][3] * m2.m[1][1]
              + m1.m[2][3] * m2.m[1][2]
              + m1.m[3][3] * m2.m[1][3];

    m__1.m[2][0] = m1.m[0][0] * m2.m[2][0]
              + m1.m[1][0] * m2.m[2][1]
              + m1.m[2][0] * m2.m[2][2]
              + m1.m[3][0] * m2.m[2][3];
    m__1.m[2][1] = m1.m[0][1] * m2.m[2][0]
              + m1.m[1][1] * m2.m[2][1]
              + m1.m[2][1] * m2.m[2][2]
              + m1.m[3][1] * m2.m[2][3];
    m__1.m[2][2] = m1.m[0][2] * m2.m[2][0]
              + m1.m[1][2] * m2.m[2][1]
              + m1.m[2][2] * m2.m[2][2]
              + m1.m[3][2] * m2.m[2][3];
    m__1.m[2][3] = m1.m[0][3] * m2.m[2][0]
              + m1.m[1][3] * m2.m[2][1]
              + m1.m[2][3] * m2.m[2][2]
              + m1.m[3][3] * m2.m[2][3];

    m__1.m[3][0] = m1.m[0][0] * m2.m[3][0]
              + m1.m[1][0] * m2.m[3][1]
              + m1.m[2][0] * m2.m[3][2]
              + m1.m[3][0] * m2.m[3][3];
    m__1.m[3][1] = m1.m[0][1] * m2.m[3][0]
              + m1.m[1][1] * m2.m[3][1]
              + m1.m[2][1] * m2.m[3][2]
              + m1.m[3][1] * m2.m[3][3];
    m__1.m[3][2] = m1.m[0][2] * m2.m[3][0]
              + m1.m[1][2] * m2.m[3][1]
              + m1.m[2][2] * m2.m[3][2]
              + m1.m[3][2] * m2.m[3][3];
    m__1.m[3][3] = m1.m[0][3] * m2.m[3][0]
              + m1.m[1][3] * m2.m[3][1]
              + m1.m[2][3] * m2.m[3][2]
              + m1.m[3][3] * m2.m[3][3];
    m__1.flagBits = flagBits;
    return cast(QMatrix4x4) (m__1);
}+/

version (QT_NO_VECTOR3D) {} else
{

/+ #if QT_DEPRECATED_SINCE(6, 1) +/

/+/+ QT_DEPRECATED_VERSION_X_6_1("Extend the QVector3D to a QVector4D with 1.0 as the w coordinate before multiplying") +/
pragma(inline, true) QVector3D operator *(ref const(QVector3D) vector, ref const(QMatrix4x4) matrix)
{
    float x; float y; float z; float w;
    x = vector.x() * matrix.m[0][0] +
        vector.y() * matrix.m[0][1] +
        vector.z() * matrix.m[0][2] +
        matrix.m[0][3];
    y = vector.x() * matrix.m[1][0] +
        vector.y() * matrix.m[1][1] +
        vector.z() * matrix.m[1][2] +
        matrix.m[1][3];
    z = vector.x() * matrix.m[2][0] +
        vector.y() * matrix.m[2][1] +
        vector.z() * matrix.m[2][2] +
        matrix.m[2][3];
    w = vector.x() * matrix.m[3][0] +
        vector.y() * matrix.m[3][1] +
        vector.z() * matrix.m[3][2] +
        matrix.m[3][3];
    if (w == 1.0f)
        return QVector3D(x, y, z);
    else
        return QVector3D(x / w, y / w, z / w);
}+/

/+/+ QT_DEPRECATED_VERSION_X_6_1("Use matrix.map(vector) instead") +/
pragma(inline, true) QVector3D operator *(ref const(QMatrix4x4) matrix, ref const(QVector3D) vector)
{
    return matrix.map(vector);
}+/

/+ #endif +/

}

version (QT_NO_VECTOR4D) {} else
{

/+pragma(inline, true) QVector4D operator *(ref const(QVector4D) vector, ref const(QMatrix4x4) matrix)
{
    float x; float y; float z; float w;
    x = vector.x() * matrix.m[0][0] +
        vector.y() * matrix.m[0][1] +
        vector.z() * matrix.m[0][2] +
        vector.w() * matrix.m[0][3];
    y = vector.x() * matrix.m[1][0] +
        vector.y() * matrix.m[1][1] +
        vector.z() * matrix.m[1][2] +
        vector.w() * matrix.m[1][3];
    z = vector.x() * matrix.m[2][0] +
        vector.y() * matrix.m[2][1] +
        vector.z() * matrix.m[2][2] +
        vector.w() * matrix.m[2][3];
    w = vector.x() * matrix.m[3][0] +
        vector.y() * matrix.m[3][1] +
        vector.z() * matrix.m[3][2] +
        vector.w() * matrix.m[3][3];
    return QVector4D(x, y, z, w);
}+/

/+pragma(inline, true) QVector4D operator *(ref const(QMatrix4x4) matrix, ref const(QVector4D) vector)
{
    float x; float y; float z; float w;
    x = vector.x() * matrix.m[0][0] +
        vector.y() * matrix.m[1][0] +
        vector.z() * matrix.m[2][0] +
        vector.w() * matrix.m[3][0];
    y = vector.x() * matrix.m[0][1] +
        vector.y() * matrix.m[1][1] +
        vector.z() * matrix.m[2][1] +
        vector.w() * matrix.m[3][1];
    z = vector.x() * matrix.m[0][2] +
        vector.y() * matrix.m[1][2] +
        vector.z() * matrix.m[2][2] +
        vector.w() * matrix.m[3][2];
    w = vector.x() * matrix.m[0][3] +
        vector.y() * matrix.m[1][3] +
        vector.z() * matrix.m[2][3] +
        vector.w() * matrix.m[3][3];
    return QVector4D(x, y, z, w);
}+/

}

/+pragma(inline, true) QPoint operator *(ref const(QPoint) point, ref const(QMatrix4x4) matrix)
{
    import qt.core.global;

    float xin; float yin;
    float x; float y; float w;
    xin = point.x();
    yin = point.y();
    x = xin * matrix.m[0][0] +
        yin * matrix.m[0][1] +
        matrix.m[0][3];
    y = xin * matrix.m[1][0] +
        yin * matrix.m[1][1] +
        matrix.m[1][3];
    w = xin * matrix.m[3][0] +
        yin * matrix.m[3][1] +
        matrix.m[3][3];
    if (w == 1.0f)
        return QPoint(qRound(x), qRound(y));
    else
        return QPoint(qRound(x / w), qRound(y / w));
}+/

/+pragma(inline, true) QPointF operator *(ref const(QPointF) point, ref const(QMatrix4x4) matrix)
{
    import qt.core.global;

    float xin; float yin;
    float x; float y; float w;
    xin = float(point.x());
    yin = float(point.y());
    x = xin * matrix.m[0][0] +
        yin * matrix.m[0][1] +
        matrix.m[0][3];
    y = xin * matrix.m[1][0] +
        yin * matrix.m[1][1] +
        matrix.m[1][3];
    w = xin * matrix.m[3][0] +
        yin * matrix.m[3][1] +
        matrix.m[3][3];
    if (w == 1.0f) {
        return QPointF(qreal(x), qreal(y));
    } else {
        return QPointF(qreal(x / w), qreal(y / w));
    }
}+/

/+ #if QT_DEPRECATED_SINCE(6, 1) +/

/+/+ QT_DEPRECATED_VERSION_X_6_1("Use matrix.map(point) instead") +/
pragma(inline, true) QPoint operator *(ref const(QMatrix4x4) matrix, ref const(QPoint) point)
{
    return matrix.map(point);
}+/

/+/+ QT_DEPRECATED_VERSION_X_6_1("Use matrix.map(point) instead") +/
pragma(inline, true) QPointF operator *(ref const(QMatrix4x4) matrix, ref const(QPointF) point)
{
    return matrix.map(point);
}+/

/+ #endif +/

/+pragma(inline, true) QMatrix4x4 operator -(ref const(QMatrix4x4) matrix)
{
    static if (#configValue!"merged")
    {
    auto m = QMatrix4x4(/+ Qt:: +/qt.core.namespace.Uninitialized);
    }
static if (#configValue!"merged")
{
QMatrix4x4 m__1(qt.core.namespace.Initialization);
}
    m__1.m[0][0] = -matrix.m[0][0];
    m__1.m[0][1] = -matrix.m[0][1];
    m__1.m[0][2] = -matrix.m[0][2];
    m__1.m[0][3] = -matrix.m[0][3];
    m__1.m[1][0] = -matrix.m[1][0];
    m__1.m[1][1] = -matrix.m[1][1];
    m__1.m[1][2] = -matrix.m[1][2];
    m__1.m[1][3] = -matrix.m[1][3];
    m__1.m[2][0] = -matrix.m[2][0];
    m__1.m[2][1] = -matrix.m[2][1];
    m__1.m[2][2] = -matrix.m[2][2];
    m__1.m[2][3] = -matrix.m[2][3];
    m__1.m[3][0] = -matrix.m[3][0];
    m__1.m[3][1] = -matrix.m[3][1];
    m__1.m[3][2] = -matrix.m[3][2];
    m__1.m[3][3] = -matrix.m[3][3];
    return cast(QMatrix4x4) (m__1);
}+/

/+pragma(inline, true) QMatrix4x4 operator *(float factor, ref const(QMatrix4x4) matrix)
{
    static if (#configValue!"merged")
    {
    auto m = QMatrix4x4(/+ Qt:: +/qt.core.namespace.Uninitialized);
    }
static if (#configValue!"merged")
{
QMatrix4x4 m__1(qt.core.namespace.Initialization);
}
    m__1.m[0][0] = matrix.m[0][0] * factor;
    m__1.m[0][1] = matrix.m[0][1] * factor;
    m__1.m[0][2] = matrix.m[0][2] * factor;
    m__1.m[0][3] = matrix.m[0][3] * factor;
    m__1.m[1][0] = matrix.m[1][0] * factor;
    m__1.m[1][1] = matrix.m[1][1] * factor;
    m__1.m[1][2] = matrix.m[1][2] * factor;
    m__1.m[1][3] = matrix.m[1][3] * factor;
    m__1.m[2][0] = matrix.m[2][0] * factor;
    m__1.m[2][1] = matrix.m[2][1] * factor;
    m__1.m[2][2] = matrix.m[2][2] * factor;
    m__1.m[2][3] = matrix.m[2][3] * factor;
    m__1.m[3][0] = matrix.m[3][0] * factor;
    m__1.m[3][1] = matrix.m[3][1] * factor;
    m__1.m[3][2] = matrix.m[3][2] * factor;
    m__1.m[3][3] = matrix.m[3][3] * factor;
    return cast(QMatrix4x4) (m__1);
}+/

/+pragma(inline, true) QMatrix4x4 operator *(ref const(QMatrix4x4) matrix, float factor)
{
    static if (#configValue!"merged")
    {
    auto m = QMatrix4x4(/+ Qt:: +/qt.core.namespace.Uninitialized);
    }
static if (#configValue!"merged")
{
QMatrix4x4 m__1(qt.core.namespace.Initialization);
}
    m__1.m[0][0] = matrix.m[0][0] * factor;
    m__1.m[0][1] = matrix.m[0][1] * factor;
    m__1.m[0][2] = matrix.m[0][2] * factor;
    m__1.m[0][3] = matrix.m[0][3] * factor;
    m__1.m[1][0] = matrix.m[1][0] * factor;
    m__1.m[1][1] = matrix.m[1][1] * factor;
    m__1.m[1][2] = matrix.m[1][2] * factor;
    m__1.m[1][3] = matrix.m[1][3] * factor;
    m__1.m[2][0] = matrix.m[2][0] * factor;
    m__1.m[2][1] = matrix.m[2][1] * factor;
    m__1.m[2][2] = matrix.m[2][2] * factor;
    m__1.m[2][3] = matrix.m[2][3] * factor;
    m__1.m[3][0] = matrix.m[3][0] * factor;
    m__1.m[3][1] = matrix.m[3][1] * factor;
    m__1.m[3][2] = matrix.m[3][2] * factor;
    m__1.m[3][3] = matrix.m[3][3] * factor;
    return cast(QMatrix4x4) (m__1);
}+/

/+ #ifndef QT_NO_VECTOR3D

#endif

#ifndef QT_NO_VECTOR4D

#endif

QT_WARNING_POP

#ifndef QT_NO_DEBUG_STREAM
Q_GUI_EXPORT QDebug operator<<(QDebug dbg, const QMatrix4x4 &m);
#endif

#ifndef QT_NO_DATASTREAM
Q_GUI_EXPORT QDataStream &operator<<(QDataStream &, const QMatrix4x4 &);
Q_GUI_EXPORT QDataStream &operator>>(QDataStream &, QMatrix4x4 &);
#endif +/

}

