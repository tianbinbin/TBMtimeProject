//
//  MNFActorDetailVC.swift
//  MtimeProject
//
//  Created by 田彬彬 on 2020/12/17.
//


import TBMtimeBaseControll

class MNFActorDetailVC: MNFBaseViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = .orange
        
    }
}

extension MNFActorDetailVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
        pushVC()
    }
    
    func pushVC() {
        if let path = Bundle(for: MNFBaseViewController.self).path(forResource: "TBMtimeBaseControll", ofType: "bundle") {
            let bundle = Bundle(path: path)!
            
            let sb = UIStoryboard.init(name: "Demo", bundle: bundle)
            if #available(iOS 13.0, *) {
                let vcDemo = sb.instantiateViewController(identifier: "MNFDemoStoryBoardVC") as? MNFDemoStoryBoardVC
                if let vc = vcDemo {
                    navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                
            }
        }
    }
}


