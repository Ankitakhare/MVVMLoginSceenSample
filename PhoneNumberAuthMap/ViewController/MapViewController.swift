//
//  AccountViewController.swift
//  PhoneNumberAuthMap
//
//  Created by ankita khare on 03/03/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
     
        var locationManager:CLLocationManager!
        var mapView:MKMapView!
        private let logoutBtn: UIButton = {
        let button = UIButton()
        button.setTitle( "Logout", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.frame = CGRect(x: 100, y: 200, width: 300, height: 0)
       return button
    }()

    
    
   


    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            createMapView()
            //determineCurrentLocation()
             openMapForPlace()
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
  /*  override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // Create and Add MapView to our main view
            createMapView()
            
        }
        
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            determineCurrentLocation()
        }*/

        func createMapView()
        {
            mapView = MKMapView()
            
            let leftMargin:CGFloat = 10
            let topMargin:CGFloat = 200
            let mapWidth:CGFloat = view.frame.size.width-20
            let mapHeight:CGFloat = view.frame.size.height
            mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
            
            
            mapView.mapType = MKMapType.standard
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true
            
            // Or, if needed, we can position map in the center of the view
            mapView.center = view.center
            
            view.addSubview(mapView)
            logoutBtn.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
           mapView.addSubview(logoutBtn)
            
            
        }
       @objc func buttonClicked() {
        self.navigationController?.popToRootViewController(animated: true)
        print("Button Clicked")
       }
        
      /*  func determineCurrentLocation()
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            
            if CLLocationManager.locationServicesEnabled() {
                //locationManager.startUpdatingHeading()
                locationManager.startUpdatingLocation()
            }
        }*/
        
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let userLocation:CLLocation = locations[0] as CLLocation
            
            // Call stopUpdatingLocation() to stop listening for location updates,
            // other wise this function will be called every time when user location changes.
            manager.stopUpdatingLocation()
            
            let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            mapView.setRegion(region, animated: true)
            
            // Drop a pin at user's Current Location
            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
            myAnnotation.title = "Current location"
            mapView.addAnnotation(myAnnotation)
      
        }
    func openMapForPlace() {
            
            let latitude: CLLocationDegrees = 30.9
            let longitude: CLLocationDegrees = 75.8
            
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Ludhiana"
            mapItem.openInMaps(launchOptions: options)
        }
    
    
    
    
        func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
        {
            print("Error \(error)")
        }
     
    }
