//
//  APIClient.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-22.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import Foundation
import Alamofire


let GET = Alamofire.HTTPMethod.get
let POST = Alamofire.HTTPMethod.post
let PUT = Alamofire.HTTPMethod.put
let DELETE = Alamofire.HTTPMethod.delete

let kInvalidUrlStatusCode = 2038
let kInvalidUrlMessage = "Your url is invalid: "

let kBaseUrl = "https://api.github.com"
let kUserPath = "/users/"

public class APIClient {
    
    private init() {
        //Avoid public instantiation
    }
    
    static func apiUrl(forPath path: String, parameters: [String: Any]? = nil) -> URL? {
        
        guard let urlComponents = NSURLComponents(string: kBaseUrl + path) else {
            return nil
        }
        
        //Check if we have any parameters, if yes, then add them as query params
        if let parameters = parameters {
            
            urlComponents.queryItems = parameters.map({ (key: String, value: Any) -> URLQueryItem in
                return URLQueryItem(name: key, value: String(describing: value))
            })
        }
        
        return urlComponents.url
    }
}

//MARK: private methods
fileprivate extension APIClient {
    static func httpBody(fromDictionary dictionary: [String: Any?]) throws -> Data {
        return try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions())
    }
}
