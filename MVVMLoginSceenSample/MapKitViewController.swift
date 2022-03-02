//
//  MapKitViewController.swift
//  MVVMLoginSceenSample
//
//  Created by ankita khare on 28/02/22.
//
import UIKit
import MapKit
import CoreLocation

/*class MapKitViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //MARK:- Variable Declarations

    @IBOutlet weak var mMapView: MKMapView!
    var locationManager:CLLocationManager!
    var currentLocationStr = "Current location"

    //MARK:- ViewController LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        determineCurrentLocation()
    }

    //MARK:- CLLocationManagerDelegate Methods

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mUserLocation:CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mMapView.setRegion(mRegion, animated: true)

        // Get user's Current Location and Drop a pin
    let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
        mkAnnotation.coordinate = CLLocationCoordinate2DMake(mUserLocation.coordinate.latitude, mUserLocation.coordinate.longitude)
        mkAnnotation.title = self.setUsersClosestLocation(mLattitude: mUserLocation.coordinate.latitude, mLongitude: mUserLocation.coordinate.longitude)
        mMapView.addAnnotation(mkAnnotation)
    }
    /*
    let newPin = MKPointAnnotation()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     mMapView.removeAnnotation(newPin)

     let location = locations.last! as CLLocation

     let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
     let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

     //set region on the map
        mMapView.setRegion(region, animated: true)

     newPin.coordinate = location.coordinate
        mMapView.addAnnotation(newPin)

 }
    */
    
    
    
    
    
    
    
    //MARK:- Intance Methods

    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)

        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in

            if let mPlacemark = placemarks{
                if let dict = mPlacemark[0].addressDictionary as? [String: Any]{
                    if let Name = dict["Name"] as? String{
                        if let City = dict["City"] as? String{
                            self.currentLocationStr = Name + ", " + City
                        }
                    }
                }
            }
        }
        return currentLocationStr
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

      guard !(annotation is MKUserLocation) else {
               let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
               annotationView.image = UIImage(named:"icon.png")
               return annotationView
           }
   return nil
   }
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    
}
*/
import UIKit
import CoreLocation
import MapKit

class MapKitViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
 
    var locationManager:CLLocationManager!
    @IBOutlet weak var mMapView: MKMapView!
    
    var currentLocationStr = "Current location"

    
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        determineCurrentLocation()
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
        
        mMapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        myAnnotation.title = "Current location"
        mMapView.addAnnotation(myAnnotation)
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error \(error)")
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

      guard !(annotation is MKUserLocation) else {
               let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
               annotationView.image = UIImage(named:"icon.png")
               return annotationView
           }
   return nil
   }
 
}
