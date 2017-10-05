//
//  ViewController.swift
//  Nimble
//
//  Created by master on 10/4/17.
//  Copyright © 2017 neemo. All rights reserved.
//

import UIKit
import SwiftSpinner
import FSPagerView
import SDWebImage

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


class ViewController: UIViewController , AuthDisplayLogic , ListSurveyDisplayLogic , FSPagerViewDataSource , FSPagerViewDelegate , SurveyCellProtocol {
   
    

    @IBOutlet var pagerView: FSPagerView!
  
    var pageControl         : FSPageControl!
    var authInteractor      : AuthenticateBuisnessLogic?
    var surveyInteractor    : ListSurveyBusinessLogic?
    var displayedSurveys    : [ListSurvey.FetchSurvey.ViewModel.DisplayedSurvey] = []
    var loginResponse       : Auth.Login.Response!
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem)
    {
        if(loginResponse != nil)
        {
            DispatchQueue.main.async
            {
                    SwiftSpinner.show("Restarting quarx...")
                    self.showMainScreen(response: self.loginResponse)
                    
            }
            
        }
       
    }
    
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
        loginResponse = response
        var request = ListSurvey.FetchSurvey.Request()
        request.accessToken = response.session.accessToken
        surveyInteractor?.fetchSurveysFromRemote(request: request)
    }
    
    func displayFetchedSurveys(viewModel: ListSurvey.FetchSurvey.ViewModel)
    {
      
        displayedSurveys    =   viewModel.displayedSurveys
        self.createPageControl(pagesCount: displayedSurveys.count)
        SwiftSpinner.hide()
        pagerView.reloadData()
        
    }
    
    
    //MARK : VC lifecycle
   override func viewDidLoad()
   {
    super.viewDidLoad()
   
    
    //Create Pager View
   
    pagerView.dataSource = self
    pagerView.delegate  =   self
    pagerView.register(SurveyView.self, forCellWithReuseIdentifier: "cell")
    pagerView.register(UINib.init(nibName: "SurveyView", bundle: nil), forCellWithReuseIdentifier: "cell")
    self.view.addSubview(pagerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createPageControl(pagesCount : Int)
    {
        if(pageControl != nil && pageControl.superview != nil)
        {
            pageControl.removeFromSuperview()
        }
        pageControl = FSPageControl(frame: CGRect.init(x: self.view.frame.size.width - 64, y: self.view.frame.size.height/2 - 20 , width: 20.0 * CGFloat(pagesCount), height: 40))
        pageControl.numberOfPages   =   pagesCount
        pageControl.currentPage     =   0
        pageControl.transform = pageControl.transform.rotated(by: CGFloat(M_PI_2))
       
        self.view.addSubview(pageControl)
    }
    //MARK: Pager
    func numberOfItems(in pagerView: FSPagerView) -> Int
    {
        return displayedSurveys.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell
    {
        let cell    = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index) as! SurveyView
        cell.bgImagView.sd_setImage(with: URL.init(string : displayedSurveys[index].backrgroundImageUrl), completed: nil)
        cell.titleLabel?.text    = displayedSurveys[index].title
        cell.delegate  = self
        return cell
    }
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int)
    {
          pageControl.currentPage = targetIndex
    }
    
    func surveyButtonDidPress()
    {
        self.navigationController?.pushViewController(UIViewController.init(), animated: true)
        
    }
    


}

