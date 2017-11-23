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
    @IBOutlet weak var linkView: UIView!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var reposContainerView: UIView!
    @IBOutlet weak var reposLabel: UILabel!
    @IBOutlet weak var gistsContainerView: UIView!
    @IBOutlet weak var gistsLabel: UILabel!
    
    //MARK: IBActions
    
    @IBAction func showRepos(_ sender: Any) {
        //TODO: implement
    }
    
    @IBAction func showGists(_ sender: Any) {
        //TODO: implement
    }

}
