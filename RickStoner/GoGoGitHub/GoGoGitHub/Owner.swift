//
//  Owner.swift
//  GoGoGitHub
//
//  Created by Rick  on 6/28/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

struct Owner
{
    let login: String
    let avatarUrl: String
    let id: Int
    let url: String
    
    init?(json: [String : AnyObject])
    {
        if let login = json["login"] as? String, avatarUrl = json["avatar_url"] as? String, id = json["id"] as? Int, url = json["url"] as? String {
            self.login = login
            self.avatarUrl = avatarUrl
            self.id = id
            self.url = url
        }
            
        else {
            return nil
        }
    }
}