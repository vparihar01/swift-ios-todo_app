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

}
