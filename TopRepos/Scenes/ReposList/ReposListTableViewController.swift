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
    func displayActivityIndicator(_ animated: Bool)
}

class ReposListTableViewController: UITableViewController, ReposListTableViewControllerProtocol {
    
    var interactor: ReposListInteractorProtocol?
    let cellId = "reposListCell"
    var reposViewModel: [ReposList.ViewModel.DisplayedRepo] = []
    let activity = UIActivityIndicatorView(style: .gray)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Repos"
        self.tableView.register(UINib(nibName: "ReposListTableViewCell", bundle: Bundle(for: ReposListTableViewCell.self)), forCellReuseIdentifier: cellId)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        interactor?.fetchRepos()
    }
    
    // MARK: - ReposListTableViewControllerProtocol
    func displayReposList(viewModel: [ReposList.ViewModel.DisplayedRepo]) {
        reposViewModel = viewModel
        tableView.reloadData()
    }
    
    func showDetailsScene(with repo: Repo) {
        TopReposRouter.showRepoPullDetails(from: self, repo: repo)
    }
    
    func displayActivityIndicator(_ animated: Bool) {
        if animated {
            activity.startAnimating()
        } else {
            activity.stopAnimating()
        }
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
        
        if let url = viewModel.ownerPhotoUrl {
            GithubService.sharedInstance().getImage(withURL: url ) { image in
                cell.ownerPhotoImageView.image = image
            }
        }
        interactor?.didShowRepo(at: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        footerView.backgroundColor = .white
        activity.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(activity)
        let centerX = activity.centerXAnchor.constraint(equalTo: footerView.centerXAnchor)
        let centerY = activity.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        footerView.addConstraints([centerX, centerY])
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectItem(at: indexPath.row)
    }
    
   
}
