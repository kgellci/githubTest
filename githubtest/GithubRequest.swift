//
//  GithubService.swift
//  githubtest
//
//  Created by kriser gellci on 1/19/16.
//  Copyright © 2016 gellci. All rights reserved.
//

import Foundation

enum GithubSort: String {
    case Stars = "stars"
    case Forks = "forks"
    case Updated = "updated"
}

enum GithubSortOrder: String {
    case Ascending = "asc"
    case Descending = "desc"
}

enum GithubQuery {
    case Stars(UInt)
}

enum GithubRequestParamater {
    case Query(GithubQuery)
    case Sort(GithubSort)
    case Order(GithubSortOrder)
}

enum GithubURL: String {
    case Base = "https://api.github.com/search/"
    case Repositories = "repositories?"
    
    static func repositoriesUrl() -> String {
        return GithubURL.Base.rawValue + GithubURL.Repositories.rawValue
    }
}

class GithubRequest {
    let query: GithubQuery
    var sort: GithubSort?
    var sortOrder: GithubSortOrder?
    var page = 1
    
    var path: NSURL {
        return NSURL(string: (GithubURL.repositoriesUrl() + computePath()).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
    }
    
    
    init(query: GithubQuery) {
        self.query = query
    }
    
    private func computePath() -> String {
        var path = "q="
        
        switch query {
        case .Stars(let numbStars):
            path += "stars:>=\(numbStars)"
            break
        }
        
        guard let sort = sort else { return path }
        path += "&sort=\(sort.rawValue)"
        
        guard let sortOrder = sortOrder else { return path }
        path += "&order=\(sortOrder.rawValue)"
        path += "&page=\(page)"
        
        return path
    }
}