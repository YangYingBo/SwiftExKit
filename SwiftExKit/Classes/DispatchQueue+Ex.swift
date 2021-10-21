//
//  DispatchQueue+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 1/8/21.
//

import Foundation

public extension SwiftExKit where Base: DispatchQueue {
    
    static func sync(main: @escaping () -> Void) {
        if Thread.isMainThread {
            main()
        } else {
            DispatchQueue.main.async(execute: main)
        }
        
    }
    
    static func async(queue: DispatchQueue = DispatchQueue.global(), global: @escaping () -> Void, main: @escaping () -> Void) {
        let item = DispatchWorkItem(block: global)
        queue.async(execute: item)
        item.notify(queue: DispatchQueue.main, execute: main)
        
    }
    
}
