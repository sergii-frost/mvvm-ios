//
//  GHUserProfile.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-22.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import Foundation
import Unbox

//{
//    "login": "octocat",
//    "id": 583231,
//    "avatar_url": "https://avatars3.githubusercontent.com/u/583231?v=4",
//    "gravatar_id": "",
//    "url": "https://api.github.com/users/octocat",
//    "html_url": "https://github.com/octocat",
//    "followers_url": "https://api.github.com/users/octocat/followers",
//    "following_url": "https://api.github.com/users/octocat/following{/other_user}",
//    "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
//    "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
//    "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
//    "organizations_url": "https://api.github.com/users/octocat/orgs",
//    "repos_url": "https://api.github.com/users/octocat/repos",
//    "events_url": "https://api.github.com/users/octocat/events{/privacy}",
//    "received_events_url": "https://api.github.com/users/octocat/received_events",
//    "type": "User",
//    "site_admin": false,
//    "name": "The Octocat",
//    "company": "GitHub",
//    "blog": "http://www.github.com/blog",
//    "location": "San Francisco",
//    "email": null,
//    "hireable": null,
//    "bio": null,
//    "public_repos": 7,
//    "public_gists": 8,
//    "followers": 2012,
//    "following": 5,
//    "created_at": "2011-01-25T18:44:36Z",
//    "updated_at": "2017-10-29T22:32:57Z"
//}

struct GHUser {
    let login: String
    let avatarUrl: String
    let name: String
    let company: String?
    let location: String?
    let email: String?
    let bio: String?
    let blog: String?
    let followers: Int
    let following: Int
    let createdAt: Date
    let publicRepos: Int
    let publicGists: Int
    let reposUrl: String
    let gistsUrl: String
}

extension GHUser: Unboxable {
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
    
    init(unboxer: Unboxer) throws {
        self.login = try unboxer.unbox(key: "login")
        self.avatarUrl = try unboxer.unbox(key: "avatar_url")
        self.name = try unboxer.unbox(key: "name")
        self.company = unboxer.unbox(key: "company")
        self.location = unboxer.unbox(key: "location")
        self.email = unboxer.unbox(key: "email")
        self.bio = unboxer.unbox(key: "bio")
        self.blog = unboxer.unbox(key: "blog")
        self.followers = try unboxer.unbox(key: "followers")
        self.following = try unboxer.unbox(key: "following")
        self.createdAt = try unboxer.unbox(key: "created_at", formatter: GHUser.dateFormatter)
        self.publicRepos = try unboxer.unbox(key: "public_repos")
        self.publicGists = try unboxer.unbox(key: "public_gists")
        self.reposUrl = try unboxer.unbox(key: "repos_url")
        self.gistsUrl = try unboxer.unbox(key: "gists_url")
    }
}
