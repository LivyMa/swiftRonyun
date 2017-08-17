//
//  LWDeviceInfo.swift
//  Ibsattendance_swift
//
//  Created by 融商科技 on 2017/7/19.
//  Copyright © 2017年 融商科技. All rights reserved.
//

import UIKit

class Device {
    static let currentDevice = LWDeviceInfo()
}

class LWDeviceInfo: NSObject {
    
    //systemName  系统
    let os : String = "iOS"
    
    //systemVersion 系统版本号
    let version : String = UIDevice.current.systemVersion
    
    // @"Apple"  制造商
    let manu : String = "Apple"
    
    //model   iPhone  型号
    let model : String = UIDevice.current.model
    
    // iPhone 8,4 具体型号
    let hardware : String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()
    
    // 设备唯一标识
    let clid : String = {
        var uuid : String = (UIDevice.current.identifierForVendor?.uuidString)!
        uuid = "64620F744B6A40FEB888EB95B40B3243"
        return uuid.replacingOccurrences(of: "-", with: "")
    }()

    func deviceInfo() -> NSMutableDictionary {
        let deviceInfo : NSMutableDictionary = NSMutableDictionary()
        let time = "\((Int)(NSDate().timeIntervalSince1970))"
        
        deviceInfo .setValue(clid, forKey: "CLID")
        deviceInfo .setValue(clid+time, forKey: "_s")
        deviceInfo .setValue(os, forKey: "OS")
        deviceInfo .setValue(version, forKey: "OSVersion")
        deviceInfo .setValue(manu, forKey: "MANU")
        deviceInfo .setValue(model, forKey: "MODEL")
        deviceInfo .setValue(hardware, forKey: "HW")

        return deviceInfo
    }
}
