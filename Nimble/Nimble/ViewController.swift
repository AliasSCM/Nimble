//
//  ViewController.swift
//  Nimble
//
//  Created by master on 10/4/17.
//  Copyright © 2017 neemo. All rights reserved.
//

import UIKit
import SwiftSpinner

//MARK: Display Logic for authentication
protocol AuthDisplayLogic: class
{
    func showAuthScreen(request : Auth.Login.Request)
    func showMainScreen(response : Auth.Login.Response)
}


class ViewController: UIViewController , AuthDisplayLogic {

    
    var authInteractor      : AuthenticateBuisnessLogic?
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupAuth()
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupAuth()
       
    }
    
    
    // MARK: Setup VIP structure for authntication scene
    
    private func setupAuth()
    {
        let viewController = self
        let interactor  =   AuthInteractor()
        let presenter   =   AuthPresenter()
        let router      =   AuthRouter()
        viewController.authInteractor   = interactor
       
        interactor.presenter        = presenter
        presenter.viewController    = viewController
        router.viewController       = viewController
        router.dataStore            = interactor
        
        self.showAuthScreen(request: Auth.Login.Request())
        
    }
    
    // MARK: Implement AuthDisplayLogic Protocol
    func showAuthScreen(request : Auth.Login.Request)
    {
        DispatchQueue.main.async
       {
            SwiftSpinner.show("Starting up quarx generator...")
            
        }
        authInteractor?.authenticate(request : Auth.Login.Request())
        
    }
    
    func showMainScreen(response: Auth.Login.Response)
    {
        SwiftSpinner.hide()
    }
    
    //MARK : VC lifecycle
   override func viewDidLoad()
   {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

