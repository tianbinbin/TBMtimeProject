//
//  EggsView.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2020/12/23.
//

import UIKit
import Foundation

enum EnumeEggsType: Int {
    case share = 10
}

/// 注意此处的业务前提必须登录
public class EggsView: UIView {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var eggsImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var guanbiButton: UIButton!
    @IBOutlet weak var fixedCopyWriterLabel: UILabel!
    @IBOutlet weak var awardWinningcopyWriterLabel: UILabel!
        
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        closeButton.isHidden = true
        eggsImageView.isHidden = true
        backView.isHidden = true
        backView.layer.cornerRadius = 15
        backView.clipsToBounds = true
    }
    
    /// 关闭整个彩蛋的业务
    @IBAction func closeBtnAction(_ sender: Any) {
        
    }

}

// MARK: 彩蛋相关的一些业务
extension EggsView {
    /// 彩蛋业务
    public class func eggsOutOfBusiness() {
      /// 1、0 请求接口是否展示彩蛋页面
        
        
      /// 2、0 展示彩蛋
    }
    
    
}
