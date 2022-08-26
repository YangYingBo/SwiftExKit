//
//  UIControl+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 12/28/20.
//

import UIKit


fileprivate struct TBControlAssociatedKey {
    static var events = false
}

public extension SwiftExKit where Base: UIControl {
    
    
    fileprivate var events: [UIControl.Event.RawValue:[TBControlTarget]]? {
        set {
            objc_setAssociatedObject(self.base, &(TBControlAssociatedKey.events), newValue, .OBJC_ASSOCIATION_COPY)
        }
        get {
            return objc_getAssociatedObject(self.base, &(TBControlAssociatedKey.events)) as? [UIControl.Event.RawValue : [TBControlTarget]]
        }
    }
    
    // MARK: 添加事件
    func whenClick(event: UIControl.Event, isOnlyAction: Bool = true, callback: @escaping (UIControl) -> Void) {
       let target = TBControlTarget(control: self.base, controlEvents: event) { (con) in
            callback(con)
        }
        
        if self.events == nil {
            self.events = [UIControl.Event.RawValue:[TBControlTarget]]()
        }
        
        if self.events?[event.rawValue] == nil {
            var handlers = [TBControlTarget]()
            handlers.append(target)
            self.events?[event.rawValue] = handlers
        } else {
            
            if var targets = self.events?[event.rawValue] {
                if isOnlyAction {
                    // 同种event 只能有一个响应事件
                    if targets.isEmpty {
                        self.events?[event.rawValue]?.append(target)
                    } else {
                        targets[0] = target
                        self.events?[event.rawValue] = targets
                    }
                } else {
                    // 同种event 有多个响应事件
                    self.events?[event.rawValue]?.append(target)
                }
            }
        }
    }
    
    
    // MARK: - 防爆击执行事件
    func debounceClick(event: UIControl.Event, interval: TimeInterval = 2, queue: DispatchQueue = DispatchQueue.main, callback: @escaping (UIControl) -> Void) {
        
        self.base.ex.debounce(interval: interval, queue: queue) {
            callback(self.base)
        }
        
        self.base.ex.whenClick(event: event) { (btn) in
            btn.ex.debounceCall()
        }
        
    }
    
}


/// 事件监听
fileprivate class TBControlTarget: NSObject {
    
    typealias Callback = (UIControl) -> Void
    
    let selector: Selector = #selector(TBControlTarget.eventHandler(_:))
    
    weak var control: UIControl?
    let controlEvents: UIControl.Event
    var callback: Callback?
    
    init(control: UIControl, controlEvents: UIControl.Event, callback: @escaping Callback) {
        self.control = control
        self.controlEvents = controlEvents
        self.callback = callback
        super.init()
        control.addTarget(self, action: selector, for: controlEvents)
        
        let method = self.method(for: selector)
        if method == nil {
            fatalError("响应事件未定义")
        }
    }
    
    @objc func eventHandler(_ sender: UIControl!) {
        if let callback = self.callback, let control = self.control {
            callback(control)
        }
    }
    
    deinit {
        self.control?.removeTarget(self, action: self.selector, for: self.controlEvents)
        self.callback = nil
//        YYLog("\(self) ======= 释放了")
    }
    
}
