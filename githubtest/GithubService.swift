//
//  GithubService.swift
//  githubtest
//
//  Created by kriser gellci on 1/20/16.
//  Copyright © 2016 gellci. All rights reserved.
//

import Foundation

typealias RepoRequestCompletion = (repos: [GithubRepo]?, success: Bool) -> Void
typealias RepoTopContributorCompletion = (top: String, success: Bool) -> Void

class GithubService {
    class func performGithubRepoRequest(request: GithubRequest, completion: RepoRequestCompletion) {
        NSURLSession.sharedSession().dataTaskWithURL(request.path) { (data, response, error) -> Void in
            guard let data = data else { completion(repos: nil, success: false); return }
            guard let repos = GithubJsonParser.repositoriesFromData(data) else { completion(repos: nil, success: false); return }
            completion(repos: repos, success: true)
        }.resume()
    }
    
    class func getTopContributorFromContributorsURL(contributorsURL: NSURL, completion: RepoTopContributorCompletion) {
        NSURLSession.sharedSession().dataTaskWithURL(contributorsURL) { (data, response, error) -> Void in
            guard let data = data else { completion(top: "", success: false); return }
            guard let topContributor = GithubJsonParser.topContributorFromData(data) else { completion(top: "", success: false); return }
            completion(top: topContributor, success: true)
            }.resume()
    }
}