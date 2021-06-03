//
//  MNFComBineLatestAndZIPVC.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2021/1/4.
//


import TBMtimeBaseControll
import RxCocoa
import RxSwift

class MNFComBineLatestAndZIPVC: MNFBaseViewController {
    
    let bag = DisposeBag ()

    let queueA = PublishSubject<String>()
    let queueB = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        combinlaseted()
        
        zipLaset()
        
        queueA.onNext("我爱北京天安门")
        queueB.onNext("天安门")
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        queueB.onNext("西单")
    }
    
    deinit {
        print("MNFComBineLatestAndZIPVC 释放了")
    }
}

extension MNFComBineLatestAndZIPVC {
    func combinlaseted(){
        
        /// 当queue中发生A1时，由于queue中没有事件发生，所以不会触发 combineLatest 。 只有在每一个Sub-observable 中都发生过一个事件之后，combineLatest 才会触发 OnNext 的 closure
    
        let sequece = Observable.combineLatest(queueA, queueB)
        sequece.asObservable().bind { (str) in
            let (str1, str2) = str
            print("\(str1)--\(str2)")
        }.disposed(by: bag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        queueA.onNext("王府井")
    }
    
    /// 每次合并完之后，所有Sub-observable 中的事件可以理解为被消费掉了。 只有当下次所有序列中都产生新的事件，才会进行下一次合并。于是 就只能订阅到 （A1,B1）（A2,B2）。
    func zipLaset() {
        let sequece = Observable.zip(queueA, queueB)
        sequece.asObservable().bind { (str) in
            let (str1, str2) = str
            print("\(str1)--\(str2)")
        }.disposed(by: bag)
    }
}
