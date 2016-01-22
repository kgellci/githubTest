//
//  File.swift
//  githubtest
//
//  Created by kriser gellci on 1/20/16.
//  Copyright © 2016 gellci. All rights reserved.
//

import Foundation

class GithubRepo: NSObject {
    let title: String
    let stars: UInt
    var language: String?
    var desc: String?
    var contributorsUrl: String?
    dynamic var topContributor: String?
    
    init(title: String, stars: UInt) {
        self.title = title
        self.stars = stars
    }
}