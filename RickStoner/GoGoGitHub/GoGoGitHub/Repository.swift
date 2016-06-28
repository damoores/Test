//
//  Repository.swift
//  GoGoGitHub
//
//  Created by Rick  on 6/28/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

struct Repository
{
    let name: String
    let description: String?
    let id: Int
    let createdAt: NSDate
    let openIssues: Int
    let url: String
    let language: String?
    let owner: Owner?
    
    init?(json: [String : AnyObject])
    {
        if let name = json["name"] as? String, id = json["id"] as? Int, openIssues = json["open_issues_count"] as? Int, url = json["url"] as? String {
            self.name = name
            self.id = id
            self.openIssues = openIssues
            self.url = url
            
            self.description = json["description"] as? String
            self.createdAt = NSDate.dateFromString(json["created_at"] as! String)
            self.language = json["language"] as? String
            self.owner = Owner(json: json["owner"] as! [String : AnyObject])
        }
            
        else {
            return nil
        }
    }
}