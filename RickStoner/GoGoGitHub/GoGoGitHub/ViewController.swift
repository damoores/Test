//
//  ViewController.swift
//  GoGoGitHub
//
//  Created by Rick  on 6/27/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var login: UIButton!


    @IBAction func login(sender: AnyObject) {
        GitHubOAuth.shared.oAuthRequestWith(["scope" : "email,user,repo"])
    }
 
}

extension ViewController: Setup {
    func setup() {
        self.title = "Repositories"
    }
    
    func setupAppearance() {
        self.login.layer.cornerRadius = 3.0
    }
}

