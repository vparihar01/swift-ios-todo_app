//
//  ViewController.swift
//  MyTodo
//
//  Created by Vivek Parihar on 12/03/2015.
//  Copyright (c) 2015 Vivek Parihar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var todoItems = [ToDoItem]()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    var todoTableView = UITableView(frame: CGRectZero, style: .Plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        let newTodo = NSEntityDescription.insertNewObjectForEntityForName("ToDoItem", inManagedObjectContext: self.managedObjectContext!) as ToDoItem
//        
//        newTodo.title = "Testing core data to write to do app"
//        newTodo.todoText = "This is first todo entry for my app. Just make to do app in which we can enter to do"
//        println(managedObjectContext)
//        println(newTodo.title)
        
        if let moc = managedObjectContext {
            var items = [
                ("Industry" , "Procution"),
                ("Medium" , "Video"),
                ("Tagert Audience" , "Cocnsumer+Small Bussinesses"),
                ("Targeted Geographic" , "India")
            ]
            for (todoTitle, todoText) in items {
                ToDoItem.createInManagedObjectContext(moc, title: todoTitle, text: todoText)
            }
        
        
        var viewFrame = self.view.frame
        viewFrame.origin.y += 10
        viewFrame.size.height -= 30
        todoTableView.frame = viewFrame
        self.view.addSubview(todoTableView)
        
        todoTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "ToDoCell")
        todoTableView.dataSource = self
        todoTableView.delegate = self
            
        }
        fetchLog()
    }
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "ToDoItem")
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [ToDoItem]{
            todoItems = fetchResults
        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell") as UITableViewCell
        
        let todoItem = todoItems[indexPath.row]
        cell.textLabel?.text = todoItem.title
        println(todoItem.title)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let todoItem = todoItems[indexPath.row]
        
        println(todoItem.title)
    }
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        //Create a new fetch request using ToDoitem netity
//        let fetchRequest = NSFetchRequest(entityName: "ToDoItem")
//        
//        //Execute the fetc request, and caste the fetch result to an array of ToDoitem objects
//        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [ToDoItem] {
//            
//            //create an alert and set it's msg to whatever todoText is
//            let alert = UIAlertController(title: fetchResults[0].title,
//                message: fetchResults[0].todoText,
//                preferredStyle: .Alert)
//            
//            //Display alert
//            self.presentViewController(alert,
//                animated: true,
//                completion: nil)
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

