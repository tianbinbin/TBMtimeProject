//
//  MNFMovieDetailVC.swift
//  MtimeProject
//
//  Created by 田彬彬 on 2020/12/16.
//

import TBMtimeBaseControll

class MNFMovieDetailVC: MNFBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
            
        showImageView()
    }
}

extension MNFMovieDetailVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let path = Bundle(for: MNFBaseViewController.self).path(forResource: "TBMtimeBaseControll", ofType: "bundle") {
            let bundle = Bundle(path: path)!
            let imageView = UIImageView(frame: CGRect(x: 100, y: 300, width: 200, height: 400))
            let image = UIImage(named: "motuo2", in: bundle, compatibleWith: nil)
            imageView.image = image
            imageView.backgroundColor = .red
            view.addSubview(imageView)
        }
    }
}
