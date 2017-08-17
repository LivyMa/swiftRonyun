//
//  LWClassinfo.swift
//  Ibsattendance_swift
//
//  Created by 融商科技 on 2017/7/28.
//  Copyright © 2017年 融商科技. All rights reserved.
//

import UIKit


/**
 Type encoding's type.
 */

struct LWEncodingType : OptionSet {
    let rawValue: UInt
    
    static let LWEncodingTypeMask  = LWEncodingType(rawValue: 0xFF)
    static let LWEncodingTypeUnknown = LWEncodingType(rawValue: 0)
    static let LWEncodingTypeVoid  = LWEncodingType(rawValue: 1)
    static let LWEncodingTypeBool  = LWEncodingType(rawValue: 2)
    static let LWEncodingTypeInt8  = LWEncodingType(rawValue: 3)
    static let LWEncodingTypeUInt8  = LWEncodingType(rawValue: 4)
    static let LWEncodingTypeInt16  = LWEncodingType(rawValue: 5)
    static let LWEncodingTypeUInt16  = LWEncodingType(rawValue: 6)
    static let LWEncodingTypeInt32  = LWEncodingType(rawValue: 7)
    static let LWEncodingTypeUInt32  = LWEncodingType(rawValue: 8)
    static let LWEncodingTypeInt64  = LWEncodingType(rawValue: 9)
    static let LWEncodingTypeUInt64  = LWEncodingType(rawValue: 10)
    static let LWEncodingTypeFloat  = LWEncodingType(rawValue: 11)
    static let LWEncodingTypeDouble  = LWEncodingType(rawValue: 12)
    static let LWEncodingTypeLongDouble  = LWEncodingType(rawValue: 13)
    static let LWEncodingTypeObject  = LWEncodingType(rawValue: 14)
    static let LWEncodingTypeClass  = LWEncodingType(rawValue: 15)
    static let LWEncodingTypeSEL  = LWEncodingType(rawValue: 16)
    static let LWEncodingTypeBlock  = LWEncodingType(rawValue: 17)
    static let LWEncodingTypePointer  = LWEncodingType(rawValue: 18)
    static let LWEncodingTypeStruct  = LWEncodingType(rawValue: 19)
    static let LWEncodingTypeUnion  = LWEncodingType(rawValue: 20)
    static let LWEncodingTypeCString  = LWEncodingType(rawValue: 21)
    static let LWEncodingTypeCArray  = LWEncodingType(rawValue: 22)
    
    static let LWEncodingTypeQualifierMask  = LWEncodingType(rawValue: 0xFF00)
    static let LWEncodingTypeQualifierConst  = LWEncodingType(rawValue: 1 << 8)
    static let LWEncodingTypeQualifierIn  = LWEncodingType(rawValue: 1 << 9)
    static let LWEncodingTypeQualifierInout  = LWEncodingType(rawValue: 1 << 10)
    static let LWEncodingTypeQualifierOut  = LWEncodingType(rawValue: 1 << 11)
    static let LWEncodingTypeQualifierBycopy  = LWEncodingType(rawValue: 1 << 12)
    static let LWEncodingTypeQualifierByref  = LWEncodingType(rawValue: 1 << 13)
    static let LWEncodingTypeQualifierOneway  = LWEncodingType(rawValue: 1 << 14)
    
    static let LWEncodingTypePropertyMask  = LWEncodingType(rawValue: 0xFF0000)
    static let LWEncodingTypePropertyReadonly  = LWEncodingType(rawValue: 1 << 16)
    static let LWEncodingTypePropertyCopy  = LWEncodingType(rawValue: 1 << 17)
    static let LWEncodingTypePropertyRetain  = LWEncodingType(rawValue: 1 << 18)
    static let LWEncodingTypePropertyNonatomic  = LWEncodingType(rawValue: 1 << 19)
    static let LWEncodingTypePropertyWeak  = LWEncodingType(rawValue: 1 << 20)
    static let LWEncodingTypePropertyCustomGetter  = LWEncodingType(rawValue: 1 << 21)
    static let LWEncodingTypePropertyCustomSetter  = LWEncodingType(rawValue: 1 << 22)
    static let LWEncodingTypePropertyDynamic  = LWEncodingType(rawValue: 1 << 23)
    
}

class LWClassinfo: NSObject {
    
    var cls :AnyClass?  /// class object
    var superCls: AnyClass?
    var metaCls: AnyClass?
    var isMeta: Bool?
    var name :String?
    var superClsInfo: LWClassinfo?
    var ivarInfos: Dictionary<String, LWClassIvarInfo>?
    var methodInfos: Dictionary<String, LWClassIvarInfo>?
    var propertyInfos: Dictionary<String, LWClassIvarInfo>?
}


class LWClassIvarInfo: NSObject {
    var ivar: Ivar?
    var name: String?
    var offset: ptrdiff_t?
    var typeEncoding: NSString?
    var type: LWEncodingType?
    
    
    init?(ivar: Ivar) {
        self.ivar = ivar
        if let name = ivar_getName(ivar) {
            self.name = String.init(describing: name)
        }
        self.offset = ivar_getOffset(ivar)
        if let typeEncoding = ivar_getTypeEncoding(ivar) {
            self.typeEncoding = String.init(describing: typeEncoding) as NSString
        }
        
        print()
        print(self.name ?? "name: nil")
        print(self.offset ?? "offset: nil")
        print(self.typeEncoding ?? "type: nil")
    }
}


class LWClassMethodInfo: NSObject {
    var method: Method?
    var name: String?
    var sel: Selector?
    var imp: IMP?
    var typeEncoding: String?
    var returnTypeEncoding: String?
    var argumentTypeEncodings: Array<String>?
    
    init(method: Method) {
        self.method = method;
        self.sel = method_getName(method)
        self.imp = method_getImplementation(method)
        if let name = sel_getName(self.sel) {
            self.name = String.init(utf8String: name);
        }
        if let typeEncoding = method_getTypeEncoding(method) {
            self.typeEncoding = String.init(utf8String: typeEncoding);
        }
        if let returnType = method_copyReturnType(method) {
            self.returnTypeEncoding = String.init(utf8String: returnType);
        }
        let argumentCount = method_getNumberOfArguments(method)
        if argumentCount > 0 {
            let argumentTypes: NSMutableArray = NSMutableArray()
            for i in 0..<argumentCount {
                if let argumentType = method_copyArgumentType(method, i) {
                    if let type: String = String.init(utf8String: argumentType) {
                        argumentTypes .add(type)
                        free(argumentType)
                    }else {
                        argumentTypes .add("")
                    }
                }
            }
            self.argumentTypeEncodings = argumentTypes as? Array<String>
        }
    }
}

class YYClassPropertyInfo: NSObject {
    private(set) var property: objc_property_t?
    private(set) var name: String?
    private(set) var type: LWEncodingType?
    private(set) var typeEncoding: String?
    private(set) var ivarName: String?
    private(set) var cls: AnyClass?
    private(set) var protocols: Array<String>?
    private(set) var getter: Selector?
    private(set) var setter: Selector?
    
    init(property: objc_property_t) {
        self.property = property
        if let name = property_getName(property) {
            self.name = String.init(describing: name)
        }
        
        var type: LWEncodingType = LWEncodingType(rawValue: 0)
        var attrCount: UInt32 = 0;
        var attrs = property_copyAttributeList(property, &attrCount)
        for i in 0..<attrCount {
            if let attr = attrs?[Int(i)] {
                
                if let char = String.init(utf8String: attr.name) {
                    switch char {
                    case <#pattern#>:
                        <#code#>
                    default:
                        <#code#>
                    }
                }

            }
        }
    }
    

    

}

