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
    var oauthViewController: ViewController?
    var homeViewController: HomeViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.checkOAuthStatus()
        return true
    }
    
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        print("AppDelegate - OpenURL Func URL: \(url)")
        
        GitHubOAuth.shared.tokenRequestWithCallback(url, options: SaveOptions.Keychain) { (success) in
            if success{
                if let oauthViewController = self.oauthViewController {
                    UIView.animateWithDuration(0.4, delay: 1.0, options: .CurveEaseInOut, animations: { 
                        oauthViewController.view.alpha = 0.0
                        }, completion: { (finished) in
                            oauthViewController.view.removeFromSuperview()
                            oauthViewController.removeFromParentViewController()
                            
                            API.shared.checkForToken()
                            self.checkOAuthStatus()
                            self.homeViewController?.update()
                    })
                }
            } else {print("Nope")}
        }
        
        return true
    }
    
    // Makr: Setup
    
    func checkOAuthStatus() {
        do {
            let token = try GitHubOAuth.shared.accessToken()
            print(token)
        } catch _ {
            self.presentOAuthViewController()
        }
    }
    
    func presentOAuthViewController() {
        guard let homeViewController = self.window?.rootViewController as? HomeViewController else {
            fatalError("Check root view controller")
        }
        guard let storyboard = homeViewController.storyboard else { fatalError("Check for storyboard") }
        guard let oauthViewController = storyboard.instantiateViewControllerWithIdentifier(ViewController.id) as?
            ViewController else { fatalError("Error") }
        
        homeViewController.addChildViewController(oauthViewController)
        homeViewController.view.addSubview(oauthViewController.view)
        oauthViewController.didMoveToParentViewController(homeViewController)
        
        self.oauthViewController = oauthViewController
        self.homeViewController = homeViewController
        
    }

}

