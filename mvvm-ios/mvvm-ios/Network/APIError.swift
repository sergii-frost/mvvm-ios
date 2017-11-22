//
//  APIErrorResponse.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-22.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import Foundation
import Unbox

struct APIError {
    let message: String?
}

extension APIError: Unboxable {
    init(unboxer: Unboxer) throws {
        message = unboxer.unbox(key: "message")
    }
}
