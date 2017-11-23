//
//  MessageHelper.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-23.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import UIKit
import SwiftMessages

enum MessageType {
    case success
    case info
    case warning
    case error
    
    var theme: Theme {
        switch self {
        case .success:
            return Theme.success
        case .info:
            return Theme.info
        case .warning:
            return Theme.warning
        case .error:
            return Theme.error
        }
    }
}

public class MessageHelper {
    
    private init() {
        //avoid public instantiation
    }
    
    class func showMessage(forType type: MessageType, title: String? = nil, message: String? = nil) {
        
        var config = SwiftMessages.Config()
        config.duration = .seconds(seconds: 3)
        
        SwiftMessages.show(config: config) {
            let messageView = generateMessageView(forType: type)
            
            if let title = title {
                messageView.titleLabel?.text = title;
            } else {
                messageView.titleLabel?.isHidden = true
            }
            if let message = message {
                messageView.bodyLabel?.text = message
            } else {
                messageView.bodyLabel?.isHidden = true
            }
            
            return messageView
        }
    }
    
    static func showMessage(forError error: Error?) {
        MessageHelper.showMessage(forType: .error, title: nil, message: error?.localizedDescription)
    }
    
    private class func generateMessageView(forType type: MessageType) -> MessageView {
        let messageView = MessageView.viewFromNib(layout: .messageView)
        messageView.configureTheme(type.theme)
        
        //Hide iconLabel and button by default
        messageView.button?.isHidden = true
        messageView.iconLabel?.isHidden = true
        
        return messageView
    }
}
