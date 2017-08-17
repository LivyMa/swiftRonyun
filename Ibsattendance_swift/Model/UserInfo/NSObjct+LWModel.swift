//
//  NSObjct+LWModel.swift
//  Ibsattendance_swift
//
//  Created by 融商科技 on 2017/7/20.
//  Copyright © 2017年 融商科技. All rights reserved.
//

import Foundation

extension NSObject {
    /**
        字典转模型
     */
    public class func lw_model(json: Any) -> Any? {
        let dict = json
        return lw_model(dict: dict as! Dictionary<String, Any>)
    }
    
    public class func lw_model(dict: Dictionary<String, Any>) -> Any? {
        if dict.isEmpty { return nil }
        let objc = self.init()
        
        let clsName: AnyClass = self.classForCoder()
        print("类名: \(clsName)")
        var count: UInt32 = 0;
        let ivars = class_copyIvarList(clsName, &count)
        
        for i in 0..<count {
            if let ivar: Ivar = ivars?[Int(i)] {
                let _: LWClassIvarInfo = LWClassIvarInfo.init(ivar: ivar)!
            }
            
            
            
            
            
//            var propertyType = String.init(cString: property_getAttributes(property))
//            let propertyKey = String.init(cString: property_getName(property))
//
//            if propertyKey == "description"{ continue }
//            let value: AnyObject = dict[propertyKey] as AnyObject
//
//            propertyType = propertyType.substring(from: propertyType.index(propertyType.startIndex, offsetBy: 3))
//            let character =  propertyType.characters.index(of: "\"")
//            propertyType = propertyType.substring(to: character!)
//
//            propertyMeta.type = propertyMeta.classType(type: propertyType)
//            propertyMeta.name = propertyKey
////            propertyMeta.cls = value.classForCoder
//
//
//            if let dict = objc.setClasstype() {
//                if let str = dict[propertyMeta.name!] {
//                    propertyMeta.cls = str as? String
//                }
//            }
//
//            propertyMeta.value = value
//            print("propertyType: "+propertyType)
//            print("propertyKey: "+propertyKey)
//            print(value.classForCoder)
//            print(value)
//            print(propertyMeta.cls ?? "nil")
//
//            propertyMeta.setVelue(classType: objc)
            
        }
        free(ivars)
        
//        var propertyCount: UInt32 = 0;
//        let properties = class_copyPropertyList(cls, &propertyCount);
//        for i in 0..<propertyCount {
//            if let property: objc_property_t = properties?[Int(i)] {
//                let MethodInfo: LWClassMethodInfo = LWClassMethodInfo.init(property: property)
//            }
//        }
        return objc
    }
    
    


    
    
    func setClasstype() -> Dictionary<String, Any>? {
        return nil
    }
}

// NS数据类型
enum classType {
    case LWEncodingTypeUnknown
    case LWEncodingTypeString
    case LWEncodingTypeNSMutableString
    case LWEncodingTypeValue
    case LWEncodingTypeNumber
    case LWEncodingTypeNSDecimalNumber
    case LWEncodingTypeData
    case LWEncodingTypeNSMutableData
    case LWEncodingTypeDate
    case LWEncodingTypeNSURL
    case LWEncodingTypeArray
    case LWEncodingTypeNSMutableArray
    case LWEncodingTypeDictionary
    case LWEncodingTypeNSMutableDictionary
    case LWEncodingTypeNSSet
    case LWEncodingTypeNSMutableSet
}







class ModelPropertyMeta {
    // 属性的name
    var name: String?
    
    // 属性的类型
    var type: classType?
    
    // Json对应的数据类型
    var JScls: AnyClass?
    
    // 属性对应的数据类型
    var cls: String?
    
    // 嵌套类型
    var next: ModelPropertyMeta?
    
    // value
    var value: Any?
    
    
    func setVelue(classType: NSObject) {
        
        switch self.type! {
            case .LWEncodingTypeString, .LWEncodingTypeNumber, .LWEncodingTypeValue, .LWEncodingTypeNSMutableString, .LWEncodingTypeNSDecimalNumber:
                classType.setValue(self.value, forKey: self.name!)
            
            case .LWEncodingTypeNSURL:
                let url = URL.init(string: self.value as! String)
                classType.setValue(url, forKey: self.name!)
            
            
            default:
                break
            
        }
        
    }
    


    func classType(type: String) -> classType {
        
        if type == "NSString" { return .LWEncodingTypeString }
        if type == "NSString" { return .LWEncodingTypeNumber }
        if type == "NSString" { return .LWEncodingTypeValue }
        if type == "NSString" { return .LWEncodingTypeData }
        if type == "NSString" { return .LWEncodingTypeDate }
        if type == "NSString" { return .LWEncodingTypeNSURL }
        if type == "NSString" { return .LWEncodingTypeArray }
        if type == "NSString" { return .LWEncodingTypeNSMutableString }
        if type == "NSString" { return .LWEncodingTypeNSDecimalNumber }
        if type == "NSString" { return .LWEncodingTypeNSMutableData }
        if type == "NSString" { return .LWEncodingTypeNSMutableArray }
        if type == "NSString" { return .LWEncodingTypeNSMutableDictionary }
        if type == "NSString" { return .LWEncodingTypeNSMutableSet }
        return .LWEncodingTypeUnknown
    }
    
    
    func stringClassFromString(className: String) -> AnyClass! {
        
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        
        let cls: AnyClass = NSClassFromString(namespace + "." + className)!;
        
        return cls;
    }
}


