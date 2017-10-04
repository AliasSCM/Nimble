//
//  LoginWorker.swift
//  NimbleTest
//
//  Created by master on 10/4/17.
//  Copyright © 2017 neemo. All rights reserved.
//

import UIKit

protocol AuthenticationProtocol
{
    func authenticate(request : Auth.Login.Request , completionHandler: @escaping (SessionModel?, AuthError?) -> Void)
}


enum AuthResult<U>
{
    case Success(result: U)
    case Failure(error: AuthError)
}


enum AuthError: Equatable, Error
{
   case CannotAuthenticate(String)
   case CannotFetch(String)
}

func ==(lhs: AuthError, rhs: AuthError) -> Bool
{
    switch (lhs, rhs) {
    case (.CannotAuthenticate(let a), .CannotAuthenticate(let b)) where a == b: return true
    
    default: return false
    }
}
class AuthWorker
{
    
    var auth      : AuthenticationProtocol
    
    init(authentication: AuthenticationProtocol)
    {
        self.auth = authentication
    }
    
    func authenticate(request : Auth.Login.Request , completionHandler: @escaping (SessionModel) -> Void)
    {
        
        auth.authenticate(request: request, completionHandler: {(session:SessionModel? , error : AuthError?)  -> Void in
            completionHandler(session!)
        })
    }
    
}

