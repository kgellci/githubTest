//
//  GithubJsonParser.swift
//  githubtest
//
//  Created by kriser gellci on 1/20/16.
//  Copyright © 2016 gellci. All rights reserved.
//

import Foundation

class GithubJsonParser {
    
    class func topContributorFromData(data: NSData) -> String? {
        guard let items = jsonFromData(data) as? [[String : AnyObject]] else { return nil }
        guard let item = items.first else { return "" }
        guard let top = item["login"] as? String else { return "" }
        return top
    }
    
    class func repositoriesFromData(data: NSData) -> [GithubRepo]? {
        guard let json = jsonFromData(data) else { return nil }
        guard let items = json["items"] as? [[String : AnyObject]] else { return nil }
        return repositoriesFromJSON(items)

    }
    
    class func jsonFromData(data: NSData) -> AnyObject? {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            return json
        } catch {
            // log error
        }
        return nil
    }
    
    class func repositoriesFromJSON(jsonArray: [[String: AnyObject]]) -> [GithubRepo] {
        var repos = [GithubRepo]()
        
        for item in jsonArray {
            let title = item["full_name"] as? String
            let description = item["description"] as? String
            let language = item["language"] as? String
            let stars = item["stargazers_count"] as? UInt
            let contributorUrl = item["contributors_url"] as? String
            
            let repo = GithubRepo(title: title!, stars: stars!)
            repo.desc = description
            repo.language = language
            repo.contributorsUrl = contributorUrl
            repos.append(repo)
        }
        
        return repos
    }
}