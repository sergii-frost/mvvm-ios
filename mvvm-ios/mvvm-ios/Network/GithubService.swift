//
//  GithubService.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-22.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import Foundation
import Unbox

typealias SuccessSimpleCallback = (String) -> Void

public class GithubService {
    
    static let shared = GithubService()
    
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
    
    func getUserProfile(with username: String, success: @escaping SuccessSimpleCallback, failure: @escaping APIFailureCallback) {
        APIClient.getUserProfile(username: username, success: { userResponse in
            GithubService.handleSimpleCallback(withData: userResponse, success: success, failure: failure)
        }, failure: failure)
    }
    
    fileprivate static func handleSimpleCallback(withData data: Data?, success: @escaping SuccessSimpleCallback, failure: @escaping APIFailureCallback) {
        guard let data = data else {
            failure(kUnknownMessage, kUnknownStatusCode)
            return
        }
        if let stringData = String(data: data, encoding: .utf8) {
            success(stringData)
        } else {
            failure(kUnknownMessage, kUnknownStatusCode)
        }
    }
}
