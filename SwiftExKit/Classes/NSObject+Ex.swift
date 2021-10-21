//
//  NSObject+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 1/11/21.
//

import Foundation

public typealias _YYBKVOBlock = (Any?, Any?, Any?) -> ()

fileprivate struct YYBObjectAssociatedKey {
    static var YYBKVOTargets = false
    static var YYBDebounceKey = false
}

public extension SwiftExKit where Base: NSObjectProtocol {
    
    // MARK: - Runtime
    @discardableResult
    func swizzleInstanceMethod(_ originalSel: Selector, newSel: Selector ) -> Bool {
        
        guard let originalMethod = class_getInstanceMethod((self.base as! AnyClass), originalSel),
              let newMethod = class_getInstanceMethod((self.base as! AnyClass), newSel) else {
            return false
        }
        
        let originalIMP = class_getMethodImplementation((self.base as! AnyClass), originalSel)
        let newIMP = class_getMethodImplementation((self.base as! AnyClass), newSel)
        
        
        
        class_addMethod((self.base as! AnyClass), originalSel, originalIMP!, method_getTypeEncoding(originalMethod))
        class_addMethod((self.base as! AnyClass), newSel, newIMP!, method_getTypeEncoding(newMethod))
        
        method_exchangeImplementations(originalMethod, newMethod)
        
        return true
    }
    
    
    func swizzleClassMethod(_ originalSel: Selector, newSel: Selector) -> Bool {
        
        guard let metaClass = object_getClass(self.base as! AnyClass),
              let originalMethod = class_getInstanceMethod(metaClass, originalSel),
              let newMethod = class_getInstanceMethod(metaClass, newSel) else {
            return false
        }
        
        method_exchangeImplementations(originalMethod, newMethod)
        
        return true
    }
    
    /// 关联强引用
    func setAssociateValue(key: UnsafeRawPointer, value: Any?) {
        setAssociatedObject(key: key, value: value, policy: .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
    var debounce: YYBDebounce {
        set {
            objc_setAssociatedObject(self.base, &(YYBObjectAssociatedKey.YYBDebounceKey), newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            objc_getAssociatedObject(self.base, &(YYBObjectAssociatedKey.YYBDebounceKey)) as! YYBDebounce
        }
    }
    
    // 在interval时间内防止暴力执行
    func debounce(interval: TimeInterval, queue: DispatchQueue = DispatchQueue.main, taskBlock: @escaping ()->()) {
        self.debounce = YYBDebounce(interval: interval, queue: queue, taskBlock: taskBlock)
        
    }
    // 呼叫事件执行
    func debounceCall() {
        self.debounce.call()
    }
    
    // MARK: - KVO
    func addObserverBlock(_ keyPath: String, block: @escaping _YYBKVOBlock) {
        
        let target = YYBKVOTarget(self.base as! NSObject, keyPath: keyPath, block: block)
        
        var allTargetBlocks = allNSObjectObserverBlocks()
        if allTargetBlocks[keyPath] == nil {
            var targets = [YYBKVOTarget]()
            targets.append(target)
            allTargetBlocks[keyPath] = targets

        } else {
            allTargetBlocks[keyPath]?.append(target)
        }
        setAssociateValue(key: &(YYBObjectAssociatedKey.YYBKVOTargets), value: allTargetBlocks)
        
        
//        if self.observerBlocks == nil {
//            self.observerBlocks = [String: [YYBKVOTarget]]()
//        }
//
//        if self.observerBlocks?[keyPath] == nil {
//            var targets = [YYBKVOTarget]()
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
    
    
    fileprivate var observerBlocks: [String: [YYBKVOTarget]]? {
        set {
            setAssociateValue(key: &(YYBObjectAssociatedKey.YYBKVOTargets), value: newValue)
        }
        get {
            getAssociatedObject(key: &(YYBObjectAssociatedKey.YYBKVOTargets)) as? [String : [YYBKVOTarget]]
        }
    }
    
    
    fileprivate func allNSObjectObserverBlocks() -> [String: [YYBKVOTarget]] {
        var kvoTargets = getAssociatedObject(key: &(YYBObjectAssociatedKey.YYBKVOTargets))
        if kvoTargets == nil {
            kvoTargets = [String:[YYBKVOTarget]]()
            setAssociateValue(key: &(YYBObjectAssociatedKey.YYBKVOTargets), value: kvoTargets)
        }
        return kvoTargets as! [String : [YYBKVOTarget]]
    }
    
}


/// KVO 监听类
fileprivate class YYBKVOTarget: NSObject {
    
    let targetBlock: _YYBKVOBlock
    weak var target: NSObject?
    var keyPath: String
    
    init(_ target: NSObject, keyPath: String, block: @escaping _YYBKVOBlock) {
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
    }
    

    
}


public class YYBDebounce {
    
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
