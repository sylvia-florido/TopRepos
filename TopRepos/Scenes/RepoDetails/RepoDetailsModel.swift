//
//  RepoDetailsModel.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//


import Foundation

enum PullsList {
    struct ViewModel {
        var displayedPulls: [DisplayedPull]
        
        struct DisplayedPull {
            var title: String
            var body: String
            var date: String
            var userName: String
            var userPhotoUrl: URL?
        }
    }
}
