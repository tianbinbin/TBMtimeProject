//
//  MNFLearnRxSwiftVC.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2021/5/27.
//

import TBMtimeBaseControll
import RxCocoa
import RxSwift

class MNFCustomRxSwiftVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    deinit {
        print("MNFLearnRxSwiftVC 释放了")
    }
}

extension MNFCustomRxSwiftVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let vc = R.storyboard.rxSwift.mnfObservableVC()!
                navigationController?.pushViewController(vc, animated: true)
            default: break
            }
        default: break

        }
    }
}
