//
//  NetworkTools.swift
//  DouYuZhiBo
//
//  Created by Young on 2017/2/20.
//  Copyright © 2017年 YuYang. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools: NSObject {

    class func requestData(type : MethodType, urlString : String, parameters : [String : Any]?, completionCallBack: @escaping (_ result : Any) -> ()) {
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: method, parameters : parameters).responseJSON { (response) in
            
            guard let result = response.result.value else {
                
                print(response.error!)
                
                return
            }
            
            completionCallBack(result)
        }
        
    }
}
