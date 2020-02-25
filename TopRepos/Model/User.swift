//
//  User.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class User: NSObject, Decodable {
    let id: Int
    let name: String
    let photoUrlString: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case photoUrlString = "avatar_url"
    }
    
    init(id: Int, name: String, photoUrlString: String) {
        self.id = id
        self.name = name
        self.photoUrlString = photoUrlString
    }
}
