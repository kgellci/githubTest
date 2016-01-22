//
//  ViewController.swift
//  githubtest
//
//  Created by kriser gellci on 1/19/16.
//  Copyright © 2016 gellci. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GithubDataSource {
    @IBOutlet weak var tableView: UITableView!
    var repoSource :GithubRepoSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        repoSource = GithubRepoSource(delegate: self)
        repoSource?.getLatestRepos()
    }
    
    func githubDataRefreshed() {
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = repoSource?.repoViewModels.count else { return 0 }
        return rows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(GithubRepoCell.cellIdentifier) as! GithubRepoCell
        cell.updateWithRepoViewModel(repoSource!.repoViewModels[indexPath.row])
        if indexPath.row == repoSource!.repoViewModels.count - 1 {
            repoSource?.getMoreRepos()
        }
        return cell
    }
}

