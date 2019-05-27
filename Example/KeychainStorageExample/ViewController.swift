//
//  ViewController.swift
//  KeychainStorageExample
//
//  Created by Dan, Radu-Ionut (RO - Bucharest) on 26/05/2019.
//  Copyright © 2019 radude89. All rights reserved.
//

import UIKit
import KeychainStorage

class ViewController: UIViewController {
    
    @IBOutlet weak var uiSwitch: UISwitch!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    private let keychain = MyAppKeychain.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLabel.text = "Enter your desired values to be stored in Keychain and touch 'Store Value' button."
    }
    
    func saveSecret() {
        
        let storage = KeychainStorage(service: "com.test.service")
        try? storage.removeAll()
        
        if let myStringValue = try? storage.string(forKey: "myStringKey") {
            // do something with myStringValue
        }
        
        if let myBoolValue = try? storage.bool(forKey: "myBoolKey") {
            // do something with myBoolValue
        }
        
        
        
    }

    @IBAction func onTouchStoreValues(_ sender: Any) {
        guard textField.text?.isEmpty == false else { return }
        
        keychain.rememberMe = uiSwitch.isOn
        keychain.secret = textField.text
        
        outputLabel.text = "Reading values from Keychain\n"
        
        outputLabel.text?.append("Remember me: \(keychain.rememberMe == true)\n")
        outputLabel.text?.append("Secret: \(keychain.secret ?? "-")")
    }
    
}
