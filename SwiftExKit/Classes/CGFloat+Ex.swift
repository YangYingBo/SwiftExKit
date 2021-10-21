//
//  CGFloat+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 1/4/21.
//

import UIKit

extension CGFloat: SwiftExCompatible {}

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
        return CGFloat.swe.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }

    /// 返回一个随机浮点数，范围在min…max
    static func random(within: ClosedRange<CGFloat>) -> CGFloat {
        return CGFloat.swe.random() * (within.upperBound - within.lowerBound) + within.lowerBound
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
    
}
