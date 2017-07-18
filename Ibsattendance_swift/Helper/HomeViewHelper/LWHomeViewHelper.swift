//
//  LWHomeViewHelper.swift
//  Ibsattendance_swift
//
//  Created by 融商科技 on 2017/6/15.
//  Copyright © 2017年 融商科技. All rights reserved.
//

import UIKit

class LWHomeViewHelper: NSObject {
    
    
    //MARK:- 设置 APP rootViewController
    class func setHomeView(isLogin: Bool) -> LWBaseNavigationViewController {
        let viewController : UIViewController = setHomeViewController(isLogin: isLogin)
        return LWBaseNavigationViewController.init(rootViewController: viewController)
    }
    
    class func setHomeViewController(isLogin: Bool) -> UIViewController {
        if isLogin {
            return loadViewControllerFormStoryboard(sbName: "LWLoginStoryboard")
        }else {
            return loadViewControllerFormStoryboard(sbName: "LWLoginStoryboard")
        }
    }
    
     class func loadViewControllerFormStoryboard(sbName: String) -> UIViewController {
        let viewController = UIStoryboard.init(name: sbName, bundle: nil).instantiateInitialViewController()
        return viewController!
    }
    
}
