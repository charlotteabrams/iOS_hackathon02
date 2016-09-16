//
//  MapViewController.swift
//  Hackathon02
//
//  Created by Evan Callia on 9/16/16.
//  Copyright © 2016 Evan Callia. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import CoreData


class MapViewController: UIViewController,  MKMapViewDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var delegate: MapViewControllerDelegate?
    var longitude = Double()
    var latitude = Double()
    var name = String()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var map: MKMapView!
    
    
    @IBAction func searchButtonPressed(sender: UIButton) {
        map.removeAnnotations(map.annotations)
        search()
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        longitude = (view.annotation?.coordinate.longitude)!
        latitude = (view.annotation?.coordinate.latitude)!
        name = ((view.annotation?.title)!)!
    }
    
    @IBAction func saveLocationButtonPressed(sender: UIButton) {
        let newLocation = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: managedObjectContext) as! Location
        newLocation.longitude = longitude
        newLocation.latitude = latitude
        newLocation.name = name
        delegate?.mapViewController(self, didPressAddButton: newLocation)
    }
    
    func search(){
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = userInput.text
        request.region = map.region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler({
            response, error in
            if error != nil {
                print(error)
            }else if let mapItems = response?.mapItems{
                for item in mapItems{
                    self.placeItemOnMap(item)
                }
            }
        })
    }
    
    func placeItemOnMap(item: MKMapItem){
        let annotation = MKPointAnnotation()
        annotation.coordinate = item.placemark.coordinate
        annotation.title = item.name
        annotation.subtitle = item.phoneNumber
        map.addAnnotation(annotation)
    }
    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
////        view.image = cafeImage
////        view.canShowCallout = true
//        return view
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        self.map.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        let location = self.locationManager.location
        let locationa = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.5, 0.5)
        
        let region = MKCoordinateRegion (center:  locationa,span: span)
        
        map.setRegion(region, animated: true)
//        var myLatitude: Double = (location?.coordinate.latitude)!
//        var myLongitude: Double = (location?.coordinate.longitude)!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}