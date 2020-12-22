//
//  MTBViewController.swift
//  MtimeBaseControll
//
//  Created by 田彬彬 on 2020/12/18.
//

/** 最底层的基类VC
 *  设置一些颜色 以及 导航栏相关的业务 以及 tableView 等 最最基础的业务
 */

import UIKit
import Foundation

open class MTBViewController:UIViewController {
   
    open override func viewDidLoad() {

        configVCUnderlyingInformation()
    }
}

extension MTBViewController {
    
    ///1、0  VC基础配置信息
    open func configVCUnderlyingInformation() {
        self.view.backgroundColor = .green
    }
}


