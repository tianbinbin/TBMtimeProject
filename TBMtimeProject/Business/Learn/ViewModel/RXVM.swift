//
//  RXVM.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2021/6/1.
//

import Foundation
import RxSwift
import RxCocoa

struct RXVM {
    
    let userName = BehaviorRelay(value: "")
    
    
    
    
//    lazy var userInfo = {
//        return self.userName.asObservable().map { $0.name == "hangge" ? "您是管理员" : "您是普通访客"
//        }.share(replay: 1, scope: .forever)
//    }()
    
    //用户信息 这是一个新的序列。经过map之后变成了一个新的序列
    lazy var userinfo = {
        return self.userName.asObservable()
                .map{ $0 == "Hangge" ? "您是管理员" : "您是普通访客" }
                .share(replay: 1)
    }()
}
