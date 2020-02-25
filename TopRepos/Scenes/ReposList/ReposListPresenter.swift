//
//  ReposListPresenter.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

protocol ReposListPresenterProtocol {
    func presentReposList(_ repos: [Repo])
    func presentDetailsScene(with repo: Repo)
}

class ReposListPresenter: ReposListPresenterProtocol {
    
    weak var viewController: ReposListTableViewControllerProtocol?
    
    func presentReposList(_ repos: [Repo]) {
        var displayedRepos: [ReposList.ViewModel.DisplayedRepo] = []
        for repo in repos {
            let viewModel = ReposList.ViewModel.DisplayedRepo(name: repo.name, repoDescription: repo.repoDescription ?? "", forks: String(repo.forks), stars: String(repo.stars), ownerName: repo.owner.name, ownerFullName: repo.owner.name, ownerPhotoUrl: URL(string: repo.owner.photoUrlString))
            displayedRepos.append(viewModel)
        }
        viewController?.displayReposList(viewModel: displayedRepos)
    }
    
    func presentDetailsScene(with repo: Repo) {
        viewController?.showDetailsScene(with: repo)
    }
    
}
