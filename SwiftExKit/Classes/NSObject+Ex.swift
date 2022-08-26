//
//  NSObject+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 1/11/21.
//

import Foundation

public typealias _TBKVOBlock = (Any?, Any?, Any?) -> ()

fileprivate struct TBObjectAssociatedKey {
    static var TBKVOTargets = false
    static var TBDebounceKey = false
}

public extension SwiftExKit where Base: NSObjectProtocol {
    
//    // MARK: - Runtime
//    @discardableResult
//    func swizzleInstanceMethod(_ originalSel: Selector, newSel: Selector ) -> Bool {
//
//        guard let originalMethod = class_getInstanceMethod((self.base as! AnyClass), originalSel),
//              let newMethod = class_getInstanceMethod((self.base as! AnyClass), newSel) else {
//            return false
//        }
//
//        guard let originalIMP = class_getMethodImplementation((self.base as! AnyClass), originalSel),
//                let newIMP = class_getMethodImplementation((self.base as! AnyClass), newSel) else {
//            return false
//        }
//
//        if class_addMethod((self.base as! AnyClass), originalSel, originalIMP, method_getTypeEncoding(originalMethod)) {
//            class_replaceMethod(self.base as! AnyClass, newSel, originalIMP, method_getTypeEncoding(originalMethod))
//        } else {
//            method_exchangeImplementations(originalMethod, newMethod)
//        }
//        return true
//    }
//
//
//    func swizzleClassMethod(_ originalSel: Selector, newSel: Selector) -> Bool {
//
//        guard let metaClass = object_getClass(self.base as! AnyClass),
//              let originalMethod = class_getInstanceMethod(metaClass, originalSel),
//              let newMethod = class_getInstanceMethod(metaClass, newSel) else {
//            return false
//        }
//
//        method_exchangeImplementations(originalMethod, newMethod)
//
//        return true
//    }
    
    /// 关联强引用
    func setAssociateValue(key: UnsafeRawPointer, value: Any?) {
        setAssociatedObject(key: key, value: value, policy: .OBJC_ASSOCIATION_RETAIN)
    }
    /// 关联弱引用
    func setAssociateAssign(key: UnsafeRawPointer, value: Any?) {
        setAssociatedObject(key: key, value: value, policy: .OBJC_ASSOCIATION_ASSIGN)
    }
    
    func setAssociatedObject(key: UnsafeRawPointer, value: Any?, policy: objc_AssociationPolicy) {
        return objc_setAssociatedObject(self.base, key, value, policy)
    }
    
    /// 获取关联值
    func getAssociatedObject(key: UnsafeRawPointer) -> Any? {
        return objc_getAssociatedObject(self.base, key)
    }
    /// 删除关联值
    func removeAssociatedValues() {
        objc_removeAssociatedObjects(self.base)
    }
    
    // MARK: - 防抖动
    var debounce: TBDebounce {
        set {
            objc_setAssociatedObject(self.base, &(TBObjectAssociatedKey.TBDebounceKey), newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            objc_getAssociatedObject(self.base, &(TBObjectAssociatedKey.TBDebounceKey)) as! TBDebounce
        }
    }
    
    // 在interval时间内防止暴力执行
    func debounce(interval: TimeInterval, queue: DispatchQueue = DispatchQueue.main, taskBlock: @escaping ()->()) {
        self.debounce = TBDebounce(interval: interval, queue: queue, taskBlock: taskBlock)
        
    }
    // 呼叫事件执行
    func debounceCall() {
        self.debounce.call()
    }
    
    // MARK: - KVO
    func addObserverBlock(_ keyPath: String, block: @escaping _TBKVOBlock) {
        
        let target = TBKVOTarget(self.base as! NSObject, keyPath: keyPath, block: block)
        
        var allTargetBlocks = allNSObjectObserverBlocks()
        if allTargetBlocks[keyPath] == nil {
            var targets = [TBKVOTarget]()
            targets.append(target)
            allTargetBlocks[keyPath] = targets

        } else {
            allTargetBlocks[keyPath]?.append(target)
        }
        setAssociateValue(key: &(TBObjectAssociatedKey.TBKVOTargets), value: allTargetBlocks)
        
        
//        if self.observerBlocks == nil {
//            self.observerBlocks = [String: [TBKVOTarget]]()
//        }
//
//        if self.observerBlocks?[keyPath] == nil {
//            var targets = [TBKVOTarget]()
//            targets.append(target)
//            self.observerBlocks?[keyPath] = targets
//        } else {
//            self.observerBlocks?[keyPath]?.append(target)
//        }
        
        
    }
    
    func removeObserverBlocks(_ keyPath: String) {
        var allTargetBlocks = allNSObjectObserverBlocks()
        var targets = allTargetBlocks[keyPath]
        targets?.removeAll()
        allTargetBlocks.removeValue(forKey: keyPath)
        
    }
    
    func removeObserverBlocks() {
        var allTargetBlocks = allNSObjectObserverBlocks()
        allTargetBlocks.removeAll()
    }
    
    
    fileprivate var observerBlocks: [String: [TBKVOTarget]]? {
        set {
            setAssociateValue(key: &(TBObjectAssociatedKey.TBKVOTargets), value: newValue)
        }
        get {
            getAssociatedObject(key: &(TBObjectAssociatedKey.TBKVOTargets)) as? [String : [TBKVOTarget]]
        }
    }
    
    
    fileprivate func allNSObjectObserverBlocks() -> [String: [TBKVOTarget]] {
        var kvoTargets = getAssociatedObject(key: &(TBObjectAssociatedKey.TBKVOTargets))
        if kvoTargets == nil {
            kvoTargets = [String:[TBKVOTarget]]()
            setAssociateValue(key: &(TBObjectAssociatedKey.TBKVOTargets), value: kvoTargets)
        }
        return kvoTargets as! [String : [TBKVOTarget]]
    }
    
}


/// KVO 监听类
fileprivate class TBKVOTarget: NSObject {
    
    let targetBlock: _TBKVOBlock
    weak var target: NSObject?
    var keyPath: String
    
    init(_ target: NSObject, keyPath: String, block: @escaping _TBKVOBlock) {
        self.targetBlock = block
        self.target = target
        self.keyPath = keyPath
        super.init()
        
        self.target?.addObserver(self, forKeyPath: self.keyPath, options: [.new,.old], context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        self.targetBlock(object,change?[.oldKey],change?[.newKey])
    }
    
    deinit {
        /// 移除KVO监听
        self.target?.removeObserver(self, forKeyPath: self.keyPath)
        self.target = nil
//        YYLog("\(self) ======== 释放了 ")
    }
    

    
}


public class TBDebounce {
    
    var interval: TimeInterval
    var queue: DispatchQueue
    var taskBlock: () -> ()
    private var workItem: DispatchWorkItem?
    
    
    init(interval: TimeInterval, queue: DispatchQueue = DispatchQueue.main, taskBlock: @escaping ()->()) {
        self.interval = interval
        self.queue = queue
        self.taskBlock = taskBlock
        
    }
    
    func call() {
        if self.workItem != nil {
            self.workItem?.cancel()
        }
        
        self.workItem = DispatchWorkItem(block: {
            self.taskBlock()
        })
        self.queue.asyncAfter(deadline: .now() + self.interval, execute: self.workItem!)
    }
    
    deinit {
        self.workItem = nil
    }
    
}
