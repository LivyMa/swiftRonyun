//
//  LWLoginViewController.swift
//  Ibsattendance_swift
//
//  Created by 融商科技 on 2017/6/15.
//  Copyright © 2017年 融商科技. All rights reserved.
//

import UIKit
import Alamofire


class LWLoginViewController: LWBaseViewController, UITextFieldDelegate {
    
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var promptLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promptLabel.isHidden = true
        codeTextField.delegate = self
        codeTextField.returnKeyType = UIReturnKeyType.send
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonClick(_ sender: Any) {
        login(code: codeTextField.text!)
    }
    
    //MARK: - network
    func login(code: String) {
        if !regular(code: code) {
            return
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        promptLabel.isHidden = true
    }
    
    func regular(code: String) -> Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        codeTextField.resignFirstResponder()
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
        if textField.text!.characters.count >= 6  {
            return false
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
