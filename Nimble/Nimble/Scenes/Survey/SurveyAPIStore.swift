//
//  SurveyAPIStore.swift
//  Nimble
//
//  Created by master on 10/4/17.
//  Copyright © 2017 neemo. All rights reserved.
//

import UIKit

class SurveyAPIStore: SurveyDataProtocol , NetworkOperationProtocol
{
    
    
    var completionBlock : (([SurveyModel], SurveyDataError?) -> Void)?
    
    func fetchSurvey(request: ListSurvey.FetchSurvey.Request, completionHandler: @escaping ([SurveyModel], SurveyDataError?) -> Void)
    {
        completionBlock         =   completionHandler
        let getSurvey           =   GetSurvey.init()
        getSurvey.parameters    =   request.getParams()
        getSurvey.handlers      =   self
        getSurvey.start()
        
    }
   
 
    func didFinishWithSuccess(mappedData: AnyObject)
    {
        completionBlock!(mappedData as! [SurveyModel] , nil)
    }
    
    func didFailWithError(error: Error)
    {
        completionBlock!([] , SurveyDataError.CannotFetch("Could not fetch survey from API") )
    }
}
