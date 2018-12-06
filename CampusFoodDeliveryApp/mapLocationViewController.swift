//
//  mapLocationViewController.swift
//  CampusFoodDeliveryApp
//
//  Created by Alex Stanford on 12/2/18.
//  Copyright © 2018 Alex Stanford. All rights reserved.
//

import UIKit
import MapKit

class mapLocationViewController: UIViewController{
    
    @IBOutlet weak var mapOfCampus: MKMapView!
    var locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    
    var priceToPass : Double = 0.00
    var locationNamePass : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationConfig()
        addAnnotations()
        self.locationManager.requestWhenInUseAuthorization()
        
        print("This price was passed to map: \(priceToPass)")
        /*if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            addAnnotations()
       
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func locationConfig(){
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        
        if(status == .notDetermined){
            locationManager.requestWhenInUseAuthorization()
        }else if status == .authorizedAlways || status == .authorizedWhenInUse{
            mapOfCampus.showsUserLocation = true
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    private func zoomLocation(with coordinate: CLLocationCoordinate2D){
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800)
        mapOfCampus.setRegion(region, animated: true)
    }
    
    //var mapCenter = CLLocation(latitude: 38.200330, longitude: -84.856660)
    //SCHOOL CENTER: 38.200330,-84.856660
    //CHANDLER: 38.200915,-84.856510
    //NEW YOUNG: 38.200225,-84.854501
    //KENTUCKY HALL: 38.201259,-84.857122
    //McCULLEN: 38.202386, -84.85777
    
    private func addAnnotations(){
        let chandlerHallAnnotation = MKPointAnnotation()
        chandlerHallAnnotation.title = "Chandler Hall"
        chandlerHallAnnotation.coordinate = CLLocationCoordinate2D(latitude: 38.200915, longitude: -84.856660)
        
        let newYoungAnnotation = MKPointAnnotation()
        newYoungAnnotation.title = "New Young"
        newYoungAnnotation.coordinate = CLLocationCoordinate2D(latitude: 38.200225, longitude: -84.854501)
        
        let kentuckyAnnotation = MKPointAnnotation()
        newYoungAnnotation.title = "Kentucky Hall"
        newYoungAnnotation.coordinate = CLLocationCoordinate2D(latitude: 38.201259, longitude: -84.857122)
        
        let mccullenAnnotation = MKPointAnnotation()
        newYoungAnnotation.title = "McCullen Hall"
        newYoungAnnotation.coordinate = CLLocationCoordinate2D(latitude: 38.202386, longitude: -84.85777)
        
        mapOfCampus.addAnnotation(chandlerHallAnnotation)
        mapOfCampus.addAnnotation(newYoungAnnotation)
        mapOfCampus.addAnnotation(kentuckyAnnotation)
        mapOfCampus.addAnnotation(mccullenAnnotation)
    }
    
    private func selectLocation(){
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let finalView = segue.destination as! finalizeOrderViewController
        if(segue.identifier == "finalizeOrderSegue"){
            finalView.finalPrice = priceToPass
            finalView.locationName = locationNamePass
        }
    }
 


}





extension mapLocationViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latest = locations.first else { return }
        
        //if(currentLocation == nil){
            zoomLocation(with: latest.coordinate)
        //}
        
        currentLocation = latest.coordinate
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            mapOfCampus.showsUserLocation = true
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
}


extension mapLocationViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("annotation selected!")
        locationNamePass = ((view.annotation?.title)!)!
        performSegue(withIdentifier: "finalizeOrderSegue", sender: Any.self)
    }
    
}
