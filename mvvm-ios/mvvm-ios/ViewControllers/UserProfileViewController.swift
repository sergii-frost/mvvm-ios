//
//  UserProfileViewController.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-23.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import UIKit

public class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var companyContainerView: UIView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationContainerView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var linkContainerView: UIView!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var reposContainerView: UIView!
    @IBOutlet weak var reposLabel: UILabel!
    @IBOutlet weak var gistsContainerView: UIView!
    @IBOutlet weak var gistsLabel: UILabel!
    
    var username: String?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserProfile()
    }
    
    func fetchUserProfile() {
        guard let username = username else {
            self.handleError(message: "Username is empty, cannot fetch data", statusCode: 404)
            return
        }
        
        GithubService.shared.getUserProfile(with: username, success: { [weak self] user in
            self?.updateUI(with: user)
        }, failure: { [weak self] message, statusCode in
            self?.handleError(message: message, statusCode: statusCode)
        })
    }
    
    func updateUI(with user: GHUser) {
        
        MessageHelper.showMessage(
            forType: .success,
            title: "Great success!",
            message: "User profile for \(username ?? "") was successfully fetched")
    }
    
    func handleError(message: String, statusCode: Int) {
        MessageHelper.showMessage(forType: .error, message: message)
    }
    
    //MARK: IBActions
    
    @IBAction func showRepos(_ sender: Any) {
        //TODO: implement
    }
    
    @IBAction func showGists(_ sender: Any) {
        //TODO: implement
    }

}
