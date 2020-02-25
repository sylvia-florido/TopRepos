//
//  TopReposRouter.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation
import UIKit

class TopReposRouter {
    
    // Entry point
    @objc public static func reposListEntryPoint() -> UIViewController {
        let controller = ReposListTableViewController()
        let interactor = ReposListInteractor()
        let presenter = ReposListPresenter()
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
    
    
    // In module navigation
    static func showRepoPullDetails(from originController: UIViewController, repo: Repo) {
        let controller = RepoDetailsViewController()
        let interactor = RepoDetailsInteractor(with: repo)
        let presenter = RepoDetailsPresenter()
        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller
        
        interactor.repo = repo
        
        originController.navigationController?.pushViewController(controller, animated: true)
    }
    
}
