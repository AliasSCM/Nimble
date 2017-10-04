//
//  SurveyModel.swift
//  Nimble
//
//  Created by master on 10/4/17.
//  Copyright © 2017 neemo. All rights reserved.
//

import UIKit
import ObjectMapper

class SurveyModel: Mappable
{
    
    var coverImageUrl  : String!
    var name        : String!
    var description : String!
    
    init()
    {
        
   
    }
    required init?(map: Map)
    {
        if map.JSON["cover_image_url"] == nil {
            return nil
        }
        if map.JSON["description"] == nil {
            return nil
        }
        if map.JSON["title"] == nil {
            return nil
        }
        if map.JSON["created_at"] == nil {
            return nil
        }
        
    }
    
    func mapping(map: Map)
    {
        coverImageUrl   <-  map["cover_image_url"]
        name            <-  map["title"]
        description     <-  map["description"]
        
    }
}
