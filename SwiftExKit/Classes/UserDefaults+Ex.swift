//
//  UserDefaults+Ex.swift
//  Swift类拓展
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
    // 存储对象
    func setObject<T: Codable>(_ object: T, key: String) {
        guard let value = try? JSONEncoder().encode(object) else { return }
        self.base.set(value, forKey: key)
        self.base.synchronize()
    }
    // 获取对象
    func item<T: Codable>(_ type: T.Type, key: String) -> T? {
        guard let data = self.base.data(forKey: key) else {
            return nil
        }
        
        return try? JSONDecoder().decode(type, from: data)
    }
    
}


