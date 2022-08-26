//
//  Dictionary+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 1/8/21.
//

import Foundation

extension Dictionary: SwiftExKitCompatible {}
public extension SwiftExKit where Base: ExpressibleByDictionaryLiteral,Base.Key: Hashable {
    
    func formatJSON() -> String? {
        let jsonDic = self.base as! [Base.Key:Base.Value]
        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDic, options: JSONSerialization.WritingOptions()) {
            let jsonStr = String(data: jsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            return String(jsonStr ?? "")
        }
        return nil
    }
    
    /// 获取到排过序的keys
    func sortedKeys() -> [Base.Key] where Base.Key: Comparable {
        let keys = (self.base as! [Base.Key:Base.Value]).keys
        return keys.sorted()
    }
    
    /// 根据排序的keys 获取values 过滤掉 nil 值
    func allValuesSortedByKeys() -> [Base.Value] where Base.Key: Comparable {
        let keys = sortedKeys()
        var sortedValues = [Base.Value]()
        for key in keys {
            if let val = (self.base as! [Base.Key:Base.Value])[key] {
                sortedValues.append(val)
            }
        }
        return sortedValues
    }
    
    /// 是否包含那个key
    func contains(_ key: Base.Key) -> Bool {
        return (self.base as! [Base.Key:Base.Value])[key] != nil
    }
    
    
    /// 映射
    func map<K: Hashable, V>(_ map: (Base.Key, Base.Value) -> (K, V)) -> [K: V] {
        var mapped: [K: V] = [:]
        let baseDic = self.base as! [Base.Key:Base.Value]
        baseDic.forEach {
            let (_key, _value) = map($0, $1)
            mapped[_key] = _value
        }
        return mapped
    
    }
    
    /// 过滤
    func filter(_ test: (Base.Key, Base.Value) -> Bool) -> [Base.Key:Base.Value] {
        var result = [Base.Key:Base.Value]()
        let baseDic = self.base as! [Base.Key:Base.Value]
        for (key, value) in baseDic {
            if test(key, value) {
                result[key] = value
            }
        }
        return result
    }
}
