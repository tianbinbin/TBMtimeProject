//
//  BundleExtention.swift
//  TBMtimeBaseControll
//
//  Created by 田彬彬 on 2020/12/22.
//

import Foundation

open class CommonBundleClass {
    
}

extension Bundle {
    
    /// 底层组件
    public static var common: Bundle {
        if let path = Bundle(for: CommonBundleClass.self).path(forResource: "TBMtimeCommon", ofType: "bundle") {
            return Bundle(path: path)!
        }
        
        return Bundle.main
    }
}
