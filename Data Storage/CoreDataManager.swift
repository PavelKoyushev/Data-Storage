//
//  CoreDataManager.swift
//  Data Storage
//
//  Created by Pavel Koyushev on 14.01.2021.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "CoreDataModel")
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  private init() {}
  
  func saveContext () {
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
    
  func insertTask(task: String, date: String)->TaskList? {
    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "TaskList", in: managedContext)!
    let newTask = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    newTask.setValue(task, forKeyPath: "task")
    newTask.setValue(date, forKeyPath: "date")
    print("\(String(describing: newTask.value(forKey: "task")))")
    print("\(String(describing: newTask.value(forKey: "date")))")

    do {
        try managedContext.save()
        print("Saved!")
        return newTask as? TaskList
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
        return nil
    }
  }
  
  func delete(task : TaskList){
    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    do {
        managedContext.delete(task)
    }
    
    do {
        try managedContext.save()
    } catch {
        print(error)
    }
  }
  
  func fetchAllTasks() -> [TaskList]?{
    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TaskList")
    
    do {
        let task = try managedContext.fetch(fetchRequest)
        return task as? [TaskList]
        
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
        return nil
    }
  }
}
