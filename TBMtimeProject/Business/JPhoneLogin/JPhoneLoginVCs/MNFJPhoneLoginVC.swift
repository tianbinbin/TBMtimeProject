//
//  MNFJPhoneLoginVC.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2021/1/19.
//

import UIKit
import Foundation
import TBMtimeBaseControll

class MNFJPhoneLoginVC: MNFBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        JPPhoneLogin.congfigPhoneLoginFullScreenUI()
        
//        customWindowUI()
    }
    @IBAction func btnAction(_ sender: Any) {
        
        JVERIFICATIONService.getAuthorizationWith(self, hide: true, animated: true, timeout: 15*1000, completion: { (result) in
            if let result = result {
                if let token = result["loginToken"] {
                    if let code = result["code"], let op = result["operator"] {
                        print("一键登录 result: code = \(code), operator = \(op), loginToken = \(token)")
                        }
                }else if let code = result["code"], let content = result["content"] {
                    print("一键登录 result: code = \(code), content = \(content)")
                }
            }
        }) { (type, content) in
            if let content = content {
                print("一键登录 actionBlock :type = \(type), content = \(content)")
            }
        }
    }
}


extension MNFJPhoneLoginVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        JPPhoneLogin.getAuthorization(self)
    }
}

