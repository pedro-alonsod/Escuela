//
//  SatsCamionViewController.swift
//  Escuela
//
//  Created by Nora Hilda De los Reyes on 01/04/16.
//  Copyright © 2016 Pedro. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class SatsCamionViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

    var timer: NSTimer = NSTimer()
    var locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var stasCamionMapView: MKMapView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let regionRadius: CLLocationDistance = 1000
    
    var locationOfParent: CLLocation!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        stasCamionMapView.delegate = self
        //---//
        //let spanX = 0.001
        //let spanY = 0.001
        
        // Create a region using the user's location, and the zoo.
        //var newRegion = MKCoordinateRegion(center: mapForRoute.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        
        // set the map to the new region
        //mapForRoute.setRegion(newRegion, animated: false)
        
        //stasCamionMapView.showsUserLocation = true
        
        stasCamionMapView.showsBuildings = true
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "action:")
        longPress.minimumPressDuration = 1.0
        
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        
        centerMapOnLocation(locationOfParent)
        print(" the location of the parent is \(locationOfParent)")
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //
    
    func printTimestamp() -> String {
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        print(timestamp)
        
        return timestamp
        
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        var touchPoint = gestureRecognizer.locationInView(self.stasCamionMapView)
        var newCoord:CLLocationCoordinate2D = stasCamionMapView.convertPoint(touchPoint, toCoordinateFromView: self.stasCamionMapView)
        
        var newAnotation = MKPointAnnotation()
        newAnotation.coordinate = newCoord
        newAnotation.title = "New Location"
        newAnotation.subtitle = "New Subtitle"
        stasCamionMapView.addAnnotation(newAnotation)
        
    }
    
    @IBAction func botonTapped(sender: UIButton) {
        
    }
    
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        stasCamionMapView.showsUserLocation = (status == .AuthorizedAlways)
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        locationOfParent = manager.location!
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        stasCamionMapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func salirTapped(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        print("saliendo")
    }

}
