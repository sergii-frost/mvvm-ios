//
//  UserProfileViewController.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-23.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import UIKit
import Kingfisher

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
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }()
    
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
        if let url = URL(string: user.avatarUrl) {
            avatarImageView.kf.setImage(with: url)
        }
        nameLabel.text = user.name
        loginLabel.text = user.login
        
        if let bio = user.bio, !bio.isEmpty {
            bioTextView.isHidden = false
            bioTextView.text = bio
        } else {
            bioTextView.isHidden = true
        }
        createdLabel.text = dateFormatter.string(from: user.createdAt)
        
        if let company = user.company, !company.isEmpty {
            companyContainerView.isHidden = false
            companyLabel.text = company
        } else {
            companyContainerView.isHidden = true
        }
        
        if let location = user.location, !location.isEmpty {
            locationContainerView.isHidden = false
            locationLabel.text = location
        } else {
            locationContainerView.isHidden = true
        }
        
        if let email = user.email, !email.isEmpty {
            emailContainerView.isHidden = false
            emailLabel.text = email
        } else {
            emailContainerView.isHidden = true
        }
        
        if let link = user.blog, !link.isEmpty {
            linkContainerView.isHidden = false
            linkLabel.text = link
        } else {
            linkContainerView.isHidden = true
        }
        
        if user.publicRepos > 0 {
            reposContainerView.isHidden = false
            reposLabel.text = "Public Repos #: \(user.publicRepos)"
        } else {
            reposContainerView.isHidden = true
        }
        
        if user.publicGists > 0 {
            gistsContainerView.isHidden = false
            gistsLabel.text = "Public Gists #: \(user.publicGists)"
        } else {
            gistsContainerView.isHidden = true
        }
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
