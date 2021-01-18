//
//  RealmDataManager.swift
//  Data Storage
//
//  Created by Pavel Koyushev on 14.01.2021.
//

import Foundation
import RealmSwift

class RealmDataManager {
    
    private let realm = try! Realm()
    
    static let shared = RealmDataManager()
    
    private init() {}
    
    func add(taskText: String) {
        let item = TodoObject()
        try! realm.write {
            realm.add(item)
            item.date = DateString()
            item.task = taskText
        }
        realm.refresh()
    }
    
    func remove(todo: TodoObject) {
        try! realm.write {
            realm.delete(todo)
        }
    }
    
    func getTasks() -> Results<TodoObject> {
        return realm.objects(TodoObject.self)
    }
}

extension RealmDataManager {
    private func DateString() -> String {
        let (rawDate, dateFormatter) = (Date(), DateFormatter())
            dateFormatter.dateFormat = "dd.MM.YY HH:mm"
        let DateString = dateFormatter.string(from: rawDate)
        return DateString
    }
}
