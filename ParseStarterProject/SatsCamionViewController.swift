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

    var locationsInRoute: [CLLocation] = []
    
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
        
        stasCamionMapView.mapType = MKMapType.Hybrid
        
        

    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        let latitudeOfParent = locationOfParent.coordinate.latitude
        let longitudeOfParent = locationOfParent.coordinate.longitude
        
        var point1 = MKPointAnnotation()
        var point2 = MKPointAnnotation()
        
        point1.coordinate = CLLocationCoordinate2DMake(latitudeOfParent, longitudeOfParent)
        point1.title = "Fin"
        point1.subtitle = "Del recoridor"
        stasCamionMapView.addAnnotation(point1)
        
        point2.coordinate = CLLocationCoordinate2DMake(25.652059, -100.289477)
        point2.title = "Inicio"
        point2.subtitle = "Camion escolar"
        stasCamionMapView.addAnnotation(point2)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        
        centerMapOnLocation(locationOfParent)
        print(" the location of the parent is \(locationOfParent)")
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.greenColor()
            
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }

        return MKOverlayRenderer()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        //let viewForDot = MKAnnotationView()
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        
        
        if annotation.isKindOfClass(MKUserLocation) {
            
            //pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            pinView?.canShowCallout = true
            
            //pinView?.backgroundColor = UIColor.greenColor()
            
            pinView?.image = UIImage(named: "Camion.png")
            
        }
        
        
        //pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        //pinView!.canShowCallout = true
        //pinView!.animatesDrop = true
        //pinView!.image = UIImage(named: "checkIcon.png")
        
        //return viewForDot
        
        return pinView
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
        
        locationsInRoute.append(locations[0] )

        
        if locationsInRoute.count > 1 {
            
            
            let c1 = locationOfParent.coordinate
            //let c2 = locationsInRoute[destinationIndex].coordinate
            let c2 = CLLocationCoordinate2DMake(25.652059, -100.289477)
            var a = [c1, c2]
            
            let polyline = MKPolyline(coordinates: &a, count: a.count)
            
            //polyline.strokeColor = UIColor.greenColor()
            
            
            stasCamionMapView.addOverlay(polyline)
            
            print("count of locations \(locationsInRoute.count)")
            
        }
        
    }
    
    func mapView(mapView: MKMapView, viewForOverlay overlay: MKOverlay) -> MKOverlayView {
        
        let overlayMap = MKOverlayView()
        
        return overlayMap
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        stasCamionMapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func salirTapped(sender: UIBarButtonItem) {
        
        self.locationManager.stopUpdatingLocation()
        self.locationManager.stopUpdatingHeading()
        self.dismissViewControllerAnimated(true, completion: nil)
        print("saliendo")
    }

}
