//
//  MapViewController.swift
//  MVVMLoginSceenSample
//
//  Created by ankita khare on 28/02/22.
//



import UIKit
import CoreLocation
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
 
    var locationManager:CLLocationManager!
    var mapView:MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create and Add MapView to our main view
        createMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        determineCurrentLocation()
    }
    func createMapView()
    {
        mapView = MKMapView()
        
        let leftMargin:CGFloat = 10
        let topMargin:CGFloat = 60
        let mapWidth:CGFloat = view.frame.size.width-20
        let mapHeight:CGFloat = view.frame.size.height
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        // Or, if needed, we can position map in the center of the view
        mapView.center = view.center
        
        view.addSubview(mapView)
    }
    
    func determineCurrentLocation()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        //manager.stopUpdatingLocation()
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error \(error)")
    }
 
}

