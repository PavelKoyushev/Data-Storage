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
    
    func getTasks() -> Results<TodoObject> {
        return realm.objects(TodoObject.self) // возвращаем все объекты
    }
    
    func add(taskText: String) {
        let item = TodoObject()
        try! realm.write {
            realm.add(item)
            item.date = DateString() // привязываем дату
            item.task = taskText // передаем текст
        }
        realm.refresh()
    }
    
    func remove(todo: TodoObject) {
        try! realm.write {
            realm.delete(todo)
        }
    }
    
    // MARK: - Date to String
    private func DateString() -> String {
        let (rawDate, dateFormatter) = (Date(), DateFormatter())
            dateFormatter.dateFormat = "dd.MM.YY HH:mm"
        let DateString = dateFormatter.string(from: rawDate)
        return DateString
    }
}
