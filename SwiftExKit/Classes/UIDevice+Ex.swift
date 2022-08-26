//
//  UIDevice+Ex.swift
//  Swift类拓展
//
//  Created by yangyb on 1/4/21.
//

import UIKit
import Network

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
        return systemVersion.ex.floatValue ?? 0
    }

    /// 设备别名
    static var deviceName: String {
        return UIDevice.current.name
    }

    /// 手机系统首选的语言
    static var deviceLanguage: String {
        return Bundle.main.preferredLocalizations[0]
    }
    /// 当前手机设置的语言
    static var currentLanguage: String {
        // 获取到首选语言列表
        guard let appLanguages = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String], appLanguages.count > 0 else {
            return deviceLanguage
        }
        // 首选语言第一个就是当前设置语言
        var currentLanguage = appLanguages[0]
        // 地区编码
        let regionCode = Locale.current.regionCode ?? ""
        // 把语言中的地区码移除
        if currentLanguage.contains(regionCode), let range = currentLanguage.range(of: "-\(regionCode)") {
            currentLanguage.removeSubrange(range)
        }
        return currentLanguage
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
    /// 网络连接状态查询
    /// 在使用界面销毁前调用monitor.cancel()关闭网络检查
    @available(macOS 10.14, iOS 12.0, watchOS 5.0, tvOS 12.0, *)
    static func networkMonitor(_ updateBlock: ((_ newPath: NWPath) -> Void)?) -> NWPathMonitor {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = updateBlock
        monitor.start(queue: DispatchQueue.global())
        return monitor 
    }
}


