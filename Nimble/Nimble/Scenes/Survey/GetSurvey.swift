//
//  GetSurvey.swift
//  Nimble
//
//  Created by master on 10/4/17.
//  Copyright © 2017 neemo. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class GetSurvey: NetworkOperation
{
    override func start()
    {
        super.start()
        
        self.extensionUrl = "/surveys.json"
        
        
        let urlString = String.init(format: "%@%@", baseUrl , extensionUrl)
        
        print(urlString)
        print(self.parameters)
        print(NetworkOperation.authorizationHeader())
        Alamofire.request(urlString, method: .get, parameters: parameters ,encoding: URLEncoding(destination: .queryString) , headers: [:] ).responseJSON
            {
                response in
                switch response.result
                {
                case .success:
                    print(response.request?.url)
                    let value = response.result.value as! [Any]
                    
                    print(value)
                    let object = Mapper<SurveyModel>().mapArray(JSONObject: value)
                    
                    self.handlers.didFinishWithSuccess(mappedData: object! as AnyObject)
                    print(response)
                    
                    break
                case .failure(let error):
                    self.handlers.didFailWithError(error: error)
                    
                    print(error)
                }
        }
        
    }
}
