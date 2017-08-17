//
//  UserInfo.swift
//  Ibsattendance_swift
//
//  Created by 融商科技 on 2017/7/20.
//  Copyright © 2017年 融商科技. All rights reserved.
//

import UIKit


class UserInfo: NSObject {
    
    // 请求结果 可不计
    var RESULT:Int?
    
    // 私钥
    var PK: String?
    
    // 工资条
    var SALARY: Bool?
    
    // 功能授权
    var PERMS: RSPerms?

    // 员工信息
    var STAFFINFO: RSStaffinfo?
    
    // WIFI 列表
    var WIFI: Array<Any>?
    
    // GPS
    var GPS: Array<GPS>?
    
    // 常用短语
    var REMARKS: Array<String>?

    override func setClasstype() -> Dictionary<String, Any>? {
        return [
            "STAFFINFO" : "RSStaffinfo",
            "GPS" : "<GPS>",
        ]
    }
    
}


// MARK - 功能授权
class RSPerms: NSObject {
    // 考勤
    var ATT: Bool?
    
    // 监管
    var MAN: Bool?
    
    // OA
    var OA: Bool?
    
    // 请假
    var LB: Bool?
    
    //加班
    var OT: Bool?
}


// MARK - 员工信息
class RSStaffinfo: NSObject {
    // ID
    var StaffID: String?
    
    // 工号
    var StaffNo: String?
    
    // 姓名
    var Name: String?
    
    // name拼音
    var py: String?
    
    // 职位
    var Position: String?
    
    // 考勤标号
    var AttNo: String?
    
    // 离职时间
    var ResignDate: String?
}


// MARK - 考勤参数
class RSAttPARAMS: NSObject {

    // 打卡间隔时间
    var AlertRec: Int?
    
    // 上传照片设置 0:不上传 1:上传
    var UploadPhoto: Int?
    
    // 账号状态 1:正常 2:离职
    var AppStatus: Int?
    
    // 保存考勤记录最大天数 默认:7天
    var MaxReservedDays: Int?
    
    // 考勤模式 1:WIFI 2:GPS 3:以上两种
    var AttMode: Int?
    
    // 非固定地点打卡 0:不允许 1:允许
    var UploadLoc: Int?
    
    // 拍照模式 0:关闭 1:自拍 2:场景拍 3:自拍+场景拍 10:自选模式
    var AppPhoto: Int?
}


// MARK - GPS
class GPS {
    
    // 坐标
    var location: GpsLocation?
    
    // 地点编号
    var pid: String?
    
    // 地点名称
    var name: String?
    
    // 坐标类型代码
    var coordtype: Int?
    
    // 半径(m)
    var radius: Int?
    
    // 距离
    var distance: Double?
}


struct GpsLocation {
    // 经度
    var lng: Double?
    // 纬度
    var lat: Double?
}

