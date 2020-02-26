//
//  ErrorViewController.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import UIKit
import Lottie

protocol ErrorViewControllerDelegate: class {
    func didTapTryAgain()
    func didTapTryLater()
}

class ErrorViewController: UIViewController {

    @IBOutlet weak var animationContainer: UIView!
    weak var delegate: ErrorViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Oops !"
        
        setupAnimation()
    }

    private func setupAnimation() {
        let animationView = AnimationView(name: "errorAnimation")
        animationContainer.addSubview(animationView)
        animationView.frame = animationContainer.bounds
        animationView.play()
        animationView.loopMode = .loop
    }

    @IBAction func tryAgain(_ sender: UIButton) {
        print("Try Again")
        delegate?.didTapTryAgain()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tryLater(_ sender: UIButton) {
        print("Try later")
        delegate?.didTapTryLater()
        dismiss(animated: true, completion: nil)
    }
}
