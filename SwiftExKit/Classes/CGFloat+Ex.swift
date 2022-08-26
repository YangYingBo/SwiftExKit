//
//  CGFloat+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 1/4/21.
//

import UIKit

extension CGFloat: SwiftExKitCompatible {}
extension Float: SwiftExKitCompatible {}

public extension SwiftExKit where Base == Float {
    var toInt: Int { Int(self.base) }
}

public extension SwiftExKit where Base == CGFloat {
    
    var center: CGFloat { return (self.base / 2) }
    /// 角度转弧度
    var toRadians: CGFloat {
        return (.pi * self.base) / 180.0
    }

    /// 角度转弧度
    func degreesToRadians() -> CGFloat {
        return (.pi * self.base) / 180.0
    }

    /// 将角度转换为弧度。
    static func degreesToRadians(_ angle: CGFloat) -> CGFloat {
        return (.pi * angle) / 180.0
    }
    
    /// 将弧度转换为度
    var toDegrees: CGFloat {
        return (180.0 * self.base) / .pi
    }
    /// 将弧度转换为度。
    func radiansToDegrees() -> CGFloat {
        return (180.0 * self.base) / .pi
    }

    /// 将角度弧度转换为度
    static func radiansToDegrees(_ angleInDegrees: CGFloat) -> CGFloat {
        return (180.0 * angleInDegrees) / .pi
    }

    /// 返回0.0到1.0(包括1.0)之间的随机浮点数
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }

    /// 返回一个随机浮点数，范围在min…max
    static func random(within: Range<CGFloat>) -> CGFloat {
        return CGFloat.ex.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }

    /// 返回一个随机浮点数，范围在min…max
    static func random(within: ClosedRange<CGFloat>) -> CGFloat {
        return CGFloat.ex.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }

    /**
     返回两个角之间的最短角。结果总是在-π和π两者之间。

      Inspired from : https://github.com/raywenderlich/SKTUtils/blob/master/SKTUtils/CGFloat%2BExtensions.swift
     */
    static func shortestAngleInRadians(from first: CGFloat, to second: CGFloat) -> CGFloat {
        let twoPi = CGFloat(.pi * 2.0)
        var angle = (second - first).truncatingRemainder(dividingBy: twoPi)
        if angle >= .pi {
            angle -= twoPi
        }
        if angle <= -.pi {
            angle += twoPi
        }
        return angle
    }
    
    // 绝对值
    var abs: CGFloat {
        return Swift.abs(self.base)
    }
    // 取上限
    var ceil: CGFloat {
        return Foundation.ceil(self.base)
    }
    // 取下限
    var floor: CGFloat {
        return Foundation.floor(self.base)
    }
    // 四舍五入
    var round: CGFloat {
        return Foundation.round(self.base)
    }
    // 是否是正数
    var isPositive: Bool {
        return self.base > 0
    }
    // 是否是负数
    var isNegative: Bool {
        return self.base < 0
    }
    // float
    var float: Float {
        return Float(self.base)
    }
    // int
    var int: Int {
        return Int(self.base)
    }
    // double
    var double: Double {
        return Double(self.base)
    }
    
    
}
