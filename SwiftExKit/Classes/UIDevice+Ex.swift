//
//  UIDevice+Ex.swift
//  SwiftExKit
//
//  Created by yangyb on 1/4/21.
//

import UIKit

public extension SwiftExKit where Base: UIDevice {
    /// uuid
    static var idForVendor: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }

    /// 设备名字
    static var systemName: String {
        return UIDevice.current.systemName
    }
    /// 地方型号  （国际化区域名称）
    static var localizedModel: String {
        return UIDevice.current.localizedModel
    }

    /// 系统版本
    static var systemVersion: String {
        return UIDevice.current.systemVersion
    }

    /// 系统版本
    static var systemFloatVersion: Float {
        return systemVersion.swe.floatValue ?? 0
    }

    /// 设备别名
    static var deviceName: String {
        return UIDevice.current.name
    }

    /// 设备语言
    static var deviceLanguage: String {
        return Bundle.main.preferredLocalizations[0]
    }

    
    /// 是否是iphone
    static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }

    /// 是否是ipad
    static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    /// 获取系统信息
    static func getSysInfo(_ typeSpecifier: Int32) -> Int {
        var size = MemoryLayout<Int>.size
        var results = 0
        var mib = [CTL_HW, typeSpecifier]
        sysctl(&mib, 2, &results, &size, nil, 0)
        return results
    }
    
    /// 获取cpu个数
    static var cupCount: Int {
        return self.getSysInfo(HW_NCPU)
    }
    /// CPU 频率
    static var cpuFrequency: Int {
        return self.getSysInfo(HW_CPU_FREQ)
    }
    /// 总线频率
    static var busFrequency: Int {
        return self.getSysInfo(HW_BUS_FREQ)
    }
    /// 总内存
    static var totalMemory: Int {
        return self.getSysInfo(HW_PHYSMEM)
    }
    /// 内核内存
    static var userMemory: Int {
        return self.getSysInfo(HW_USERMEM)
    }
    /// 缓存行大小
    static var cacheLine: Int {
        return self.getSysInfo(HW_CACHELINE)
    }
    /// L1 I 缓存大小
    static var L1ICacheSize: Int {
        return self.getSysInfo(HW_L1ICACHESIZE)
    }
    
    /// L1 D 缓存大小
    static var L1DCacheSize: Int {
        return self.getSysInfo(HW_L1DCACHESIZE)
    }
    /// L2 缓存大小
    static var L2CacheSize: Int {
        return self.getSysInfo(HW_L2CACHESIZE)
    }
    /// L3 缓存大小
    static var L3CacheSize: Int {
        return self.getSysInfo(HW_L3CACHESIZE)
    }
    

}


