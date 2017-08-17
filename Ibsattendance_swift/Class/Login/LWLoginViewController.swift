//
//  LWLoginViewController.swift
//  Ibsattendance_swift
//
//  Created by 融商科技 on 2017/6/15.
//  Copyright © 2017年 融商科技. All rights reserved.
//

import UIKit
import Alamofire


let codeLength: Int = 6
let falseImageWH = 12.0

class LWLoginViewController: LWBaseViewController, UITextFieldDelegate {
    
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var promptLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var landingView: UIActivityIndicatorView!
    
    var errorCode: String?
    
    
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        if let dict =  UserDefaults.standard.object(forKey: "UserInfo") {
            let userInfo: UserInfo = UserInfo.lw_model(dict: dict as! Dictionary<String, Any>) as! UserInfo
            print(userInfo.PK ?? "没有数据")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        codeTextField.resignFirstResponder()
    }
    
    
    // MARK: -
    func setUI() {
        loginButton.isEnabled = false
        promptLabel.isHidden = true
        landingView.isHidden = true
        codeTextField.delegate = self
        codeTextField.returnKeyType = UIReturnKeyType.send
        codeTextField.keyboardType = .numbersAndPunctuation
        
        let imageAttachment :NSTextAttachment = NSTextAttachment()
        imageAttachment.image = #imageLiteral(resourceName: "false_res")
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: falseImageWH, height: falseImageWH)
        let falseMassage : NSAttributedString = NSAttributedString(string: "  验证码格式错误.(字母/数字)", attributes: [NSForegroundColorAttributeName : UIColor.red, NSFontAttributeName : UIFont.systemFont(ofSize: 11.0)])
        let attributedStr : NSMutableAttributedString = NSMutableAttributedString()
        attributedStr.append(NSAttributedString(attachment: imageAttachment))
        attributedStr.append(falseMassage)
        promptLabel.attributedText = attributedStr
    }

    @IBAction func loginButtonClick(_ sender: Any) {
        login(code: codeTextField.text!)
    }
    
    // MARK: - network
    func login(code: String) {
        if !regular(code: code) {
            return
        }
        
        landingView.isHidden = false
        landingView.startAnimating()
        
        let deviceInfo: NSMutableDictionary = Device.currentDevice.deviceInfo()
        deviceInfo.setValue(code, forKey: "CODE")
        let data = try? JSONSerialization.data(withJSONObject: deviceInfo, options: []) as NSData!
        let base64Sting : String = (data?.base64EncodedString(options: []))!
        let urlString = "\(TheApiAddress)?CLID=\(Device.currentDevice.clid)&CMD=CLAK&_p=\(base64Sting)&_en=app2"
        
        Alamofire.request(urlString).responseJSON { response in
            
            self.landingView.isHidden = true
            self.landingView.stopAnimating()
            
            if let base64Str = response.data {
            let data = Data.init(base64Encoded: base64Str)
                if  let dict: Dictionary = try? JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, Any> {
                    if let error: String = dict["ERROR"] as? String{
                        let errorStr = LWErrorCode.errorCode(errorCode: ErrorCode(rawValue: Int(error)!)!)
                        print(errorStr)
                    }else {
                        UserDefaults.standard.set(dict, forKey: "UserInfo")
                    }
                }
            }else {
                print(response.error ?? "not error")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        promptLabel.isHidden = true
    }
    
    func regular(code: String) -> Bool {
        let regularStr = "^[0-9a-zA-Z]$"
        let results = try!NSRegularExpression(pattern: regularStr, options: .caseInsensitive)
        let res = results.matches(in: code,
                                  options: .reportProgress,
                                  range: NSMakeRange(0, code.characters.count))
        if res.count > 0 {
            return false
        }
        return true
    }
    
    // 跳转页面
    func pushViewController(code: Int) {
        if let errorCode: ErrorCode = ErrorCode(rawValue: code) {
            self.errorCode = LWErrorCode.errorCode(errorCode: errorCode)
            self.shouldPerformSegue(withIdentifier: "loginError", sender: self)
        }else {
            self.shouldPerformSegue(withIdentifier: "loginDone", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller: LWLoginErrorViewController = segue.destination as? LWLoginErrorViewController {
            controller.errorCode = self.errorCode ?? nil
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        promptLabel.isHidden = true
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
    }
    
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        print(#function)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text!.characters.count >= codeLength && string.characters.count > 0 {
            return false
        }
        
        if string.characters.count > 0 {
            if textField.text!.characters.count + 1 == codeLength {
                loginButton.isEnabled = true
            }else {
                loginButton.isEnabled = false
            }
        }else {
            loginButton.isEnabled = false
        }
        
        if self.regular(code: textField.text!) {
            promptLabel.isHidden = true
        }else {
            promptLabel.isHidden = false
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        promptLabel.isHidden = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        codeTextField.resignFirstResponder()
        login(code: textField.text!)
        return true
    }
}
