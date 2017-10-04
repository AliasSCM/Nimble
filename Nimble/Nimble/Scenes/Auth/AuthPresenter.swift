//
//  AuthPresenter.swift
//  NimbleTest
//
//  Created by master on 10/4/17.
//  Copyright (c) 2017 neemo. All rights reserved.


import UIKit

protocol AuthPresentationLogic
{
    func presentSession(response : Auth.Login.Response)
}

class AuthPresenter: AuthPresentationLogic
{
   
  weak var viewController: AuthDisplayLogic?
    
    func presentSession(response : Auth.Login.Response)
    {
        viewController?.showMainScreen(response: response)
        
    }
    

    
  
  // MARK: Do something
  

}
