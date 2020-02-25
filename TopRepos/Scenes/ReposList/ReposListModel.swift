//
//  RepoListModel.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation
import UIKit

enum ReposList {
    
    struct ViewModel {
        var displayedRepos: [DisplayedRepo]
        var ownerPhoto: UIImage
        
        struct DisplayedRepo {
            var name: String
            var repoDescription: String
            var forks: String
            var stars: String
            var ownerName: String
            var ownerFullName: String
            var ownerPhotoUrl: URL?
        }
    }
}
