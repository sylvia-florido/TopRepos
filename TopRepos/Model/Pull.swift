//
//  Pull.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class Pull: NSObject, Decodable {
    let pullId: Int
    let title: String
    let body: String
    let date: String
    let user: User
    
    private enum CodingKeys: String, CodingKey {
        case pullId = "id"
        case date = "created_at"
        case title, body, user
    }
    
}
