//
//  MNFHomeVC.swift
//  TBMtimeProject
//
//  Created by 田彬彬 on 2020/12/29.
//

import TBMtimeBaseControll

class MNFHomeVC:UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension MNFHomeVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let vcRxSwift = R.storyboard.home.mnfCustomRxSwiftVC()
                navigationController?.pushViewController(vcRxSwift!, animated: true)
            case 1:
                let vc = MNFDisbagVC()
                navigationController?.pushViewController(vc, animated: true)
            case 2:
                let vc = MNFComBineLatestAndZIPVC()
                navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = R.storyboard.home.mnfCellVC()
                navigationController?.pushViewController(vc!, animated: true)
            case 4:
                let vc = R.storyboard.home.mnfTableViewVC()
                navigationController?.pushViewController(vc!, animated: true)
            default: break
            }
            
        case 1:
            switch indexPath.row {
            case 0:
                let vc = R.storyboard.home.mnfSwiftUIVC()
                navigationController?.pushViewController(vc!, animated: true)
            case 1:
                let vc = R.storyboard.home.mnfjPhoneLoginVC()
                navigationController?.pushViewController(vc!, animated: true)
            default:break
            }
        default: break

        }
    }
}
