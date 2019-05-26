//
//  ViewController.swift
//  KeychainStorageExample
//
//  Created by Dan, Radu-Ionut (RO - Bucharest) on 26/05/2019.
//  Copyright © 2019 radude89. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var uiSwitch: UISwitch!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    private let keychain = MyAppKeychain.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLabel.text = "Enter your desired values to be stored in Keychain and touch 'Store Value' button."
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
