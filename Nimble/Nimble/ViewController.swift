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

//MARK: Display Logic for displaying Survey
protocol ListSurveyDisplayLogic : class
{
    func displayFetchedSurveys(viewModel: ListSurvey.FetchSurvey.ViewModel)
}


class ViewController: UIViewController , AuthDisplayLogic , ListSurveyDisplayLogic {

    
    var authInteractor      : AuthenticateBuisnessLogic?
    var surveyInteractor    : ListSurveyBusinessLogic?
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupAuth()
        setupSurvey()
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupAuth()
        setupSurvey()
       
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
    
    // MARK: Setup VIP structure for survey scene
    private func setupSurvey()
    {
        let viewController = self
        let interactor          =   ListSurveyInteractor()
        let presenter           =   ListSurveyPresenter()
        viewController.surveyInteractor   = interactor
        interactor.presenter        = presenter
        presenter.viewController    = viewController
        
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
      
        var request = ListSurvey.FetchSurvey.Request()
        request.accessToken = response.session.accessToken
        surveyInteractor?.fetchSurveysFromRemote(request: request)
    }
    
    func displayFetchedSurveys(viewModel: ListSurvey.FetchSurvey.ViewModel)
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

