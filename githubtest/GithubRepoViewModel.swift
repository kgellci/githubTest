//
//  GithubRepoViewModel.swift
//  githubtest
//
//  Created by kriser gellci on 1/21/16.
//  Copyright © 2016 gellci. All rights reserved.
//

import Foundation

protocol GithubViewModelDelegate: class {
    func viewModelUpdated()
}

class GithubRepoViewModel: NSObject {
    let repo: GithubRepo
    var title: String {
        return repo.title
    }
    var desc: String = ""
    let stars: String
    var language: String = ""
    var topContributor:String = ""
    
    weak var delegate: GithubViewModelDelegate?
    
    
    init(repo: GithubRepo) {
        self.repo = repo
        self.stars = "Stars: \(repo.stars)"
        
        if let description = repo.desc {
            self.desc = description
        }
        
        if let language = repo.language {
            self.language = language
        }
        
        if let topContributor = repo.topContributor {
            self.topContributor = topContributor
        }
        
        super.init()
        self.repo.addObserver(self, forKeyPath: "topContributor", options: .New, context: nil)
    }
    
    deinit {
        self.repo.removeObserver(self, forKeyPath: "topContributor")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "topContributor" {
            guard let topContributor = repo.topContributor else { return }
            self.topContributor = topContributor
            delegate?.viewModelUpdated()
        }
    }
}