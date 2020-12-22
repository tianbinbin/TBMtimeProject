//
//  BundleExtention.swift
//  TBMtimeBaseControll
//
//  Created by 田彬彬 on 2020/12/22.
//

import Foundation

extension Bundle {
    private struct AssociatedKeys {
        static var common = "Bundle.common"
        static var baseControll = "Bundle.baseControll"
    }
    
    /// 通用组件
    @objc public static var common: Bundle {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.common) as? Bundle ?? Bundle.main
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.common, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// 底层组件
    @objc public static var baseControll: Bundle {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.baseControll) as? Bundle ?? Bundle.main
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.baseControll, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
