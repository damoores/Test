//
//  ProfileViewController.swift
//  GoGoGitHub
//
//  Created by Jeremy Moore on 6/29/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

protocol ProfileViewControllorDelegate: class {
    func profileViewControllerDidFinish()
}

class ProfileViewController: UIViewController, Setup {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    weak var delegate: ProfileViewControllorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        setup()
    }
    
    
    //MARK: Setup
    
    func setup() {
        API.shared.GETUser { (user) in
            if let user = user {
                self.nameLabel.text = user.name
                self.locationLabel.text = user.location
                print("user: \(user)")
            }
        }
    }
    
        func setupAppearance() { }
    
    @IBAction func closeButtonPressed(sender: UIButton) {
 
            self.delegate?.profileViewControllerDidFinish()
    }
}
