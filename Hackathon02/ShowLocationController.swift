//
//  ShowLocationController.swift
//  Hackathon02
//
//  Created by Charlotte Abrams on 9/16/16.
//  Copyright © 2016 Evan Callia. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ShowLocationController: UITableViewController, CancelButtonDelegate, AddNoteViewControllerDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var cancelButtonDelegate: CancelButtonDelegate?
    var notes = [Note]()
    var location: Location?
    
    
    func save() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                print ("\(error)")
            }
        }
    }
    
    func addNoteViewController(controller: AddNoteViewController, didFinishAddingNote item: String, note: String) {
        dismissViewControllerAnimated(true, completion: nil)
        let newRowIndex = location?.notes?.count
        let entity = NSEntityDescription.entityForName("Note", inManagedObjectContext: managedObjectContext)
        let newNote = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Note
        newNote.item = item
        newNote.note = note
        var noteList = location!.notes?.mutableCopy() as! NSMutableOrderedSet
        noteList.addObject(newNote)
        location!.notes = noteList.copy() as! NSOrderedSet
        do {
            try managedObjectContext.save()
        } catch {
            print ("\(error)")
        }
        let indexPath = NSIndexPath(forRow: newRowIndex!, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    func cancelButtonPressedFrom(controller: UIViewController){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let controller = navigationController.topViewController as! AddNoteViewController
        controller.cancelButtonDelegate = self
        controller.delegate = self
    }
    
//TO EDIT NOTE (IN THE FUTURE)
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let note = notes[indexPath.row]
//        performSegueWithIdentifier("addNote", sender: note)
//    }
    
    
//    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
//        performSegueWithIdentifier("showLocation", sender: tableView.cellForRowAtIndexPath(indexPath))
//    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        managedObjectContext.deleteObject(location!.notes![indexPath.row] as! NSManagedObject)
        save()
//        fetchLocations()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (location?.notes?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell")! as! LocationCell
        cell.itemText.text = "Item: "+(location!.notes![indexPath.row] as! Note).item!
        cell.noteText.text = "Note: "+(location!.notes![indexPath.row] as! Note).note!
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchNotes()
    }

}
