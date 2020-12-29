//
//  File.swift
//  MtimeBaseControll
//
//  Created by 田彬彬 on 2020/12/10.
//

/**  业务底层VC
 *   处理全局的弹窗 、埋点 、加载动画等等一些与公司相关的公共业务
 *
 */

import UIKit
import Foundation

open class MNFBaseViewController:MTBViewController {
    
    lazy var imageView:UIImageView = {
        
        /// 组件话开发离不开bundle
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
        if let path = Bundle(for: MNFBaseViewController.self).path(forResource: "TBMtimeBaseControll", ofType: "bundle") {
            let bundle = Bundle(path: path)!
            
            imageView.image = R.image.beijing()
            imageView.backgroundColor = .orange
            imageView.isHidden = true
            view.addSubview(imageView)
        }
        return imageView
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}

extension MNFBaseViewController {
    
    /// 1、0 处理所有的埋点统计
    open func buriedSomeStatistical(_ SomeString:String?) {
        print("埋点统计的信息\(SomeString ?? "")")
    }
    
    /// 2、0 页面的跳转 不要用系统的
    open func pushToVC(_ vc:UIViewController?, _ boolAnimate:Bool?) {
        print("跳转到下一个页面")
    }
    
    /// 3、0 显示图片
    open func showImageView(){
        imageView.isHidden = !(imageView.isHidden)
    }
}





