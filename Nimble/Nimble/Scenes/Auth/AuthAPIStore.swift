//
//  AuthAPIStore.swift
//  NimbleTest
///Users/master/Desktop/Developer/NimbleTest/NimbleTest/NimbleTest/Authentication/New Group/AuthAPIStore.swift
//  Created by master on 10/4/17.
//  Copyright © 2017 neemo. All rights reserved.
//

import UIKit



class AuthAPIStore: AuthenticationProtocol , NetworkOperationProtocol
{
    
    
    var completionBlock : ((SessionModel?, AuthError?) -> Void)? 
    
    func authenticate(request: Auth.Login.Request, completionHandler: @escaping (SessionModel?, AuthError?) -> Void)
    {
        completionBlock =   completionHandler
        let login       =   Login.init()
        login.parameters = request.params
        login.handlers  =   self
        login.start()
        
    }
   
    
    func didFinishWithSuccess(mappedData: AnyObject)
    {
        completionBlock!(mappedData as! SessionModel , nil)
    }
    
    func didFailWithError(error: Error)
    {
        completionBlock!(nil , AuthError.CannotAuthenticate("Network Authentication Failed"))
    }
    
   
}
