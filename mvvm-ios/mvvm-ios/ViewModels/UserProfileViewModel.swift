//
//  UserProfileViewModel.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-23.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import Foundation
import RxSwift

public class UserProfileViewModel {
    var username: String?
    
    let login = Variable<String>("")
    var avatarUrl = Variable<String>("")
    var name = Variable<String?>(nil)
    var company = Variable<String?>(nil)
    var location = Variable<String?>(nil)
    var email = Variable<String?>(nil)
    var bio = Variable<String?>(nil)
    var blog = Variable<String?>(nil)
    var followers = Variable<Int>(0)
    var following = Variable<Int>(0)
    var createdAt = Variable<Date>(Date())
    var publicRepos = Variable<Int>(0)
    var publicGists = Variable<Int>(0)
    var reposUrl = Variable<String>("")
    var gistsUrl = Variable<String>("")
    
    var message = Variable<String?>(nil)
    var statusCode = Variable<Int>(0)
    
    public init(username: String?) {
        self.username = username
    }
    
    public func fetchProfile() {
        GithubService.shared.getUserProfile(with: username ?? "", success: { [weak self] user in
            self?.update(withUser: user)
        }, failure: { [weak self] message, statusCode in
            self?.message.value = message
            self?.statusCode.value = statusCode
        })
    }
    
    fileprivate func update(withUser user: GHUser) {
        login.value = user.login
        avatarUrl.value = user.avatarUrl
        name.value = user.name
        company.value = user.company
        location.value = user.location
        email.value = user.email
        bio.value = user.bio
        blog.value = user.blog
        followers.value = user.followers
        following.value = user.following
        createdAt.value = user.createdAt
        publicRepos.value = user.publicRepos
        publicGists.value = user.publicGists
        reposUrl.value = user.reposUrl
        gistsUrl.value = user.gistsUrl
    }
}
