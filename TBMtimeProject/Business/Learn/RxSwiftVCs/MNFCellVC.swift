//
//  MNFCellVC.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2021/1/4.
//

import TBMtimeBaseControll
import RxCocoa
import RxSwift

class MNFCellVC: MNFBaseViewController {
    
    let bag = DisposeBag ()
    
    let queueA = PublishSubject<String>()
    let queueB = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    deinit {
        print("MNFCellVC 释放了")
    }
}

extension MNFCellVC {

}

