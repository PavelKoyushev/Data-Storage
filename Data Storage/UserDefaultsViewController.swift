//
//  ViewController.swift
//  Data Storage
//
//  Created by Pavel Koyushev on 14.01.2021.
//

import UIKit

class UserDefaultsViewController: UIViewController {
    
    @IBOutlet private weak var firstName: UITextField!
    @IBOutlet private weak var lastName: UITextField!
    
    private var userData = Persistance.shared
    
    @IBAction private func saveUserData(_ sender: UIButton) {
        firstName.becomeFirstResponder()
        userData.FirstNameData = firstName.text!
        userData.LastNameData = lastName.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        firstName.text = userData.FirstNameData
        lastName.text = userData.LastNameData
    }
}
