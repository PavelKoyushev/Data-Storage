//
//  UDPersistance.swift
//  Data Storage
//
//  Created by Pavel Koyushev on 14.01.2021.
//

import Foundation

class Persistance {
    private let firstName = "UserDataPersistance.firstName"
    private let lastName = "UserDataPersistance.lastName"
    private let FirstRun = "UserDataPersistance.FirstRun"
    
    static let shared = Persistance()
    private init() {}
    
    var FirstNameData: String? {
        set { UserDefaults.standard.set (newValue, forKey: firstName) }
        get { return UserDefaults.standard.string (forKey: firstName) }
    }
    var LastNameData: String? {
        set { UserDefaults.standard.set (newValue, forKey: lastName) }
        get { return UserDefaults.standard.string (forKey: lastName) }
    }
    
    
    var FirstRunData: String? {
        set { UserDefaults.standard.set (newValue, forKey: FirstRun) }
        get { return UserDefaults.standard.string (forKey: FirstRun) }
    }
}
