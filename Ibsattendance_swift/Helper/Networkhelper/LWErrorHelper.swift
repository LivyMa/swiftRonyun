//
//  LWErrorHelper.swift
//  Ibsattendance_swift
//
//  Created by 融商科技 on 2017/7/20.
//  Copyright © 2017年 融商科技. All rights reserved.
//

import UIKit

enum ErrorCode: Int {
    case clidError      = 001       // 通用
    case formatError    = 002
    case unknownError   = 003
    case parameterMiss  = 004
    case uncheckedError = 005
    case resignError    = 006
    case codeError      = 101       // login
    case CLIDError      = 102
}

class LWErrorCode: NSObject {
    class func errorCode(errorCode: ErrorCode) -> String {
        switch errorCode {
        case .clidError:
            return "身份验证错误，CLID不存在或者_S中CLID验证失败。 code: \(errorCode.rawValue)"
        case .formatError:
            return "数据格式错误，一般是加密或编码错误导致。 code: \(errorCode.rawValue)"
        case .unknownError:
            return "未知请求，一般是CMD命令不正确。 code: \(errorCode.rawValue)"
        case .parameterMiss:
            return "缺少参数，一般是_p中缺少必选项。 code: \(errorCode.rawValue)"
        case .uncheckedError:
            return "服务器内部错误，一般是有unchecked异常，需要联系AS。 code: \(errorCode.rawValue)"
        case .resignError:
            return "请求时间戳超过允许范围。一般是_s中的UTC时间戳超过了5分钟的浮动范围。 code: \(errorCode.rawValue)"
        case .codeError:
            return "激活码无效，激活CODE不存在。 code: \(errorCode.rawValue)"
        case .CLIDError:
            return "该CLID已被激活，不允许再次激活。如果需要必须联系平台管理员重置该员工的APP配置。 code: \(errorCode.rawValue)"
        }
    }
}
