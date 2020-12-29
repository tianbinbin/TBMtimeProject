//
//  BundleExtention.swift
//  TBMtimeBaseControll
//
//  Created by 田彬彬 on 2020/12/22.
//

import Foundation

open class BaseBundleStruct {
    
}


extension Bundle {
    
    /// 底层组件
    public static var baseControll: Bundle {
        if let path = Bundle(for: BaseBundleStruct.self).path(forResource: "TBMtimeBaseControll", ofType: "bundle") {
            return Bundle(path: path)!
        }
        
        return Bundle.main
    }
    

    private struct AssociatedKeys {
        static var common = "Bundle.common"
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
}
