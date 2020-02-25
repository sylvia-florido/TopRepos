//
//  RepoDetailsPresenter.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

protocol RepoDetailsPresenterProtocol {
    func presentRepoName(_ repoName: String)
    func presentPullsList(_ pulls: [Pull])
}

class RepoDetailsPresenter: RepoDetailsPresenterProtocol {
    weak var viewController: RepoDetailsViewControllerProtocol?
    
    func presentRepoName(_ repoName: String) {
        viewController?.displayRepoName(repoName)
    }
    
    func presentPullsList(_ pulls: [Pull]) {
        var displayedPulls: [PullsList.ViewModel.DisplayedPull] = []
        for pull in pulls {
            let viewModel = PullsList.ViewModel.DisplayedPull(title: pull.title, body: pull.body, date: Date.utcToLocalDateString(pull.date) ?? "", userName: pull.user.name, userPhotoUrl: URL(string:pull.user.photoUrlString))
            displayedPulls.append(viewModel)
        }
        viewController?.displayPullsList(viewModel: displayedPulls)
    }
    
}
