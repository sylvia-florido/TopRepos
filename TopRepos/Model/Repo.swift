//
//  Repo.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

struct Repo: Decodable {
    let id: Int
    let name: String
    let forks: Int
    let stars: Int
    let repoDescription: String?
    let owner: User
    
    private enum CodingKeys: String, CodingKey {
        case stars = "stargazers_count"
        case repoDescription = "description"
        case id, name, forks, owner
    }
    
    init(id: Int, name: String, forks: Int, stars: Int, repoDescription: String, owner: User) {
        self.id = id
        self.name = name
        self.forks = forks
        self.stars = stars
        self.repoDescription = repoDescription
        self.owner = owner
    }
}
