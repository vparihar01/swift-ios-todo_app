//
//  ToDoItem.swift
//  MyTodo
//
//  Created by Vivek Parihar on 12/03/2015.
//  Copyright (c) 2015 Vivek Parihar. All rights reserved.
//

import Foundation
import CoreData

class ToDoItem: NSManagedObject {

    @NSManaged var todoText: String
    @NSManaged var title: String
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, title: String, text: String) -> ToDoItem {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("ToDoItem", inManagedObjectContext: moc) as ToDoItem
        newItem.title = title
        newItem.todoText = text
        
        return newItem
    }
}
