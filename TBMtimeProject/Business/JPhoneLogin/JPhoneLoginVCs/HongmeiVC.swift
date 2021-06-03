//
//  HongmeiVC.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2021/2/25.
//

import UIKit
import Foundation
import TBMtimeBaseControll

class HongmeiVC: MNFBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .red
        
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = .green
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        view.addSubview(btn)
    
    }
    
    @objc func btnAction () {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.isHidden = false
    }

}
