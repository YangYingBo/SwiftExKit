//
//  Int+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 1/4/21.
//

import Foundation

extension Int: SwiftExKitCompatible {}
extension UInt16: SwiftExKitCompatible {}
extension UInt32: SwiftExKitCompatible {}
extension UInt64: SwiftExKitCompatible {}
extension UInt8: SwiftExKitCompatible {}

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
    
    // float
    var float: Float {
        return Float(self.base)
    }
    
    // CGfloat
    var cgfloat: CGFloat {
        return CGFloat(self.base)
    }
    
}


public extension SwiftExKit where Base == UInt8 {
    
    var toString: String {
        let uint8 = String(self.base,radix: 16)
        let zero = String(repeating: "0", count: 2 - uint8.count)
        return zero + uint8
    }
    
}

public extension SwiftExKit where Base == UInt16 {
    
    var toString: String {
        let uint16 = String(self.base,radix: 16)
        let zero = String(repeating: "0", count: 4 - uint16.count)
        return zero + uint16
    }
    
}

public extension SwiftExKit where Base == UInt32 {
    
    var toString: String {
        let uint32 = String(self.base,radix: 16)
        let zero = String(repeating: "0", count: 8 - uint32.count)
        return zero + uint32
    }
    
}

public extension SwiftExKit where Base == UInt64 {
    
    var toString: String {
        let uint64 = String(self.base,radix: 16)
        let zero = String(repeating: "0", count: 16 - uint64.count)
        return zero + uint64
    }
    
}

