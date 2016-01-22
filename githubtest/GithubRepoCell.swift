//
//  GithubRepoCell.swift
//  githubtest
//
//  Created by kriser gellci on 1/21/16.
//  Copyright © 2016 gellci. All rights reserved.
//

import UIKit

class GithubRepoCell: UITableViewCell, GithubViewModelDelegate {
    static let cellIdentifier = "GithubRepoCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var contributorLabel: UILabel!
    var repoViewModel: GithubRepoViewModel?
    
    override func prepareForReuse() {
        repoViewModel?.delegate = nil
    }
    
    func updateWithRepoViewModel(repoViewModel: GithubRepoViewModel) {
        self.repoViewModel = repoViewModel
        repoViewModel.delegate = self
        updateUI()
    }
    
    func updateUI() {
        self.titleLabel.text = repoViewModel!.title
        self.descriptionLabel.text = repoViewModel!.desc
        self.starLabel.text = repoViewModel!.stars
        self.languageLabel.text = repoViewModel!.language
        self.contributorLabel.text = repoViewModel!.topContributor
    }
    
    func viewModelUpdated() {
        updateUI()
    }
}
