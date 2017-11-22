//
//  APIClient+Github.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-22.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import Foundation

extension APIClient {
    
    static func getUserProfile(username: String, success: @escaping APISuccessCallback, failure: @escaping APIFailureCallback) {
        let escapedUsername =  username.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? username
        let path = kUserPath + escapedUsername
        guard let url = apiUrl(forPath: path) else {
            failure(kInvalidUrlMessage + path, kInvalidUrlStatusCode)
            return
        }
        
        NetworkInterceptor.run(
            request: URLRequest(url: url),
            method: GET, success: { response in
                success(response.data)
            }, failure: failure)
    }
}
