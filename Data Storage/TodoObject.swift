//
//  TodoObject.swift
//  Data Storage
//
//  Created by Pavel Koyushev on 14.01.2021.
//

import Foundation
import RealmSwift

class TodoObject: Object {
    @objc dynamic var date: String = "TodoObject: date"
    @objc dynamic var task: String = "TodoObject: task"
}
