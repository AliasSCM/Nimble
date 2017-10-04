//
//  SessionModel.swift
//  NimbleTest
//
//  Created by master on 10/4/17.
//  Copyright © 2017 neemo. All rights reserved.
//

import UIKit
import ObjectMapper



class SessionModel: Mappable
{
    var accessToken : String!
    var tokenType   : String!
    var duration    : Int!
    var createdAt   : String!
    
    
    init(token : String , type : String , duration : Int , created : String)
    {
       
        self.accessToken    =   token
        self.tokenType      =   type
        self.duration       =   duration
        self.createdAt      =   created
    }
    required init?(map: Map) {
        
        if map.JSON["access_token"] == nil {
            return nil
        }
        if map.JSON["token_type"] == nil {
            return nil
        }
        if map.JSON["expires_in"] == nil {
            return nil
        }
        if map.JSON["created_at"] == nil {
            return nil
        }
    }
    
    func mapping(map: Map)
    {
        accessToken <-  map["access_token"]
        tokenType   <-  map["token_type"]
        duration    <-  map["expires_in"]
        createdAt   <-  map["createdAt"]
    }
    
   
}
