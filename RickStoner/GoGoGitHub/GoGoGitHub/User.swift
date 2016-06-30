//
//  User.swift
//  GoGoGitHub
//
//  Created by Jeremy Moore on 6/29/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

struct User
{
    let name: String
    let location: String?
    
    init?(json: [String : AnyObject])
    {
        print(json)
        if let name = json["name"] as? String{
            let location = json["location"] as? String
            self.name = name
            self.location = location
        }


        else {
            return nil
        }
    }
}