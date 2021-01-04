//
//  MNFTableViewVC.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2021/1/4.
//

import TBMtimeBaseControll
import RxCocoa
import RxSwift

class MNFTableViewVC: MNFBaseViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
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
 
        dataBehavor.asObservable().bind(to: tableview.rx.items(cellIdentifier: "Cellidid", cellType: UITableViewCell.self)){ row,model,cell in
            print("打印一下当前的\(row)--\(model)")
            
            let customcell = cell as? UITableViewCell
            
            customcell?.textLabel?.text = "\(row)"
        }
        
    }

    deinit {
        print("MNFCellVC 释放了")
    }
}
