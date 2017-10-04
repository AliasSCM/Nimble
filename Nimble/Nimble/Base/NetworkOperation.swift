//
//  NetworkOperation.swift
//  Aparto
//
//  Created by master on 4/20/17.
//  Copyright © 2017 Imversion. All rights reserved.
//

import UIKit
import Alamofire

typealias NetworkCallback =   ((AnyObject?,  Error? ) ->Void)

protocol NetworkOperationProtocol
{
    func didFinishWithSuccess(mappedData : AnyObject)
    func didFailWithError(error : Error)
}

class NetworkOperation: NSObject
{
  
   
    var baseUrl         : String = "https://nimbl3-survey-api.herokuapp.com"
    var extensionUrl    : String!
    var handlers        : NetworkOperationProtocol!
    var parameters      : Dictionary<String , Any>!
    var requiresheader  : Bool!
  
    
    private var _executing          : Bool = false
    private static  var header      : Dictionary<String , String>!
   
    
    class func authenticationString(username : String , password : String) -> Dictionary<String , String>
    {
       
        let cat         =   username + ":" + password
        
        return ["Authorization" : "Basic " ]
    }
    
    
    class func authorizationHeader() -> Dictionary<String , String>!
    {
        return header!
    }
    
    class func setAuthorizationHeader(headerDict : Dictionary<String , String>!)
    {
        header  = headerDict
    }
    
    func start()
    {
        
    }
    
    
    

    

}
