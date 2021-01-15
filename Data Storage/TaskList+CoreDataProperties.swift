//
//  TaskList+CoreDataProperties.swift
//  
//
//  Created by Pavel Koyushev on 14.01.2021.
//
//

import Foundation
import CoreData


extension TaskList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskList> {
        return NSFetchRequest<TaskList>(entityName: "TaskList")
    }

    @NSManaged public var task: String?
    @NSManaged public var date: String?

}
