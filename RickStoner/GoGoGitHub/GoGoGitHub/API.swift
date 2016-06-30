//
//  API.swift
//  GoGoGitHub
//
//  Created by Rick  on 6/28/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import Foundation

class API {
    
    static let shared = API()
    
    private let session: NSURLSession
    private let template: NSURLComponents
    
    private init() {
        self.session = NSURLSession(configuration: .defaultSessionConfiguration())
        self.template = NSURLComponents()
        self.configure()
    }
    
    func checkForToken() {
        do {
            if let token = try GitHubOAuth.shared.accessToken() {
                self.template.queryItems = [NSURLQueryItem(name: "access_token", value: token)]
            }
        } catch{}
    }
    
    private func configure() {
        // this data is based on the API docs, same with the access_token
        self.template.scheme = "https"
        self.template.host = "api.github.com"
        self.checkForToken()
    }
    
    func GET(completion: (repositories: [Repository]?) -> ()) {
        self.template.path = "/user/repos"
        self.session.dataTaskWithURL(self.template.URL!) { (data, response, error) in
            if let error = error {
                print("Error: ", error)
            }
            
            if let data = data {
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [[String: AnyObject]] {
                        var repositories = [Repository]()
                        
                        for repositoryJSON in json {
                            if let repository = Repository(json: repositoryJSON) {
                                repositories.append(repository)
                            }
                        }
                        self.returnOnMain(repositories, completion: completion)
                        
                    }
                } catch {
                    self.returnOnMain(nil, completion: completion)
                }
            }
            }.resume()
    }
    
    func GETUser(completion: (user: User?) ->()) {
        
        self.template.path = "/user"
        self.session.dataTaskWithURL(self.template.URL!) { (data, response, error) in
            if let error = error {
                print(error)
            }
            if let data = data {
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String : AnyObject] {
                        let user = User(json: json)
                        print (user)
                        dispatch_async(dispatch_get_main_queue(), {
                            completion(user: user)
                        })
                    }
                }
                catch {
                    dispatch_async(dispatch_get_main_queue(), {
                    print(error)
                    completion(user: nil)
                    })
                }
            }
            
        }.resume()
    }
    
    func POSTRepo(name: String, completion: (success: Bool)->()) {
        self.template.path = "/user/repos"
        
        let request = NSMutableURLRequest(URL: self.template.URL!)
        request.HTTPMethod = "POST"
        request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(["name" : name], options: .PrettyPrinted)
        
        let task = self.session.dataTaskWithRequest(request) { (data, response, error) in
            
            if let response = response as? NSHTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(success: true)
                    })
                default:
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(success: false)
                    })
                }
            }
        }
        task.resume()
    }
    
    private func returnOnMain(repositories: [Repository]?, completion: (repositories: [Repository]?) -> ()) {
        NSOperationQueue.mainQueue().addOperationWithBlock({
            completion(repositories: repositories)
        })
    }
}