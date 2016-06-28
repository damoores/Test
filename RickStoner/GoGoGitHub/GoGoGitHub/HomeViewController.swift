//
//  HomeViewController.swift
//  GoGoGitHub
//
//  Created by Rick  on 6/28/16.
//  Copyright © 2016 Rick . All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Setup {

    @IBOutlet weak var tableView: UITableView!
    
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
}

extension HomeViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let repoCell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath)
        let repository = self.repositories[indexPath.row]
        
        repoCell.textLabel?.text = repository.name
        
        return repoCell
    }
}