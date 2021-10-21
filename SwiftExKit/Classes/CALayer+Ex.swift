//
//  UILayer+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 12/28/20.
//  CALayer 拓展

import UIKit

public extension SwiftExKit where Base: CALayer {
    // MARK: - 位置信息
    var left: CGFloat {
        get {
            return self.base.frame.origin.x
        }
        set {
            var frame = self.base.frame
            frame.origin.x = newValue
            self.base.frame = frame
        }
    }
    
    var right: CGFloat {
        get {
            return self.base.frame.origin.x + self.base.frame.size.width
        }
        set {
            var frame = self.base.frame
            frame.origin.x = newValue - self.base.frame.size.width
            self.base.frame = frame
        }
    }
    
    
    var top: CGFloat {
        get {
            return self.base.frame.origin.y
        }
        set {
            var frame = self.base.frame
            frame.origin.y = newValue
            self.base.frame = frame
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.top + self.height
        }
        set {
            var frame = self.base.frame
            frame.origin.y = newValue - self.height
            self.base.frame = frame
        }
    }
    
    var width: CGFloat {
        get {
            return self.base.frame.size.width
        }
        set {
            var frame = self.base.frame
            frame.size.width = newValue
            self.base.frame = frame
        }
    }
    
    var height: CGFloat {
        get {
            return self.base.frame.size.height
        }
        set {
            var frame = self.base.frame
            frame.size.height = newValue
            self.base.frame = frame
        }
    }
    
    
    
    
    var centerX: CGFloat {
        get {
            return self.base.frame.origin.x + self.base.frame.size.width * 0.5
        }
        set {
            var frame = self.base.frame
            frame.origin.x = newValue - frame.size.width * 0.5
            self.base.frame = frame
        }
    }
    
    
    var centerY: CGFloat {
        get {
            return self.base.frame.origin.y + self.base.frame.size.height * 0.5
        }
        set {
            var frame = self.base.frame
            frame.origin.y = newValue - self.base.frame.size.height * 0.5
        }
    }
    
    
    var center: CGPoint {
        get {
            return CGPoint(x: self.base.frame.origin.x + self.base.frame.size.width * 0.5, y: self.base.frame.origin.y + self.base.frame.size.height * 0.5)
        }
        set {
            var frame = self.base.frame
            frame.origin.x = newValue.x - frame.size.width * 0.5
            frame.origin.y = newValue.y - frame.size.height * 0.5
            self.base.frame = frame
            
        }
    }
    
    var origin: CGPoint {
        get {
            return self.base.frame.origin
        }
        set {
            var frame = self.base.frame
            frame.origin = newValue
            self.base.frame = frame
        }
    }
    
    var size: CGSize {
        get {
            return self.base.frame.size
        }
        set {
            var frame = self.base.frame
            frame.size = newValue
            self.base.frame = frame
        }
    }
    
    // MARK: - 旋转
    var transformRotation: CGFloat {
        get {
            return self.base.value(forKeyPath: "transform.rotation") as! CGFloat
        }
        set {
            self.base.setValue(newValue, forKeyPath: "transform.rotation")
        }
    }
    
    var transformRotationX: CGFloat {
        get {
            return self.base.value(forKeyPath: "transform.rotation.x") as! CGFloat
        }
        set {
            self.base.setValue(newValue, forKeyPath: "transform.rotation.x")
        }
    }
    
    var transformRotationY: CGFloat {
        get {
            return self.base.value(forKeyPath: "transform.rotation.y") as! CGFloat
        }
        set {
            self.base.setValue(newValue, forKeyPath: "transform.rotation.y")
        }
    }
    
    var transformRotationZ: CGFloat {
        get {
            return self.base.value(forKeyPath: "transform.rotation.z") as! CGFloat
        }
        set {
            self.base.setValue(newValue, forKeyPath: "transform.rotation.z")
        }
    }
    
    func rotationX(_ x: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.swe.toRadians, 1.0, 0.0, 0.0)
        self.base.transform = transform
    }
    
    func rotationY(_ y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, y.swe.toRadians, 0.0, 1.0, 0.0)
        self.base.transform = transform
    }
    
    func rotationZ(_ z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, z.swe.toRadians, 0.0, 0.0, 1.0)
        self.base.transform = transform
    }
    
    func rotation(x: CGFloat, y: CGFloat, z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.swe.toRadians, 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, y.swe.toRadians, 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, z.swe.toRadians, 0.0, 0.0, 1.0)
        self.base.transform = transform
    }
    
    // MARK: - 缩放
    var transformScale: CGFloat {
        get {
            return self.base.value(forKeyPath: "transform.scale") as! CGFloat
        }
        set {
            self.base.setValue(newValue, forKeyPath: "transform.scale")
        }
    }
    
    var transformScaleX: CGFloat {
        get {
            return self.base.value(forKeyPath: "transform.scale.x") as! CGFloat
        }
        set {
            self.base.setValue(newValue, forKeyPath: "transform.scale.x")
        }
    }
    
    var transformScaleY: CGFloat {
        get {
            return self.base.value(forKeyPath: "transform.scale.y") as! CGFloat
        }
        set {
            self.base.setValue(newValue, forKeyPath: "transform.scale.y")
        }
    }
    
    var transformScaleZ: CGFloat {
        get {
            return self.base.value(forKeyPath: "transform.scale.z") as! CGFloat
        }
        set {
            self.base.setValue(newValue, forKeyPath: "transform.scale.z")
        }
    }
    
    func scale(x: CGFloat = 1.0, y: CGFloat = 1.0, z: CGFloat = 1.0) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, z)
        self.base.transform = transform
    }
    
    
    // MARK: - 平移
    var transformTranslationX: CGFloat {
        get {
            return self.base.value(forKeyPath: "transform.translation.x") as! CGFloat
        }
        set {
            self.base.setValue(newValue, forKeyPath: "transform.translation.x")
        }
    }
    
    var transformTranslationY: CGFloat {
        get {
            return self.base.value(forKeyPath: "transform.translation.y") as! CGFloat
        }
        set {
            self.base.setValue(newValue, forKeyPath: "transform.translation.y")
        }
    }
    
    var transformTranslationZ: CGFloat {
        get {
            return self.base.value(forKeyPath: "transform.translation.z") as! CGFloat
        }
        set {
            self.base.setValue(newValue, forKeyPath: "transform.translation.z")
        }
    }
    
    func translation(x: CGFloat = 0.0, y: CGFloat = 0.0, z: CGFloat = 0.0) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DTranslate(transform, x, y, z)
        self.base.transform = transform
    }
    
    var transformDepth: CGFloat {
        get {
            return self.base.transform.m34
        }
        set {
            var d = self.base.transform
            d.m34 = newValue
            self.base.transform = d
        }
    }
    
    // MARK: - 设置图片
    var image: UIImage? {
        set {
            self.base.contents = newValue?.cgImage
        }
        
        get {
            guard let cgImage = self.base.contents else {
                return nil
            }
            return UIImage(cgImage: cgImage as! CGImage)
        }
    }
}
