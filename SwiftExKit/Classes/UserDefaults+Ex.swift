//
//  UserDefaults+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 1/4/21.
//

import Foundation

public extension SwiftExKit where Base: UserDefaults {
    
    func value(_ key: String) -> Any? {
        return self.base.value(forKey: key)
    }
    
    func setValue(_ value: Any, key: String) {
        self.base.set(value, forKey: key)
        self.base.synchronize()
    }
    
}


