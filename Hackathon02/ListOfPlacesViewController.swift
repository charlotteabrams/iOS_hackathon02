//
//  ViewController.swift
//  Hackathon02
//
//  Created by Evan Callia on 9/16/16.
//  Copyright © 2016 Evan Callia. All rights reserved.
//

import UIKit
import CoreData

class ListOfPlacesViewController: UITableViewController, MapViewControllerDelegate, CancelButtonDelegate {
    
    var locations = [Location]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLocations()
    }
    
    func mapViewController(controller: UIViewController, didPressAddButton location: Location) {
        self.navigationController?.popToViewController(self, animated: true)
        save()
        fetchLocations()
        tableView.reloadData()
    }
    
    func fetchLocations() {
        let userRequest = NSFetchRequest(entityName: "Location")
        do {
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            locations = results as! [Location]
        } catch {
            print ("\(error)")
        }
    }
    
    func save() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                print ("\(error)")
            }
        }
    }
    
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let location = locations[indexPath.row]
        performSegueWithIdentifier("showLocation", sender: location)
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showLocation", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap" {
            let controller = segue.destinationViewController as! MapViewController
            controller.delegate = self
        } else if segue.identifier == "showLocation" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ShowLocationController
            controller.location = sender as! Location
            controller.cancelButtonDelegate = self
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        managedObjectContext.deleteObject(locations[indexPath.row])
        save()
        fetchLocations()
        tableView.reloadData()
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell")!
        cell.textLabel?.text = locations[indexPath.row].name
        return cell
    }
}

