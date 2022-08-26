//
//  Bool+Ex.swift
//  TBExKit
//
//  Created by yangyb on 2022/7/15.
//

import Foundation

extension Bool: SwiftExKitCompatible {}

public extension SwiftExKit where Base == Bool {
    ///  如果是true返回1  如果是false返回0
    ///
    ///        false.int -> 0
    ///        true.int -> 1
    ///
    var int: Int {
        return self.base ? 1 : 0
    }

    ///  如果是true返回"true"  如果是false返回"false"
    ///
    ///        false.string -> "false"
    ///        true.string -> "true"
    ///
    var string: String {
        return self.base ? "true" : "false"
    }
}
