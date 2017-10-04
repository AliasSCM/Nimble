//
//  AuthInteractor.swift
//  NimbleTest
//
//  Created by master on 10/4/17.
//  Copyright © 2017 neemo. All rights reserved.
//

import UIKit


protocol AuthenticateBuisnessLogic
{
    func authenticate(request : Auth.Login.Request)
}

protocol AuthenticateDataStore
{
    var session: SessionModel? { get }
}

class AuthInteractor: AuthenticateBuisnessLogic , AuthenticateDataStore
{
   
    
    var session: SessionModel?
    
    var presenter: AuthPresenter?
    var authWorker = AuthWorker(authentication : AuthAPIStore())
    
    func authenticate(request : Auth.Login.Request)
    {
        authWorker.authenticate(request : request, completionHandler:{ (sessionModel) -> Void in
            self.session = sessionModel
            NetworkOperation.setAuthorizationHeader(headerDict: ["access_token" : (self.session?.accessToken)!])
            let response = Auth.Login.Response(session: sessionModel)
          
            self.presenter?.presentSession(response: response)
        })
    }

}
