//
//  MNFRxSwiftVC.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2020/12/23.
//

import TBMtimeBaseControll

class MNFRxSwiftVC: MNFBaseViewController {
    
    var countInt = 0
    var labelOne:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
}

extension MNFRxSwiftVC {
    
    /// 搭建页面
    func configUI() {
        labelOne = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 50))
        labelOne?.backgroundColor = .orange
        view.addSubview(labelOne!)
        
    }
    
    func rxSwiftFuction() {
        /// 通知
//        labelOne.
        
    }
}

extension MNFRxSwiftVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        labelOne?.text = "\(countInt+1)"
    }
}
