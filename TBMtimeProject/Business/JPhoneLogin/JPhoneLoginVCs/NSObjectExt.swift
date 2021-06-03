//
//  NSObjectExt.swift
//  WandaFilm-Core
//
//  Created by 李京城 on 2018/7/27.
//  Copyright © 2018年 MX. All rights reserved.
//

import Foundation

extension NSObject {
    /// 根据对象获取相关类名
    public var className: String {
        return String(describing: type(of: self))
    }
    
    /// 根据类获取相关类名
    public class var className: String {
        return String(describing: self)
    }
}
