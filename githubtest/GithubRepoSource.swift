//
//  GithubRepoDataSource.swift
//  githubtest
//
//  Created by kriser gellci on 1/21/16.
//  Copyright © 2016 gellci. All rights reserved.
//

import Foundation

protocol GithubDataSource: class {
    func githubDataRefreshed()
}

class GithubRepoSource {
    weak var delegate: GithubDataSource?
    var repoViewModels = [GithubRepoViewModel]()
    private var page = 0
    
    init(delegate: GithubDataSource) {
        self.delegate = delegate
    }
    
    func getLatestRepos() {
        let request = starOrderedRepoRequest()
        fetchReposWithRequest(request)
    }
    
    func getMoreRepos() {
        let request = starOrderedRepoRequest()
        request.page = page + 1
        fetchReposWithRequest(request)
    }
    
    private func fetchContributorFroRepo(repo: GithubRepo) {
        guard let contributorsUrl = repo.contributorsUrl else { return }
        GithubService.getTopContributorFromContributorsURL(NSURL(string: contributorsUrl)!) { (top, success) -> Void in
            if success == false {
                // delegate method with error or log error
                return
            }
            dispatch_async(dispatch_get_main_queue(),{
                repo.topContributor = top
            })
        }
    }
    
    private func fetchReposWithRequest(request: GithubRequest) {
        weak var weakSelf = self
        GithubService.performGithubRepoRequest(request) { (repos, success) -> Void in
            if success == false {
                // delegate method with error or log error
                return
            }
            guard let repos = repos else { return }
            let incomingViewModels = repos.map({ (repo) -> GithubRepoViewModel in
                weakSelf?.fetchContributorFroRepo(repo)
                return GithubRepoViewModel(repo: repo)
            })
            weakSelf?.repoViewModels += incomingViewModels
            weakSelf?.page++
            
            guard let delegate = weakSelf?.delegate else { return }
            dispatch_async(dispatch_get_main_queue(),{
                delegate.githubDataRefreshed()
            })
        }
    }
    
    private func starOrderedRepoRequest() -> GithubRequest {
        let request = GithubRequest(query: .Stars(1))
        request.sort = .Stars
        request.sortOrder = .Descending
        
        return request
    }
}