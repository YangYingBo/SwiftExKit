//
//  UIView+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 12/28/20.
//

import UIKit

fileprivate struct TBViewAssociatedKey {
    static var gestures = false
}

public extension SwiftExKit where Base: UIView {
    // MARK: - 位置属性
    var top :CGFloat{
        set{
            var frame = self.base.frame
            frame.origin.y = newValue
            self.base.frame = frame
        }
        
        get{
            return self.base.frame.origin.y
        }
    }
    
    var bottom :CGFloat{
        set{
            var frame = self.base.frame
            frame.origin.y = newValue - frame.size.height
            self.base.frame = frame
            
        }
        
        get{
            return self.base.frame.origin.y + self.base.frame.size.height
        }
    }
    
    var left :CGFloat{
        set{
            var frame = self.base.frame
            frame.origin.x = newValue
            self.base.frame = frame
            
        }
        
        get{
            return self.base.frame.origin.x
        }
    }
    
    var right :CGFloat{
        set{
            var frame = self.base.frame
            frame.origin.x = newValue - self.base.frame.size.width
            self.base.frame = frame
        }
        
        get{
            return self.base.frame.origin.x + self.base.frame.size.width
        }
    }
    
    var size :CGSize{
        set{
            var frame = self.base.frame
            frame.size = newValue
            self.base.frame = frame
        }
        
        get{
            return self.base.frame.size
        }
    }
    
    var width :CGFloat{
        set{
            var frame = self.base.frame
            frame.size.width = newValue
            self.base.frame = frame
        }
        
        get{
            return self.base.frame.size.width
        }
        
    }
    
    var height :CGFloat{
        set{
            var frame = self.base.frame
            frame.size.height = newValue
            self.base.frame = frame
        }
        
        get{
            return self.base.frame.size.height
        }
    }
    
    
    // MARK:---------- 在View上面添加一条线
    func addLineToTop(color:UIColor,lineHeight:CGFloat,edge:UIEdgeInsets = .zero) -> Void {
        if self.base.viewWithTag(2017) != nil {
            self.base.viewWithTag(2017)?.removeFromSuperview()
        }
        
        let topLine = UIView()
        self.base.addSubview(topLine)
        topLine.tag = 2017
        topLine.backgroundColor = color
        topLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topLine.topAnchor.constraint(equalTo: self.base.topAnchor),
            topLine.leftAnchor.constraint(equalTo: self.base.leftAnchor, constant: edge.left),
            topLine.rightAnchor.constraint(equalTo: self.base.rightAnchor, constant: -edge.right),
            topLine.heightAnchor.constraint(equalToConstant: lineHeight)
        ])
    }
    // MARK:---------- 在View下面添加一条线
    func addLineToBottom(color:UIColor,lineHeight:CGFloat,edge:UIEdgeInsets = .zero) -> Void {
        if self.base.viewWithTag(20171) != nil {
            self.base.viewWithTag(20171)?.removeFromSuperview()
        }
        
        let bottomLine = UIView()
        self.base.addSubview(bottomLine)
        bottomLine.tag = 20171
        bottomLine.backgroundColor = color
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomLine.bottomAnchor.constraint(equalTo: self.base.bottomAnchor),
            bottomLine.leftAnchor.constraint(equalTo: self.base.leftAnchor, constant: edge.left),
            bottomLine.rightAnchor.constraint(equalTo: self.base.rightAnchor, constant: -edge.right),
            bottomLine.heightAnchor.constraint(equalToConstant: lineHeight)
        ])

    }
    // MARK:---------- 在View左边添加一条线
    func addLineToLeft(color:UIColor,lineWidth:CGFloat,edge:UIEdgeInsets = .zero) -> Void {
        if self.base.viewWithTag(20172) != nil {
            self.base.viewWithTag(20172)?.removeFromSuperview()
        }
        
        let leftLine = UIView()
        self.base.addSubview(leftLine)
        leftLine.tag = 20172
        leftLine.backgroundColor = color
        leftLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftLine.leftAnchor.constraint(equalTo: self.base.leftAnchor),
            leftLine.topAnchor.constraint(equalTo: self.base.topAnchor, constant: edge.top),
            leftLine.bottomAnchor.constraint(equalTo: self.base.bottomAnchor, constant: -edge.bottom),
            leftLine.widthAnchor.constraint(equalToConstant: lineWidth)
        ])
        
    }
    // MARK:---------- 在View右边添加一条线
    func addLineToRight(color:UIColor,lineWidth:CGFloat,edge:UIEdgeInsets = .zero) -> Void {
        if self.base.viewWithTag(20173) != nil {
            self.base.viewWithTag(20173)?.removeFromSuperview()
        }
        
        let rightLine = UIView()
        self.base.addSubview(rightLine)
        rightLine.tag = 20173
        rightLine.backgroundColor = color
        rightLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightLine.rightAnchor.constraint(equalTo: self.base.rightAnchor),
            rightLine.topAnchor.constraint(equalTo: self.base.topAnchor, constant: edge.top),
            rightLine.bottomAnchor.constraint(equalTo: self.base.bottomAnchor, constant: -edge.bottom),
            rightLine.widthAnchor.constraint(equalToConstant: lineWidth)
        ])
        
    }
    
    // MARK: - 设置图片
    var layerImage: UIImage? {
        get {
            return self.base.layer.ex.image
        }
        set {
            self.base.layer.ex.image = newValue
        }
    }
    
    /// 设置纯色背景图片
    func setBackgroundImage(_ color: UIColor) {
        let size = self.base.frame.size
        let normalSize = CGSize(width: size.width == 0 ? 1 : size.width, height: size.height == 0 ? 1 : size.height)
        self.setBackgroundImage(color, size: normalSize)
    }
    
    func setBackgroundImage(_ color: UIColor, size: CGSize, corner: CGFloat = 0) {
        
        let bgImage = UIImage.ex.image(color: color, size: size, corner: corner)
        self.setBackgroundImage(bgImage)
        
    }
    /// 设置背景图片
    func setBackgroundImage(_ image: UIImage) {
        self.layerImage = image
    }
    
    // MARK: - 响应事件
   fileprivate var gestures: [TBGestureTarget]? {
        set {
            objc_setAssociatedObject(self.base, &(TBViewAssociatedKey.gestures), newValue, .OBJC_ASSOCIATION_COPY)
        }
        get {
            objc_getAssociatedObject(self.base, &(TBViewAssociatedKey.gestures)) as? [TBGestureTarget]
        }
    }
    
    // MARK: 防抖动
    func debounceTapGestureRecognizer(interval: TimeInterval = 2, queue: DispatchQueue = DispatchQueue.main,callback: @escaping (UIView) -> Void) {
        
        self.base.ex.debounce(interval: interval, queue: queue) {
            callback(self.base)
        }
        
        self.base.ex.tapGestureRecognizer { (ges) in
            ges.view?.ex.debounceCall()
        }
        
    }
    // MARK: 点击事件
    func tapGestureRecognizer(taps: Int = 1, callback: @escaping (UIGestureRecognizer) -> Void) {
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = taps
        self.base.addGestureRecognizer(tap)
        let target = TBGestureTarget(tap) { (tap) in
            callback(tap)
        }
        
        if self.gestures == nil {
            self.gestures = [TBGestureTarget]()
        }
        
        self.gestures?.append(target)
        
    }
    // MARK: 长按
    func longPressGestureRecognizer(callback: @escaping (UIGestureRecognizer) -> Void) {
        let longPress = UILongPressGestureRecognizer()
        self.base.addGestureRecognizer(longPress)
        let target = TBGestureTarget(longPress) { (long) in
            callback(long)
        }
        
        if self.gestures == nil {
            self.gestures = [TBGestureTarget]()
        }
        
        self.gestures?.append(target)
    }
    // MARK: 左划
    func leftGestureRecognizer(callback: @escaping (UIGestureRecognizer) -> Void) {
        let left = UISwipeGestureRecognizer()
        left.direction = .left
        self.base.addGestureRecognizer(left)
        let target = TBGestureTarget(left) { (left) in
            callback(left)
        }
        
        if self.gestures == nil {
            self.gestures = [TBGestureTarget]()
        }
        
        self.gestures?.append(target)
    }
    // MARK: 右划
    func rightGestureRecognizer(callback: @escaping (UIGestureRecognizer) -> Void) {
        let right = UISwipeGestureRecognizer()
        right.direction = .right
        self.base.addGestureRecognizer(right)
        let target = TBGestureTarget(right) { (right) in
            callback(right)
        }
        
        if self.gestures == nil {
            self.gestures = [TBGestureTarget]()
        }
        
        self.gestures?.append(target)
    }
    
    // MARK: 上滑
    func upGestureRecognizer(callback: @escaping (UIGestureRecognizer) -> Void) {
        let up = UISwipeGestureRecognizer()
        up.direction = .up
        self.base.addGestureRecognizer(up)
        let target = TBGestureTarget(up) { (up) in
            callback(up)
        }
        
        if self.gestures == nil {
            self.gestures = [TBGestureTarget]()
        }
        
        self.gestures?.append(target)
    }
    
    // MARK: 下划
    func downGestureRecognizer(callback: @escaping (UIGestureRecognizer) -> Void) {
        let down = UISwipeGestureRecognizer()
        down.direction = .down
        self.base.addGestureRecognizer(down)
        let target = TBGestureTarget(down) { (right) in
            callback(right)
        }
        
        if self.gestures == nil {
            self.gestures = [TBGestureTarget]()
        }
        
        self.gestures?.append(target)
    }
    
    // MARK: 下划
    func panGestureRecognizer(callback: @escaping (UIGestureRecognizer) -> Void) {
        let pan = UIPanGestureRecognizer()
        self.base.addGestureRecognizer(pan)
        let target = TBGestureTarget(pan) { (right) in
            callback(right)
        }
        
        if self.gestures == nil {
            self.gestures = [TBGestureTarget]()
        }
        
        self.gestures?.append(target)
    }
    
    // 截屏
    func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.base.bounds.size, self.base.isOpaque, 0.0)
        self.base.drawHierarchy(in: self.base.bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    
    // MARK: - 旋转
    func rotationX(_ x: CGFloat) {
        self.base.layer.ex.rotationX(x)
    }
    
    func rotationY(_ y: CGFloat) {
        self.base.layer.ex.rotationY(y)
    }
    
    func rotationZ(_ z: CGFloat) {
        self.base.layer.ex.rotationZ(z)
    }
    
    func rotation(x: CGFloat, y: CGFloat, z: CGFloat) {
        self.base.layer.ex.rotation(x: x, y: y, z: z)
    }
    
    // MARK: - 缩放
    func scale(x: CGFloat = 1.0, y: CGFloat = 1.0, z: CGFloat = 1.0) {
        self.base.layer.ex.scale(x: x, y: y, z: z)
    }
    
    // MARK: - 平移
    func translation(x: CGFloat = 0.0, y: CGFloat = 0.0, z: CGFloat = 0.0) {
        self.base.layer.ex.translation(x: x, y: y, z: z)
    }
    
    // 设置部分圆角
    func roundCorners(corners:UIRectCorner, with radii:CGFloat){
        let bezierpath:UIBezierPath = UIBezierPath.init(roundedRect: (self.base.bounds), byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let shape:CAShapeLayer = CAShapeLayer.init()
        shape.path = bezierpath.cgPath
        
        self.base.layer.mask = shape
    }
    
    func roundCorners(corners:UIRectCorner, with radii:CGFloat, fillColor: UIColor){
        let bezierpath:UIBezierPath = UIBezierPath.init(roundedRect: (self.base.bounds), byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let shape:CAShapeLayer = CAShapeLayer.init()
        shape.path = bezierpath.cgPath
        shape.strokeColor = fillColor.cgColor
        shape.lineWidth = 10
        self.base.layer.addSublayer(shape)
    }

    // 设置圆角和阴影
    func roundCornerAndShadow(_ radius: CGFloat = 10.0) {
        self.base.layer.contentsScale = UIScreen.main.scale
        // 默认是0，不显示阴影
        self.base.layer.shadowOpacity = 1
        self.base.layer.shadowRadius = 5.0
        // width: 正是向右偏移   height:正是向下偏移
        self.base.layer.shadowOffset = CGSize.init(width: 0, height: 5)
        self.base.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        //设置缓存
        self.base.layer.shouldRasterize = true
        
        //设置抗锯齿边缘
        self.base.layer.rasterizationScale = UIScreen.main.scale
        
        // 设置阴影形状
        self.base.layer.shadowPath = UIBezierPath(roundedRect: self.base.bounds, cornerRadius: radius).cgPath
        // 设置圆角
        self.base.layer.cornerRadius = radius
    }
    
}

/// UIView 手势事件监听
fileprivate class TBGestureTarget: NSObject {
    typealias Callback = (UIGestureRecognizer) -> Void
    
    let selector = #selector(TBGestureTarget.eventHandler(_:))
    
    weak var gestureRecognizer: UIGestureRecognizer?
    var callback: Callback?
    
    init(_ gestureRecognizer: UIGestureRecognizer, callback: @escaping Callback) {
        self.gestureRecognizer = gestureRecognizer
        self.callback = callback
        
        super.init()
        
        gestureRecognizer.addTarget(self, action: selector)

        let method = self.method(for: selector)
        if method == nil {
            fatalError("响应事件未定义")
        }
    }
    
    @objc func eventHandler(_ sender: UIGestureRecognizer) {
        if let callback = self.callback, let gestureRecognizer = self.gestureRecognizer {
            callback(gestureRecognizer)
        }
    }
    
    deinit {
        self.gestureRecognizer?.removeTarget(self, action: selector)
        self.callback = nil
        
//        YYLog("\(self) ====== 释放了")
    }
}
