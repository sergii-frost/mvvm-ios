//
//  UserProfileViewModel.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-23.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import Foundation

public class UserProfileViewModel {
    var username: String
    
    var login: String = ""
    var avatarUrl: String = ""
    var name: String?
    var company: String?
    var location: String?
    var email: String?
    var bio: String?
    var blog: String?
    var followers: Int = 0
    var following: Int = 0
    var createdAt: Date = Date()
    var publicRepos: Int = 0
    var publicGists: Int = 0
    var reposUrl: String = ""
    var gistsUrl: String = ""
    
    var message: String?
    var statusCode: Int = 0
    
    public init(username: String) {
        self.username = username
    }
    
    public func fetchProfile() {
        GithubService.shared.getUserProfile(with: username, success: { [weak self] user in
            self?.update(withUser: user)
        }, failure: { [weak self] message, statusCode in
            self?.message = message
            self?.statusCode = statusCode
        })
    }
    
    fileprivate func update(withUser user: GHUser) {
        login = user.login
        avatarUrl = user.avatarUrl
        name = user.name
        company = user.company
        location = user.location
        email = user.email
        bio = user.bio
        blog = user.blog
        followers = user.followers
        following = user.following
        createdAt = user.createdAt
        publicRepos = user.publicRepos
        publicGists = user.publicGists
        reposUrl = user.reposUrl
        gistsUrl = user.gistsUrl
    }
}
