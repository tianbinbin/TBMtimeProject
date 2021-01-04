//
//  MNFCellVC.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2021/1/4.
//

import TBMtimeBaseControll
import RxCocoa
import RxSwift

class MNFCellVC: MNFBaseViewController,UICollectionViewDelegate {

    
        
    @IBOutlet weak var collectionview: UICollectionView!
    fileprivate lazy var bag = DisposeBag()
    
    var dataBehavor : BehaviorRelay<[Int]> = {
        var array = [Int]()
        for i in 0...100
        {
            array.append(i)
        }
        
        return BehaviorRelay(value: array)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        dataBehavor.asObservable().bind(to: collectionview.rx.items(cellIdentifier: "CELLID", cellType: UICollectionViewCell.self)){row,model,cell in
            
            print("打印一下当前的\(row)--\(model)")
            
            print("2222222")
            
            
        }
    }

    deinit {
        print("MNFCellVC 释放了")
    }
}



