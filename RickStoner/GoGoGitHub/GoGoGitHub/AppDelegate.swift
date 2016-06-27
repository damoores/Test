//
//  AppDelegate.swift
//  GoGoGitHub
//
//  Created by Rick  on 6/27/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(app: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
    print("AppDelegate - OpenURL func URL: ", url)
        GitHubOAuth.shared.tokenRequestWithCallBack(url, option: SaveOptions.userDefaults) { (success) in
            if success {
                print("We have a token")
            }
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }


}

