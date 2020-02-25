//
//  ReposByLanguageResponse.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class ReposByLanguageResponse: NSObject, Decodable {
    let totalCount: Int
    let repos: [Repo]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case repos = "items"
    }
}
