//
//  ListSurveyWorker.swift
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

//MARK: SurveyDataProtocol is the standard mechanism using which survey data is passed around between classes
protocol SurveyDataProtocol
{
    // MARK: CRUD operations - Optional error. Implementing Only fetch for now
    
    func fetchSurvey(request : ListSurvey.FetchSurvey.Request ,completionHandler: @escaping ([SurveyModel], SurveyDataError?) -> Void)
}


enum SurveyDataError: Equatable, Error
{
    
    case CannotFetch(String)
    
}

func ==(lhs: SurveyDataError, rhs:SurveyDataError) -> Bool
{
    switch (lhs, rhs) {
    case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
   
    default: return false}
}



class ListSurveyWorker
{
    var surveysStore: SurveyDataProtocol
    
    init(store: SurveyDataProtocol)
    {
        self.surveysStore = store
    }
    
    
    
    func fetchSurvey(request:ListSurvey.FetchSurvey.Request  ,completionHandler: @escaping ([SurveyModel]) -> Void)
    {
        surveysStore.fetchSurvey(request: request, completionHandler: {(surveys:[SurveyModel] , error: SurveyDataError? ) -> Void in
            do {
                let surveys = try surveys
                DispatchQueue.main.async {
                    completionHandler(surveys)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler([])
                }
            }
        })
       
    }
    
}
