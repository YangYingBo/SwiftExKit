//
//  Int+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 1/4/21.
//

import Foundation

extension Int: SwiftExCompatible {}

public extension SwiftExKit where Base == Int {
    /// 偶数
    var isEven: Bool { return (self.base % 2 == 0) }

    /// 奇数
    var isOdd: Bool { return (self.base % 2 != 0) }

    /// 正数
    var isPositive: Bool { return (self.base > 0) }

    /// 负数
    var isNegative: Bool { return (self.base < 0) }
    
    /// 整数的位数
    var digits: Int {
        if self.base == 0 {
            return 1
        } else if Int(fabs(Double(self.base))) <= LONG_MAX {
            return Int(log10(fabs(Double(self.base)))) + 1
        }
    }
    
    /// 一定范围中的随机数
    static func random(within: Range<Int>) -> Int {
        let delta = within.upperBound - within.lowerBound
        return within.lowerBound + Int(arc4random_uniform(UInt32(delta)))
    }
    
    
    
}
