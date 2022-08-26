//
//  Compatible.swift
//  Swift类拓展
//
//  Created by yangyb on 12/28/20.
//  给拓展添加‘ex’前缀调用

import Foundation


public class SwiftExKit<Base> {
    var base: Base
    public init(_ base: Base) {
        self.base = base
    }
    
}

public protocol SwiftExKitCompatible {}
public extension SwiftExKitCompatible {
    
    var ex: SwiftExKit<Self> {
        set {}
        get { SwiftExKit(self) }
    }
    
    static var ex: SwiftExKit<Self>.Type {
        set {}
        get { SwiftExKit<Self>.self }
    }
    
}

extension NSObject: SwiftExKitCompatible {}

public func swizzleMethod(for aClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
    let originalMethod = class_getInstanceMethod(aClass, originalSelector)
    let swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector)
    
    let didAddMethod = class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
    
    if didAddMethod {
        class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
    } else {
        method_exchangeImplementations(originalMethod!, swizzledMethod!)
    }
}

public func YYLog(_ items: Any..., file: NSString = #file, line: Int = #line, function: String = #function, date: Date = Date()) {
    
    #if DEBUG
    var message = ""
    for item in items {
        message += "\(item) "
    }
    print("\(YYDateFormatter.string(from: date)) [Debug] [\(file.lastPathComponent):\(line)] \(function) >>>>>>>>> \(message)")
    #endif
}

public let YYDateFormatter: DateFormatter = {
    let defaultDateFormatter = DateFormatter()
    defaultDateFormatter.locale = NSLocale.current
    defaultDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return defaultDateFormatter
}()



