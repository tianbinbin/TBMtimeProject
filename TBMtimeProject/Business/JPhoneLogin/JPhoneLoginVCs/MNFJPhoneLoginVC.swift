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
        JPPhoneLogin.getAuthorization(self) { [weak self] (intCode) in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func btnAction(_ sender: Any) {
        JPPhoneLogin.getToken()
    }
}

