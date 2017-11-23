//
//  ViewController.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-22.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var debugTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pushMe(_ sender: Any) {
        guard let input = inputTextField.text else {
            demoLog("No input - nothing to ask for")
            return
        }
        GithubService.shared.getUserProfile(
            with: input,
            success: { [weak self] (userJson: String) in
                self?.demoLog(userJson)
            },
            failure: { [weak self] (message, statusCode) in
                self?.demoLog(message)
            }
        )
    }
    
    @IBAction func clear(_ sender: Any) {
        debugTextView.text = ""
        inputTextField.text = nil
    }
    
    @IBAction func openProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserProfile", bundle: Bundle.main)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            demoLog("Could not instantiate view controller for user profile")
            return
        }
        guard let viewController: UserProfileViewController = initialViewController as? UserProfileViewController else {
            demoLog("Initial ViewController is not of required type")
            return
        }
        viewController.username = inputTextField.text
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    fileprivate func demoLog(_ message: String?) {
        guard let message = message, !message.isEmpty else {
            return
        }
        debugTextView.text = "\(message)\n\(debugTextView.text ?? "")"
    }
}

