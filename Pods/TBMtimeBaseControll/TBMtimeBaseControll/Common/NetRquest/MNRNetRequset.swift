//
//  MNRNetRequset.swift
//  MtimeBaseControll
//
//  Created by 田彬彬 on 2020/12/18.
//

import UIKit
import Foundation
import Alamofire

open class MNRNetRequset: NSObject {

    open func requsetMethod(_ urlString:String?,
                            _ typeRequset:CommonEnume.RequsetType,
                            _ dictParams:[String:Any]?,
                            success:@escaping (_ succeed : Any) -> (),
                            failed:@escaping (_ failed : Any) -> ()) -> () {
        print("只行了网络请求")
        
        AF.request("https://httpbin.org/get").response { response in
            debugPrint(response)
        }
    }
}
