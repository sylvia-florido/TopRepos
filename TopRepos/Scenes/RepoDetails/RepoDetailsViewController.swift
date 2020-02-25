//
//  RepoDetailsViewController.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//


import UIKit

protocol RepoDetailsViewControllerProtocol: class {
    func displayRepoName(_ repoName: String)
    func displayPullsList(viewModel: [PullsList.ViewModel.DisplayedPull])
}

class RepoDetailsViewController: UIViewController, RepoDetailsViewControllerProtocol, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var openedPullsLabel: UILabel!
    @IBOutlet weak var closedPullsLabel: UILabel!
    
    var interactor: RepoDetailsInteractorProtocol?
    let cellId = "detailsCell"
    var pullsViewModel: [PullsList.ViewModel.DisplayedPull] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(UINib(nibName: "RepoDetailsTableViewCell", bundle: Bundle(for: RepoDetailsTableViewCell.self)), forCellReuseIdentifier: cellId)
        interactor?.getRepoName()
        interactor?.fetchPulls()
    }
    
    // MARK: - ReposListTableViewControllerProtocol
    func displayRepoName(_ repoName: String) {
        title = repoName
    }
    
    func displayPullsList(viewModel: [PullsList.ViewModel.DisplayedPull]) {
        pullsViewModel = viewModel
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepoDetailsTableViewCell
        let viewModel = pullsViewModel[indexPath.row]
        cell.pullNameLabel.text = viewModel.title
        cell.pullBodyLabel.text = viewModel.body
        cell.ownerNameLabel.text = viewModel.userName
        cell.pullDateLabel.text = viewModel.date
        
        if let url = viewModel.userPhotoUrl {
            GithubService.sharedInstance().getImage(withURL: url ) { image in
                cell.ownerPhotoImageView.image = image
            }
        }
        return cell
    }
}
