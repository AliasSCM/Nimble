//
//  Login.swift
//  NimbleTest
//
//  Created by master on 10/2/17.
//  Copyright © 2017 neemo. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class Login: NetworkOperation
{
    override func start()
    {
        super.start()
        
        self.extensionUrl = "/oauth/token"
        
        
        let urlString = String.init(format: "%@%@", baseUrl , extensionUrl)
        
        
        Alamofire.request(urlString, method: .post, parameters: parameters ,encoding: JSONEncoding.default, headers: nil).responseJSON
            {
                response in
                switch response.result
                {
                case .success:
                    let value = response.result.value as! [String : Any]
                   
                    print("Login API : Response" , value)
                    let object = Mapper<SessionModel>().map(JSON: value)
                    
                    self.handlers.didFinishWithSuccess(mappedData: object!)
                    print(response)
                    
                    break
                case .failure(let error):
                    self.handlers.didFailWithError(error: error)
                    
                    print(error)
                }
        }
        
    }
}
