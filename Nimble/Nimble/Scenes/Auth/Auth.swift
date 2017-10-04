//
//  Auth.swift
//  Nimble
//
//  Created by master on 10/4/17.
//  Copyright © 2017 neemo. All rights reserved.
//

import UIKit

enum Auth
{
    // MARK: Use cases
    
    enum Login
    {
        struct Request
        {
            var params : Dictionary =     ["grant_type" : "password",
                                              "username"   :  "carlos@nimbl3.com",
                                              "password"   : "antikera"]
        }
        struct Response
        {
            var session : SessionModel
        }
        struct ViewModel
        {
        }
    }
}
