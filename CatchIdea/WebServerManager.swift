//
//  WebServerManager.swift
//  CatchIdea
//
//  Created by Linsw on 17/3/5.
//  Copyright © 2017年 Linsw. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

internal class WebServerManager {
    private let serverAPIAddress = "http://www.linshiwei.win/catch.php?key=lsw&query=getproductid"
    static let shared = WebServerManager()
    private init(){
        
    }
    
    internal func getDataFromServer(_ completion: @escaping (Bool,[String]?)->Void){
        let url = URL(string:serverAPIAddress)!
        Alamofire.request(url).responseJSON{ response in
            if let anyValue = response.result.value{
                let json = JSON(anyValue)
                if json["status"].boolValue == true , let idSuffix = json["IDSuffix"].array {
                    var suffixs = [String]()
                    for item in idSuffix{
                        if let suffix = item["id"].string{
                            suffixs.append(suffix)
                        }else{
                            print("data from server invalid")
                        }
                    }
                    completion(true,suffixs)
                }else{
                    completion(false,nil)
                    print("json data format invalid")
                }
            }else{
                DispatchQueue.main.async {
                    completion(false,nil)
                    print("fail to fetch data")
                }
            }
        }
    }
}
