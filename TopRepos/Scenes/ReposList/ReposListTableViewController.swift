//
//  ReposListTableViewController.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import UIKit

protocol ReposListTableViewControllerProtocol: class {
    func displayReposList(viewModel: [ReposList.ViewModel.DisplayedRepo])
    func showDetailsScene(with repo: Repo)
}

class ReposListTableViewController: UITableViewController, ReposListTableViewControllerProtocol {
    
    var interactor: ReposListInteractorProtocol?
    let cellId = "reposListCell"
    var reposViewModel: [ReposList.ViewModel.DisplayedRepo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Repos"
        self.tableView.register(UINib(nibName: "ReposListTableViewCell", bundle: Bundle(for: ReposListTableViewCell.self)), forCellReuseIdentifier: cellId)
        interactor?.fetchRepos()
    }
    
    
    
    // MARK: - ReposListTableViewControllerProtocol
    func displayReposList(viewModel: [ReposList.ViewModel.DisplayedRepo]) {
        reposViewModel = viewModel
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ReposListTableViewCell
        let viewModel = reposViewModel[indexPath.row]
        cell.repoNameLabel.text = viewModel.name
        cell.repoDescriptionLabel.text = viewModel.repoDescription
        cell.forksLabel.text = viewModel.forks
        cell.starsLabel.text = viewModel.stars
        cell.ownerNameLabel.text = viewModel.ownerName
        cell.ownerFullNameLabel.text = viewModel.ownerFullName
        
        if let url = viewModel.ownerPhotoUrl {
            GithubService.sharedInstance().getImage(withURL: url ) { image in
                cell.ownerPhotoImageView.image = image
            }
        }
        interactor?.didShowRepo(at: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectItem(at: indexPath.row)
    }
    
    func showDetailsScene(with repo: Repo) {
        TopReposRouter.showRepoPullDetails(from: self, repo: repo)
    }
    
}
