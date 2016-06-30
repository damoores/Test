//
//  HomeViewController.swift
//  GoGoGitHub
//
//  Created by Rick  on 6/28/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Setup, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var transition = CustomModalTransition(duration: 1.0)
    var repositories = [Repository]() {
        didSet {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    lazy var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
    }
    
    func setup() {
        self.refreshControl.addTarget(self, action: #selector(HomeViewController.update), forControlEvents: .AllEvents)
    }
    
    func setupAppearance() {
        //
    }
    
    func update() {
        API.shared.GET { (repositories) in
            if let repositories = repositories {
                self.repositories = repositories
            }
        }
    }
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        
        let controller = UIAlertController(title: "Create", message: "Please enter a name", preferredStyle: .Alert)
        let createAction = UIAlertAction(title: "Create", style: .Default) { (action) in
            guard let textField = controller.textFields?.first else { return }
            
            if let text = textField.text {
                API.shared.POSTRepo(text, completion: { (success) in
                    if success {
                        print("oh hell yea, posted")
                    }
                })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        controller.addTextFieldWithConfigurationHandler(nil)
        controller.addAction(createAction)
        controller.addAction(cancelAction)
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource, ProfileViewControllorDelegate {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == ProfileViewController.id {
            
            if let profileViewController = segue.destinationViewController as? ProfileViewController
            {
                profileViewController.delegate = self
                profileViewController.transitioningDelegate = self
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let repoCell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath)
        let repository = self.repositories[indexPath.row]
        
        repoCell.textLabel?.text = repository.name
        
        return repoCell
    }
    
    //MARK: Delegate
    
    func profileViewControllerDidFinish() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
}