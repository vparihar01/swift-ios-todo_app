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
  
  // Create the an empty array of ToDoItem
  var todoItems = [ToDoItem]()
  
  // Retrieve the managaed Object context from AppDlegate
  let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
  
  // Creates the table view as soon as this class loads
  var todoTableView = UITableView(frame: CGRectZero, style: .Plain)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //        newTodo.title = "Testing core data to write to do app"
    //        newTodo.todoText = "This is first todo entry for my app. Just make to do app in which we can enter to do"
    //        println(managedObjectContext)
    //        println(newTodo.title)
    
    // Used option binding to confirm the managedObject
    if let moc = managedObjectContext {
      
      // DUmmy data for todo list
      var items = [
        ("Industry" , "Procution"),
        ("Medium" , "Video"),
        ("Tagert Audience" , "Cocnsumer+Small Bussinesses"),
        ("Targeted Geographic" , "India")
      ]
      for (todoTitle, todoText) in items {
        ToDoItem.createInManagedObjectContext(moc, title: todoTitle, text: todoText)
      }
      
      // Now the view is loaded, we have a frame for the view, which will be(0, 0, screen width, screen height)
      // This is good size s per given in article for table view
      // We only move frame by 20 pixel and reduce height by 20 pixel
      // In order to account the status bar
      
      // Store the full frame in temporary variable
      var viewFrame = self.view.frame
      
      // Adjust it down by 20 points
      viewFrame.origin.y += 20
      
      // decrease height by 30 points
      viewFrame.size.height -= 30
      
      // Set the todoTableView to our teomporary frame
      todoTableView.frame = viewFrame
      
      // Add the table view to the ViewController
      self.view.addSubview(todoTableView)
      
      // This tells table view that we are gonna use cells, call that cell ToDoCell
      todoTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "ToDoCell")
      
      // This tell todo table view that it should get it's data from this class i.e ViewController
      todoTableView.dataSource = self
      todoTableView.delegate = self
      
    }
    fetchLog()
  }
  
  func fetchLog() {
    
    
    let fetchRequest = NSFetchRequest(entityName: "ToDoItem")
    
    // Sort the list in asceding from title column
    let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
    
    // Set the list of sort descriptors in the fecth request
    // so it includes the sort descriptor
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [ToDoItem]{
      todoItems = fetchResults
    }
    
  }
  
  // Method returns numbers of rows in to do items list
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
  
  // Mehthod which let user on clicking on any row or todo let you perform task or in short give you callback for action
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let todoItem = todoItems[indexPath.row]
    
    println(todoItem.title)
  }
  
  // Method which enables the table view rows/cells edit and delete functionalities
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  // Method to invoke edit and delete the table view rows/cells
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    //Check if editing style is invoked for delete
    if (editingStyle == .Delete){
      //Get which todo object user trying to delete
      let todoItemToDelete = todoItems[indexPath.row]
      
      //Delete it from the managedObject
      managedObjectContext?.deleteObject(todoItemToDelete)
      
      //Refresh the table view to indicate that the item is deleted
      self.fetchLog()
      
      //Tell the table view to animate out the row which is invoked to delete
      todoTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

