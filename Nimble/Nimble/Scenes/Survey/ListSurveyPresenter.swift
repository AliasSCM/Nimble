//
//  ListSurveyPresenter.swift
//  Nimble
//
//  Created by master on 10/4/17.
//  Copyright (c) 2017 neemo. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListSurveyPresentationLogic
{
  func presentSurveys(response: ListSurvey.FetchSurvey.Response)
}

class ListSurveyPresenter: ListSurveyPresentationLogic
{
   
    
  weak var viewController: ListSurveyDisplayLogic?
  
  // MARK: Present Survey List
    
  func presentSurveys(response: ListSurvey.FetchSurvey.Response)
    {
        var displayedSurveys: [ListSurvey.FetchSurvey.ViewModel.DisplayedSurvey] = []
        for survey in response.surveyModel
        {
            let displayedSurvey = ListSurvey.FetchSurvey.ViewModel.DisplayedSurvey(title : survey.name , description : survey.description , backrgroundImageUrl : survey.coverImageUrl)
            displayedSurveys.append(displayedSurvey)
        }
        let viewModel = ListSurvey.FetchSurvey.ViewModel(displayedSurveys: displayedSurveys)
        viewController?.displayFetchedSurveys(viewModel: viewModel)
    }
}
