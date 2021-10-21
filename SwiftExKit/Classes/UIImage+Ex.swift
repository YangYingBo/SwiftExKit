//
//  UIImage+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 12/28/20.
//

import UIKit

public extension SwiftExKit where Base: UIImage {
    /// 获取纯色图片
    static func image(color:UIColor) -> UIImage {
        return self.image(color: color, size: CGSize(width: 1, height: 1))
    }
    
    /// 获取纯色圆角图片
    static func image(color:UIColor, size:CGSize, corner: CGFloat) -> UIImage {
        return self.image(color: color, size: size).swe.imageCorner(corner)
    }
    
    static func image(color:UIColor, size:CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        // 开启一个上下文
        UIGraphicsBeginImageContext(size)
        
        // 获取当前画笔
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        // 获取当前纯色图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return image ?? UIImage()
        
        
    }
    
    // 圆角
    func imageCorner(_ corner: CGFloat) -> UIImage {
        return self.imageCorner(corner, roundingCorners: .allCorners)
    }
    
    func imageCorner(_ corner: CGFloat, roundingCorners: UIRectCorner) -> UIImage {
        
        // 开启一个上下文
        UIGraphicsBeginImageContextWithOptions(self.base.size, false, self.base.scale)
        
        // 获取到画笔
        guard let context = UIGraphicsGetCurrentContext() else {
            return self.base;
        }
        // image frame
        let imageRect = CGRect(x: 0, y: 0, width: self.base.size.width, height: self.base.size.height)
        // 圆角
        let cornerRaddii = CGSize(width: corner, height: corner)
        
        // 创建圆角路径
        let cornerPath = UIBezierPath(roundedRect: imageRect, byRoundingCorners: roundingCorners, cornerRadii: cornerRaddii).cgPath
        // 添加路径
        context.addPath(cornerPath)
        // 沿路径剪切
        context.clip()
        // 重新绘制
        self.base.draw(in: imageRect);
        // 获取绘制的图片
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return self.base;
        }
        
        UIGraphicsEndImageContext()
        
        return image
        
    }
}
