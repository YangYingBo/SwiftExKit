//
//  Optional+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 12/30/20.
//

import Foundation

extension Optional: SwiftExCompatible {}

public extension SwiftExKit where Base: ExpressibleByNilLiteral {
    
    var isNone: Bool {
        switch self.base {
        case nil:
            return true
        default:
            return false
        }
    }
    
    var isSome: Bool {
        return !isNone
    }
    
    
}

public extension Optional {
    
    // 判断是否为空
    var isNone: Bool {
        switch self {
        case .none:
            return true
        case .some(_):
            return false
        }
    }
    // 判断是否有值
    var isSome: Bool {
        return !isNone
    }
    
    // 返回默认值
    func or(_ defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
    
    // 返回闭包返回值
    func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    // 返回闭包返回值
    func or(else: () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    // 抛出异常
    func or(_ exception: Error) throws -> Wrapped {
        guard let unwrappend = self else {
            throw exception
        }
        
        return unwrappend
    }
    
}

