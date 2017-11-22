//
//  NetworkInterceptor.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-22.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

typealias APISuccessCallback = (Data?) -> Void
typealias AlamofireSuccessCallback = (DataResponse<Any>) -> Void
typealias APIFailureCallback = (String, Int) -> Void

let kUnknownStatusCode = 42
let kUnknownMessage = "Something went wrong. It happens."
let kNoInternetStatusCode = 1337
let kNoInternetMessage = "Ooops, seems you are offline. Is it even possible nowadays?"

fileprivate class SFRequestAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        if let _ = urlRequest.url {
            var mutableUrlRequest = urlRequest
            mutableUrlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            return mutableUrlRequest
        }
        
        return urlRequest
        
    }
}

public class NetworkInterceptor {
    
    class var isConnectedToInternet: Bool {
        guard let reachabilityManager = NetworkReachabilityManager() else { return false }
        return reachabilityManager.isReachable
    }
    
    static var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        let manager = SessionManager(configuration: configuration)
        manager.adapter = SFRequestAdapter()
        return manager
    }()
    
    static func run(request urlRequest: URLRequest, method: Alamofire.HTTPMethod?, success: @escaping AlamofireSuccessCallback, failure: @escaping APIFailureCallback) {
        if !isConnectedToInternet {
            failure(kNoInternetMessage, kNoInternetStatusCode)
            return
        }
        
        var mutableUrlRequest = urlRequest
        
        if let method = method {
            mutableUrlRequest.httpMethod = method.rawValue
        }
        
        sessionManager.request(mutableUrlRequest).validate(statusCode: 200..<300).responseJSON { response in
            response.result.ifSuccess {
                success(response)
            }
            response.result.ifFailure {
                interceptError(response, failure: failure)
            }
        }
    }
    
    fileprivate static func interceptError(_ response: DataResponse<Any>, failure: APIFailureCallback) {
        do {
            if let data = response.data {
                let apiError: APIError = try unbox(data: data)
                failure(apiError.message ?? kUnknownMessage, response.response?.statusCode ?? kUnknownStatusCode)
            } else {
                failure(kUnknownMessage, response.response?.statusCode ?? kUnknownStatusCode)
            }
        } catch {
            failure(error.localizedDescription, response.response?.statusCode ?? kUnknownStatusCode)
        }
    }
}
