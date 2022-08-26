//
//  Optional+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 12/30/20.
//

import Foundation

extension Optional: SwiftExKitCompatible {}

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

extension Optional {
    
    // 返回默认值
    public func or(_ defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
    
    // 返回闭包返回值
    public func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    // 返回闭包返回值
    public func or(else: ()->Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    // 抛出异常
    public func or(_ exception: Error) throws -> Wrapped {
        guard let unwrappend = self else {
            throw exception
        }
        
        return unwrappend
    }
    
}

extension Optional {
    // 映射 为空是为默认值
    public func map<W>(_ transform: (Wrapped) throws -> W,defaultValue:W) rethrows -> W {
        return try map(transform) ?? defaultValue
    }
    // 映射 为空是为闭包返回值
    public func map<W>(_ transform: (Wrapped) throws -> W,else:()->W) rethrows -> W {
        return try map(transform) ?? `else`()
    }
    
    
}

public extension Optional {
    
    // 当可选值有值时调用some闭包
    func onSome(_ some: () throws -> Void) rethrows {
        if self.ex.isSome {
            try some()
        }
    }
    
    // 当可选值有值时调用some闭包
    func onSome(_ some: (Wrapped) throws -> Void) rethrows {
        if self.ex.isSome {
            try some(self!)
        }
    }
    
    // 当可选值为nil时调用none闭包
    func onNone(_ none: () throws -> Void) rethrows {
        if self.ex.isNone {
            try none()
        }
    }
}

public extension Optional {
    // 过滤非空及其满足闭包条件
    func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let value = self,predicate(value) else {
            return nil
        }
        
        return value
    }
    // 期待结果 非空返回 空时报错
    func expect(_ message: String) -> Wrapped {
        guard let value = self else {
            fatalError(message)
        }
        return value
    }
}

