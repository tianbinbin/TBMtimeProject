//
//  CustomView.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2021/2/25.
//

import Foundation


@objc class BPFBaseCustomNavgationView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
   }
    
    @IBAction func btnActon(_ sender: Any) {
        
        print(" hhhahah")
        
    
        guard let visibleVC = UIWindow.visibleViewController() else {
            return
        }
        
//        let nav = UINavigationController(rootViewController: visibleVC)
        
        print(visibleVC.className)
        
        let vc = HongmeiVC()
        visibleVC.navigationController?.pushViewController(vc, animated: true)

    }
    
    
}
