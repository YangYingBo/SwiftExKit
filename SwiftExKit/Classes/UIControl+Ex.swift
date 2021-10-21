//
//  UIControl+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 12/28/20.
//

import UIKit


fileprivate struct YYBControlAssociatedKey {
    static var events = false
}

public extension SwiftExKit where Base: UIControl {
    
    
    fileprivate var events: [UIControl.Event.RawValue:[YYBControlTarget]]? {
        set {
            objc_setAssociatedObject(self.base, &(YYBControlAssociatedKey.events), newValue, .OBJC_ASSOCIATION_COPY)
        }
        get {
            return objc_getAssociatedObject(self.base, &(YYBControlAssociatedKey.events)) as? [UIControl.Event.RawValue : [YYBControlTarget]]
        }
    }
    
    // MARK: 添加事件
    func whenClick(event: UIControl.Event, callback: @escaping (UIControl) -> Void) {
       let target = YYBControlTarget(control: self.base, controlEvents: event) { (con) in
            callback(con)
        }
        
        if self.events == nil {
            self.events = [UIControl.Event.RawValue:[YYBControlTarget]]()
        }
        
        if self.events?[event.rawValue] == nil {
            var handlers = [YYBControlTarget]()
            handlers.append(target)
            self.events?[event.rawValue] = handlers
        } else {
            self.events?[event.rawValue]?.append(target)
        }
    }
    
    
    // MARK: - 防爆击执行事件
    func debounceClick(event: UIControl.Event, interval: TimeInterval = 2, queue: DispatchQueue = DispatchQueue.main, callback: @escaping (UIControl) -> Void) {
        
        self.base.swe.debounce(interval: interval, queue: queue) {
            callback(self.base)
        }
        
        self.base.swe.whenClick(event: event) { (btn) in
            btn.swe.debounceCall()
        }
        
    }
    
}


/// 事件监听
fileprivate class YYBControlTarget: NSObject {
    
    typealias Callback = (UIControl) -> Void
    
    let selector: Selector = #selector(YYBControlTarget.eventHandler(_:))
    
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
