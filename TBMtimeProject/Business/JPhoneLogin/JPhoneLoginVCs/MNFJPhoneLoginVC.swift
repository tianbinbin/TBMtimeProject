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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        JPPhoneLogin.getAuthorization(self)
    }
    
    @IBAction func btnAction(_ sender: Any) {
            
    }
}

