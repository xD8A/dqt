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
module qt.gui.quaternion;
extern(C++):

import qt.config;
import qt.helpers;
static if (!defined!"QT_NO_QUATERNION" && !versionIsSet!("QT_NO_VECTOR4D"))
    import qt.gui.vector4d;
static if (!defined!"QT_NO_QUATERNION")
{
    import qt.core.namespace;
    import qt.core.typeinfo;
    import qt.core.variant;
    import qt.gui.genericmatrix;
    import qt.gui.vector3d;
}

static if (!defined!"QT_NO_QUATERNION")
{


/// Binding for C++ class [QQuaternion](https://doc.qt.io/qt-6/qquaternion.html).
@Q_PRIMITIVE_TYPE extern(C++, class) struct /+ Q_GUI_EXPORT +/ QQuaternion
{
public:
    @disable this();
    /+pragma(inline, true) this()
    {
        this.wp = 1.0f;
        this.xp = 0.0f;
        this.yp = 0.0f;
        this.zp = 0.0f;
    }+/
    /+ explicit +/this(/+ Qt:: +/qt.core.namespace.Initialization) {}
    pragma(inline, true) this(float aScalar, float xpos, float ypos, float zpos)
    {
        this.wp = aScalar;
        this.xp = xpos;
        this.yp = ypos;
        this.zp = zpos;
    }
/+ #ifndef QT_NO_VECTOR3D +/
    version (QT_NO_VECTOR3D) {} else
    {
        pragma(inline, true) this(float aScalar, ref const(QVector3D) aVector)
        {
            this.wp = aScalar;
            this.xp = aVector.x();
            this.yp = aVector.y();
            this.zp = aVector.z();
        }
    }
/+ #endif
#ifndef QT_NO_VECTOR4D +/
    version (QT_NO_VECTOR4D) {} else
    {
        /+ explicit +/pragma(inline, true) this(ref const(QVector4D) aVector)
        {
            this.wp = aVector.w();
            this.xp = aVector.x();
            this.yp = aVector.y();
            this.zp = aVector.z();
        }
    }
/+ #endif +/

    pragma(inline, true) bool isNull() const
    {
        return wp == 0.0f && xp == 0.0f && yp == 0.0f && zp == 0.0f;
    }
    pragma(inline, true) bool isIdentity() const
    {
        return wp == 1.0f && xp == 0.0f && yp == 0.0f && zp == 0.0f;
    }

    version (QT_NO_VECTOR3D) {} else
    {
        pragma(inline, true) QVector3D vector() const
        {
            return QVector3D(xp, yp, zp);
        }
        pragma(inline, true) void setVector(ref const(QVector3D) aVector)
        {
            xp = aVector.x();
            yp = aVector.y();
            zp = aVector.z();
        }
    }
    pragma(inline, true) void setVector(float aX, float aY, float aZ)
    {
        xp = aX;
        yp = aY;
        zp = aZ;
    }

    pragma(inline, true) float x() const { return xp; }
    pragma(inline, true) float y() const { return yp; }
    pragma(inline, true) float z() const { return zp; }
    pragma(inline, true) float scalar() const { return wp; }

    pragma(inline, true) void setX(float aX) { xp = aX; }
    pragma(inline, true) void setY(float aY) { yp = aY; }
    pragma(inline, true) void setZ(float aZ) { zp = aZ; }
    pragma(inline, true) void setScalar(float aScalar) { wp = aScalar; }

    pragma(inline, true) static float dotProduct(ref const(QQuaternion) q1, ref const(QQuaternion) q2)
    {
        return q1.wp * q2.wp + q1.xp * q2.xp + q1.yp * q2.yp + q1.zp * q2.zp;
    }

    float length() const;
    float lengthSquared() const;

    /+ [[nodiscard]] +/ QQuaternion normalized() const;
    void normalize();

    pragma(inline, true) QQuaternion inverted() const
    {
        import qt.core.global;

        // Need some extra precision if the length is very small.
        double len = double(wp) * double(wp) +
                     double(xp) * double(xp) +
                     double(yp) * double(yp) +
                     double(zp) * double(zp);
        if (!qFuzzyIsNull(len))
            return QQuaternion(float(double(wp) / len), float(double(-xp) / len),
                               float(double(-yp) / len), float(double(-zp) / len));
        return QQuaternion(0.0f, 0.0f, 0.0f, 0.0f);
    }

    /+ [[nodiscard]] +/ pragma(inline, true) QQuaternion conjugated() const
    {
        return QQuaternion(wp, -xp, -yp, -zp);
    }

    QVector3D rotatedVector(ref const(QVector3D) vector) const;

    pragma(inline, true) ref QQuaternion opOpAssign(string op)(ref const(QQuaternion) quaternion) if (op == "+")
    {
        wp += quaternion.wp;
        xp += quaternion.xp;
        yp += quaternion.yp;
        zp += quaternion.zp;
        return this;
    }
    pragma(inline, true) ref QQuaternion opOpAssign(string op)(ref const(QQuaternion) quaternion) if (op == "-")
    {
        wp -= quaternion.wp;
        xp -= quaternion.xp;
        yp -= quaternion.yp;
        zp -= quaternion.zp;
        return this;
    }
    pragma(inline, true) ref QQuaternion opOpAssign(string op)(float factor) if (op == "*")
    {
        wp *= factor;
        xp *= factor;
        yp *= factor;
        zp *= factor;
        return this;
    }
    pragma(inline, true) ref QQuaternion opOpAssign(string op)(ref const(QQuaternion) quaternion) if (op == "*")
    {
        this = this * quaternion;
        return this;
    }
    pragma(inline, true) ref QQuaternion opOpAssign(string op)(float divisor) if (op == "/")
    {
        wp /= divisor;
        xp /= divisor;
        yp /= divisor;
        zp /= divisor;
        return this;
    }

/+ QT_WARNING_PUSH
QT_WARNING_DISABLE_FLOAT_COMPARE +/
    /+ friend inline bool operator==(const QQuaternion &q1, const QQuaternion &q2) noexcept
    {
        return q1.wp == q2.wp && q1.xp == q2.xp && q1.yp == q2.yp && q1.zp == q2.zp;
    } +/
    /+ friend inline bool operator!=(const QQuaternion &q1, const QQuaternion &q2) noexcept
    {
        return !(q1 == q2);
    } +/
/+ QT_WARNING_POP +/

    /+ friend inline const QQuaternion operator+(const QQuaternion &q1, const QQuaternion &q2); +/
    /+ friend inline const QQuaternion operator-(const QQuaternion &q1, const QQuaternion &q2); +/
    /+ friend inline const QQuaternion operator*(float factor, const QQuaternion &quaternion); +/
    /+ friend inline const QQuaternion operator*(const QQuaternion &quaternion, float factor); +/
    /+ friend inline const QQuaternion operator*(const QQuaternion &q1, const QQuaternion& q2); +/
    /+ friend inline const QQuaternion operator-(const QQuaternion &quaternion); +/
    /+ friend inline const QQuaternion operator/(const QQuaternion &quaternion, float divisor); +/

    /+ friend inline bool qFuzzyCompare(const QQuaternion& q1, const QQuaternion& q2); +/

    version (QT_NO_VECTOR4D) {} else
    {
        pragma(inline, true) QVector4D toVector4D() const
        {
            return QVector4D(xp, yp, zp, wp);
        }
    }

    /+auto opCast(T : QVariant)() const;+/

    version (QT_NO_VECTOR3D) {} else
    {
        pragma(inline, true) void getAxisAndAngle(QVector3D* axis, float* angle) const
        {
            float aX; float aY; float aZ;
            getAxisAndAngle(&aX, &aY, &aZ, angle);
            *axis = QVector3D(aX, aY, aZ);
        }
        static QQuaternion fromAxisAndAngle(ref const(QVector3D) axis, float angle);
    }
    void getAxisAndAngle(float* x, float* y, float* z, float* angle) const;
    static QQuaternion fromAxisAndAngle
                (float x, float y, float z, float angle);

    version (QT_NO_VECTOR3D) {} else
    {
        pragma(inline, true) QVector3D toEulerAngles() const
        {
            float pitch; float yaw; float roll;
            getEulerAngles(&pitch, &yaw, &roll);
            return QVector3D(pitch, yaw, roll);
        }
        pragma(inline, true) static QQuaternion fromEulerAngles(ref const(QVector3D) eulerAngles)
        {
            return QQuaternion.fromEulerAngles(eulerAngles.x(), eulerAngles.y(), eulerAngles.z());
        }
    }
    void getEulerAngles(float* pitch, float* yaw, float* roll) const;
    static QQuaternion fromEulerAngles(float pitch, float yaw, float roll);

    QMatrix3x3 toRotationMatrix() const;
    static QQuaternion fromRotationMatrix(ref const(QMatrix3x3) rot3x3);

    version (QT_NO_VECTOR3D) {} else
    {
        void getAxes(QVector3D* xAxis, QVector3D* yAxis, QVector3D* zAxis) const;
        static QQuaternion fromAxes(ref const(QVector3D) xAxis, ref const(QVector3D) yAxis, ref const(QVector3D) zAxis);

        static QQuaternion fromDirection(ref const(QVector3D) direction, ref const(QVector3D) up);

        static QQuaternion rotationTo(ref const(QVector3D) from, ref const(QVector3D) to);
    }

    static QQuaternion slerp
            (ref const(QQuaternion) q1, ref const(QQuaternion) q2, float t);
    static QQuaternion nlerp
            (ref const(QQuaternion) q1, ref const(QQuaternion) q2, float t);

private:
    float wp = 1.0f; float xp = 0.0f; float yp = 0.0f; float zp = 0.0f;
    mixin(CREATE_CONVENIENCE_WRAPPERS);
}

/+ Q_DECLARE_TYPEINFO(QQuaternion, Q_PRIMITIVE_TYPE);

QT_WARNING_PUSH
QT_WARNING_DISABLE_FLOAT_COMPARE
QT_WARNING_POP +/

/+pragma(inline, true) const(QQuaternion) operator *(ref const(QQuaternion) q1, ref const(QQuaternion) q2)
{
    float yy = (q1.wp - q1.yp) * (q2.wp + q2.zp);
    float zz = (q1.wp + q1.yp) * (q2.wp - q2.zp);
    float ww = (q1.zp + q1.xp) * (q2.xp + q2.yp);
    float xx = ww + yy + zz;
    float qq = 0.5f * (xx + (q1.zp - q1.xp) * (q2.xp - q2.yp));

    float w = qq - ww + (q1.zp - q1.yp) * (q2.yp - q2.zp);
    float x = qq - xx + (q1.xp + q1.wp) * (q2.xp + q2.wp);
    float y = qq - yy + (q1.wp - q1.xp) * (q2.yp + q2.zp);
    float z = qq - zz + (q1.zp + q1.yp) * (q2.wp - q2.xp);

    return QQuaternion(w, x, y, z);
}+/

/+pragma(inline, true) const(QQuaternion) operator +(ref const(QQuaternion) q1, ref const(QQuaternion) q2)
{
    return QQuaternion(q1.wp + q2.wp, q1.xp + q2.xp, q1.yp + q2.yp, q1.zp + q2.zp);
}+/

/+pragma(inline, true) const(QQuaternion) operator -(ref const(QQuaternion) q1, ref const(QQuaternion) q2)
{
    return QQuaternion(q1.wp - q2.wp, q1.xp - q2.xp, q1.yp - q2.yp, q1.zp - q2.zp);
}+/

/+pragma(inline, true) const(QQuaternion) operator *(float factor, ref const(QQuaternion) quaternion)
{
    return QQuaternion(quaternion.wp * factor, quaternion.xp * factor, quaternion.yp * factor, quaternion.zp * factor);
}+/

/+pragma(inline, true) const(QQuaternion) operator *(ref const(QQuaternion) quaternion, float factor)
{
    return QQuaternion(quaternion.wp * factor, quaternion.xp * factor, quaternion.yp * factor, quaternion.zp * factor);
}+/

/+pragma(inline, true) const(QQuaternion) operator -(ref const(QQuaternion) quaternion)
{
    return QQuaternion(-quaternion.wp, -quaternion.xp, -quaternion.yp, -quaternion.zp);
}+/

/+pragma(inline, true) const(QQuaternion) operator /(ref const(QQuaternion) quaternion, float divisor)
{
    return QQuaternion(quaternion.wp / divisor, quaternion.xp / divisor, quaternion.yp / divisor, quaternion.zp / divisor);
}+/

pragma(inline, true) bool qFuzzyCompare(ref const(QQuaternion) q1, ref const(QQuaternion) q2)
{
    import qt.core.global;

    return qt.core.global.qFuzzyCompare(q1.wp, q2.wp) &&
           qt.core.global.qFuzzyCompare(q1.xp, q2.xp) &&
           qt.core.global.qFuzzyCompare(q1.yp, q2.yp) &&
           qt.core.global.qFuzzyCompare(q1.zp, q2.zp);
}

version (QT_NO_VECTOR3D) {} else
{

/+pragma(inline, true) QVector3D operator *(ref const(QQuaternion) quaternion, ref const(QVector3D) vec)
{
    return quaternion.rotatedVector(vec);
}+/

}

/+ #ifndef QT_NO_VECTOR4D

#endif

#ifndef QT_NO_DEBUG_STREAM
Q_GUI_EXPORT QDebug operator<<(QDebug dbg, const QQuaternion &q);
#endif

#ifndef QT_NO_DATASTREAM
Q_GUI_EXPORT QDataStream &operator<<(QDataStream &, const QQuaternion &);
Q_GUI_EXPORT QDataStream &operator>>(QDataStream &, QQuaternion &);
#endif +/

}
