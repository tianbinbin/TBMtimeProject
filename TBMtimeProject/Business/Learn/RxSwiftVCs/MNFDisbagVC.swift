//
//  MNFDisbagVC.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2021/1/4.
//

import TBMtimeBaseControll
import RxCocoa
import RxSwift

class MNFDisbagVC: MNFBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = requsetData().asObservable().bind { (str) in
            print("我爱北京天安门\(str)")
        }
        
        requsetData().bind { (str) in
            print("即将\(str)")
        }
        
        requsetData().subscribe { (event:Event<String>) in
            print(event.element as Any)
        }
        
        returnTwo()
        
        returnOne()
    }
    
    
    deinit {
        print("MNFDisbagVC 释放了")
    }
}

extension MNFDisbagVC {
    
    @discardableResult
    func requsetData() -> Observable<String> {
        return Observable.create { (observer:AnyObserver<String>) -> Disposable in
            
            observer.onNext("我爱北京")
            return Disposables.create()
        }
    }
    
    
    func returnTwo() -> String {
        return "我是谁"
    }
    
    @discardableResult
    func returnOne() -> String {
        return "天安门"
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("我在哪里")
    }
    
}
