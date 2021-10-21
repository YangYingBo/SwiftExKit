//
//  YYBCompatible.swift
//  SwiftExKit
//
//  Created by yangyb on 12/28/20.
//  给拓展添加‘swe’前缀调用

import Foundation


public class SwiftExKit<Base> {
    var base: Base
    public init(_ base: Base) {
        self.base = base
    }
    
}

public protocol SwiftExCompatible {}
public extension SwiftExCompatible {
    
    var swe: SwiftExKit<Self> {
        set {}
        get { SwiftExKit(self) }
    }
    
    static var swe: SwiftExKit<Self>.Type {
        set {}
        get { SwiftExKit<Self>.self }
    }
    
}

extension NSObject: SwiftExCompatible {}


public func YYLog(_ items: Any..., file: NSString = #file, line: Int = #line, function: String = #function, date: Date = Date()) {
    
    #if DEBUG
    var message = ""
    for item in items {
        message += "\(item) "
    }
    print("\(YYBDateFormatter.string(from: date)) [Debug] [\(file.lastPathComponent):\(line)] \(function) >>>>>>>>> \(message)")
    #endif
}

public let YYBDateFormatter: DateFormatter = {
    let defaultDateFormatter = DateFormatter()
    defaultDateFormatter.locale = NSLocale.current
    defaultDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return defaultDateFormatter
}()



