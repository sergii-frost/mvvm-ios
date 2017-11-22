//
//  GithubService.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-22.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import Foundation
import Unbox

public class GithubService {
    
    let shared = GithubService()
    
    private init() {
        //Avoid public instantiation
    }
    
    func getUserProfile(with username: String, success: @escaping (GHUser) -> Void, failure: @escaping APIFailureCallback) {
        APIClient.getUserProfile(username: username, success: { userResponse in
            guard let userResponse = userResponse else {
                failure(kUnknownMessage, kUnknownStatusCode)
                return
            }
            
            do {
                let user: GHUser = try unbox(data: userResponse)
                success(user)
            } catch {
                failure(error.localizedDescription, kUnboxErrorStatusCode)
            }
            
        }, failure: failure)
    }
}
