//
//  MNFHomeVC.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2020/12/29.
//

import TBMtimeBaseControll

class MNFHomeVC:MNFBaseViewController {
    
    lazy var imageView:UIImageView = {
        
        /// 组件话开发离不开bundle
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 300))
        imageView.image = R.image.icon_eggsShow()
        imageView.backgroundColor = .orange        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
    }
}
