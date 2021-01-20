//
//  JPPhoneLogin.swift
//  mTime
//
//  Created by 田彬彬 on 2021/1/18.
//  Copyright © 2021 Mtime. All rights reserved.
//

import UIKit
import Foundation
import AdSupport

@objc class JPPhoneLogin: NSObject {
    
    /// 初始化一键登录 设置底层配置
    @objc class func initializeThePhoneToLog() {
        
        let adString = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        let config = JVAuthConfig()
        config.appKey = "27f270b0252e1a33d74a7747"
        config.channel = "testChannel"
        config.advertisingId = adString
        config.isProduction = false;
        config.timeout = 5000;
        config.authBlock = { (result) -> Void in
            if let result = result {
                if let code = result["code"], let content = result["content"] {
                     print("初始化结果 result: code = \(code), content = \(content)")
                }
            }
        }
        JVERIFICATIONService.setup(with: config)
        JVERIFICATIONService.setDebug(true)
    }
    
    /// 获取一键登录的信息
    @objc class func getAuthorization(_ vc:UIViewController) {
        JVERIFICATIONService.getAuthorizationWith(vc, hide: true, animated: true, timeout: 15*1000, completion: { (result) in
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
    
    /// 获取token
    @objc func getToken() {
        JVERIFICATIONService.getToken { (result) in
            if let result = result {
                if let token = result["token"] {
                    if let code = result["code"], let op = result["operator"] {
                        print("get token result: code = \(code), operator = \(op), token = \(token)")
                        DispatchQueue.main.async {
                            print("code = \(code) \noperator = \(op) \ntoken = \(token)")
                        }
                    }
                }else if let code = result["code"], let content = result["content"] {
                    print("get token result: code = \(code), content = \(content)")
                    DispatchQueue.main.async {
                        print("code = \(code) \ncontent = \(content)")
                    }
                }
            }
        }
    }

    /// 删除预存号的缓存
    @objc func clearPreloginCache() {
       JVERIFICATIONService.clearPreLoginCache()
   }
    
    /// 获取预存号 这个方法我觉得业务用不上 后续没用就删掉
    @objc func preLogin() {
        JVERIFICATIONService.preLogin(5000) { (result) in
            if let result = result {
                if let code = result["code"], let message = result["message"] {
                    print("preLogin result: code = \(code), message = \(message)")
                    DispatchQueue.main.async {
                        print("回到主线程刷新页面")
                    }
                }
            }
        }
    }
}


extension JPPhoneLogin {
    
    /// 自定义一键登录页面的全屏式UI
    @objc class func congfigPhoneLoginFullScreenUI() {
        
        let config = JVUIConfig()
        /// 设置导航栏导航栏   自定义导航栏显示的文案 字体 颜色等
        config.navCustom = false
        config.navText = NSAttributedString.init(string: "登录统一认证",
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                              NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18)])
        /// 导航栏的返回按钮
        config.navReturnHidden = false
        config.navReturnImg = R.image.close()
        
        /// 自动旋转页面 关闭
        config.shouldAutorotate = false
        config.autoLayout = true                  /// 自定义布局时需要打开
        
        /// 弹窗弹出方式 动画
        config.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        /// logo 中国移动、联通 、电信 对应的商标logo  以及手机号的颜色 字体等 以及相应的布局
        config.logoImg = UIImage(named: "cmccLogo")
        config.numberColor = .red
        config.numberFont = UIFont.systemFont(ofSize: 25, weight: .bold)
        let logoWidth = config.logoImg?.size.width ?? 100
        let logoHeight = logoWidth
        
        /// 三大运营商的logo x
        let logoConstraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerX,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 to: JVLayoutItem.super,
                                                 attribute: NSLayoutConstraint.Attribute.centerX,
                                                 multiplier: 1,
                                                 constant: 0)
        
        /// 三大运营商的logo y
        let logoConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.bottom,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 to: JVLayoutItem.super,
                                                 attribute: NSLayoutConstraint.Attribute.centerY,
                                                 multiplier: 1,
                                                 constant: -90)
        /// 三大运营商的logo w
        let logoConstraintW = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 to: JVLayoutItem.none,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 multiplier: 1,
                                                 constant: logoWidth)
        
        /// 三大运营商的logo h
        let logoConstraintH = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.height,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 to: JVLayoutItem.none,
                                                 attribute: NSLayoutConstraint.Attribute.height,
                                                 multiplier: 1,
                                                 constant: logoHeight)
        
        config.logoConstraints = [logoConstraintX!,logoConstraintY!,logoConstraintW!,logoConstraintH!]
        config.logoHorizontalConstraints = config.logoConstraints
        
        /// 号码栏 手机号展示  手机号的x
        let numberConstraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerX,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   to: JVLayoutItem.super,
                                                   attribute: NSLayoutConstraint.Attribute.centerX,
                                                   multiplier: 1,
                                                   constant:0)
        /// 手机号的y
        let numberConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   to: JVLayoutItem.super,
                                                   attribute: NSLayoutConstraint.Attribute.centerY,
                                                   multiplier: 1,
                                                   constant:-55)
        /// 手机号的w
        let numberConstraintW = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.width,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   to: JVLayoutItem.none,
                                                   attribute: NSLayoutConstraint.Attribute.width,
                                                   multiplier: 1,
                                                   constant:200)
        /// 手机号的h
        let numberConstraintH = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.height,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   to: JVLayoutItem.none,
                                                   attribute: NSLayoutConstraint.Attribute.height,
                                                   multiplier: 1,
                                                   constant:25)
        
        config.numberConstraints = [numberConstraintX!, numberConstraintY!, numberConstraintW!, numberConstraintH!]
        config.numberHorizontalConstraints = config.numberConstraints
        
        /// 三大运营商对应的认证服务
        config.sloganTextColor = .green
        config.sloganFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        /// 三大运营商对应的认证服务 x
        let sloganConstraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerX,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   to: JVLayoutItem.super,
                                                   attribute: NSLayoutConstraint.Attribute.centerX,
                                                   multiplier: 1,
                                                   constant:0)
        /// 三大运营商对应的认证服务 y
        let sloganConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.bottom,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   to: JVLayoutItem.super,
                                                   attribute: NSLayoutConstraint.Attribute.centerY,
                                                   multiplier: 1,
                                                   constant:-20)
        /// 三大运营商对应的认证服务 w
        let sloganConstraintW = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.width,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   to: JVLayoutItem.none,
                                                   attribute: NSLayoutConstraint.Attribute.width,
                                                   multiplier: 1,
                                                   constant:130)
        /// 三大运营商对应的认证服务 h
        let sloganConstraintH = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.height,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   to: JVLayoutItem.none,
                                                   attribute: NSLayoutConstraint.Attribute.height,
                                                   multiplier: 1,
                                                   constant:20)
        
        config.sloganConstraints = [sloganConstraintX!, sloganConstraintY!, sloganConstraintW!, sloganConstraintH!]
        config.sloganHorizontalConstraints = config.sloganConstraints
        
        /// 登录按钮设置。 图片数组
        let login_nor_image = R.image.loginBtn_Nor()
        let login_dis_image = R.image.loginBtn_Dis()
        let login_hig_image = R.image.loginBtn_Hig()
        if let norImage = login_nor_image, let disImage = login_dis_image, let higImage = login_hig_image {
            config.logBtnImgs = [norImage, disImage, higImage]
        }
        
        let loginBtnWidth = login_nor_image?.size.width ?? 100
        let loginBtnHeight = login_nor_image?.size.height ?? 100
        
        config.logBtnText = "本机号码登录"
        config.logBtnTextColor = .white
        config.logBtnFont = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        /// 登录按钮的x
        let loginConstraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerX,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  to: JVLayoutItem.super,
                                                  attribute: NSLayoutConstraint.Attribute.centerX,
                                                  multiplier: 1,
                                                  constant:0)
        /// 登录按钮的y
        let loginConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.bottom,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  to: JVLayoutItem.super,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1,
                                                  constant:30)
        /// 登录按钮的w
        let loginConstraintW = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.width,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  to: JVLayoutItem.none,
                                                  attribute: NSLayoutConstraint.Attribute.width,
                                                  multiplier: 1,
                                                  constant:loginBtnWidth)
        /// 登录按钮的h
        let loginConstraintH = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  to: JVLayoutItem.none,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  multiplier: 1,
                                                  constant:loginBtnHeight)
        
        config.logBtnConstraints = [loginConstraintX!, loginConstraintY!, loginConstraintW!, loginConstraintH!]
        config.logBtnHorizontalConstraints = config.logBtnConstraints
        
        
        /// 用户协议的 勾选框
        let uncheckedImage = R.image.checkBox_unSelected()
        let checkedImage = R.image.checkBox_selected()
        let checkViewWidth = uncheckedImage?.size.width ?? 10
        let checkViewHeight = uncheckedImage?.size.height ?? 10
        config.uncheckedImg = uncheckedImage
        config.checkedImg = checkedImage
        
        /// 用户协议的 勾选框x
        let checkViewConstraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.left,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      to: JVLayoutItem.super,
                                                      attribute: NSLayoutConstraint.Attribute.left,
                                                      multiplier: 1,
                                                      constant:20)
        
        /// 用户协议的 勾选框y
        let checkViewConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      to: JVLayoutItem.privacy,
                                                      attribute: NSLayoutConstraint.Attribute.centerY,
                                                      multiplier: 1,
                                                      constant:0)
        /// 用户协议的 勾选框w
        let checkViewConstraintW = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.width,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      to: JVLayoutItem.none,
                                                      attribute: NSLayoutConstraint.Attribute.width,
                                                      multiplier: 1,
                                                      constant:checkViewWidth)
        
        /// 用户协议的 勾选框h
        let checkViewConstraintH = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.height,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      to: JVLayoutItem.none,
                                                      attribute: NSLayoutConstraint.Attribute.height,
                                                      multiplier: 1,
                                                      constant:checkViewHeight)
        
        config.checkViewConstraints = [checkViewConstraintX!, checkViewConstraintY!, checkViewConstraintW!, checkViewConstraintH!]
        config.checkViewHorizontalConstraints = config.checkViewConstraints
        
        /// 隐私条款的设置
        let spacing = checkViewWidth + 20 + 5
        config.privacyState = true
        config.privacyTextFontSize = 12
        config.privacyTextAlignment = NSTextAlignment.left
        config.agreementNavReturnImage = R.image.close()
        config.appPrivacyOne = ["应用自定义服务条款1","https://www.baidu.com"]
        config.appPrivacyTwo = ["应用自定义服务条款2","http://www.mtime.com/"]
        
        /// 隐私条款的设置第一个的 x
        let privacyConstraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.left,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    to: JVLayoutItem.super,
                                                    attribute: NSLayoutConstraint.Attribute.left,
                                                    multiplier: 1,
                                                    constant:spacing)
        
        /// 隐私条款的设置第二个的x
        let privacyConstraintX2 = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.right,
                                                     relatedBy: NSLayoutConstraint.Relation.equal,
                                                     to: JVLayoutItem.super,
                                                     attribute: NSLayoutConstraint.Attribute.right,
                                                     multiplier: 1,
                                                     constant:-spacing)
        
        /// 隐私条款的设置y
        let privacyConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.bottom,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    to: JVLayoutItem.super,
                                                    attribute: NSLayoutConstraint.Attribute.bottom,
                                                    multiplier: 1,
                                                    constant:-10)
        
        /// 隐私条款的设置h
        let privacyConstraintH = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.height,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    to: JVLayoutItem.none,
                                                    attribute: NSLayoutConstraint.Attribute.height,
                                                    multiplier: 1,
                                                    constant:50)
        config.privacyConstraints = [privacyConstraintX!,privacyConstraintX2!, privacyConstraintY!, privacyConstraintH!]
        config.privacyHorizontalConstraints = config.privacyConstraints
        
        /// 登录加载 loading x
        let loadingConstraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerX,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    to: JVLayoutItem.super,
                                                    attribute: NSLayoutConstraint.Attribute.centerX,
                                                    multiplier: 1,
                                                    constant:0)
        /// 登录加载 loading y
        let loadingConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    to: JVLayoutItem.super,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant:0)
        /// 登录加载 loading w
        let loadingConstraintW = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.width,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    to: JVLayoutItem.none,
                                                    attribute: NSLayoutConstraint.Attribute.width,
                                                    multiplier: 1,
                                                    constant:30)
        /// 登录加载 loading h
        let loadingConstraintH = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.height,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    to: JVLayoutItem.none,
                                                    attribute: NSLayoutConstraint.Attribute.height,
                                                    multiplier: 1,
                                                    constant:30)
        
        config.loadingConstraints = [loadingConstraintX!, loadingConstraintY!, loadingConstraintW!, loadingConstraintH!]
        config.loadingHorizontalConstraints = config.loadingConstraints
        
        
        JVERIFICATIONService.customUI(with: config) { (customView) in
            /// 还可以加一点自定义的UI 到界面上 但是上面的那些是一个都不能少 所以不建议再自定义UI
//            guard let customV = customView else {
//                return
//            }
//            let label = UILabel()
//            label.text = "customLabel"
//            label.backgroundColor = .purple
//            label.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
//            customV.addSubview(label)
        }
        
       }
    
    /// 自定义半屏弹窗
    @objc class func congfigPhoneLoginHalfScreenUI() {
        /// 写这个的目的告诉你 手机支持一键登录 页面有两种一种 全屏 一种 半屏 设计里面与全屏一样 没啥区别 自己体会 我就不写了 可以参考此链接 https://docs.jiguang.cn/jverification/client/ios_api/
    }
}
