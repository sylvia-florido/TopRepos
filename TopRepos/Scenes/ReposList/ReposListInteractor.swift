//
//  ReposListInteractor.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//


import Foundation

protocol ReposListInteractorProtocol {
    func fetchRepos()
    func didShowRepo(at index: Int)
    func didSelectItem(at index: Int)
}

class ReposListInteractor: ReposListInteractorProtocol {
    
    var presenter: ReposListPresenterProtocol?
    var data: [[String:String]] = [[:]]
    var repos: [Repo] = []
    var nextPage = 1
    var fetching = false
    
    // MARK: - ReposListInteractorProtocol
    func fetchRepos() {
        fetching = true
        GithubService.sharedInstance().getRepoByLanguage(language: "Swift", sort: "stars", page: String(nextPage)) { (repos, error) in
            if let repos = repos {
                self.nextPage += 1
                self.repos.append(contentsOf: repos)
                self.presenter?.presentReposList(self.repos)
            }
            self.fetching = false
        }
    }
    
    func didShowRepo(at index: Int) {
        if ((repos.count - index) < 30) && !fetching {
            fetchRepos()
        }
    }
    
    func didSelectItem(at index: Int) {
        let repo = repos[index]
        presenter?.presentDetailsScene(with: repo)
    }
    
}

