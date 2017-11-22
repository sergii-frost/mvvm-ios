//
//  ViewController.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-22.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var debugTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pushMe(_ sender: Any) {
        demoLog(inputTextField.text)
    }
    
    fileprivate func demoLog(_ message: String?) {
        guard let message = message else {
            return
        }
        debugTextView.text = "\(message)\n\(debugTextView.text ?? "")"
    }
}

