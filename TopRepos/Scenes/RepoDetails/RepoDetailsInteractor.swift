//
//  RepoDetailsInteractor.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

protocol RepoDetailsInteractorProtocol {
    func fetchPulls()
    func getRepoName()
}

class RepoDetailsInteractor: RepoDetailsInteractorProtocol {
    var presenter: RepoDetailsPresenterProtocol?
    
    var repo: Repo
    var pulls: [Pull] = []
    
    init(with repo: Repo) {
        self.repo = repo
    }
    
    // MARK: - RepoDetailsInteractorProtocol
    func getRepoName() {
        presenter?.presentRepoName(repo.name)
    }
    
    func fetchPulls() {
        GithubService.sharedInstance().getPullsByRepo(userName: repo.owner.name, repoName: repo.name) { (pulls, error) in
            if let pulls = pulls {
                self.pulls = pulls
                self.presenter?.presentPullsList(pulls)
            }
        }
    }
    
}
