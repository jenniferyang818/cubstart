//
//  MapViewController.swift
//  Junkies
//
//  Created by User on 10/22/20.
//  Copyright © 2020 Cubstart. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var Map: MKMapView!
    var closestLocationAddress = ""
    var locationManager = CLLocationManager()
    var userLoc = CLLocation()
    var closestLocation : CLLocation? = nil // new
    var minDistance : CLLocationDistance = 0.0 // new
    
    var locationName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locateMe()
    }
    func locateMe() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        Map.showsUserLocation = true
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLoc = locations[0]
        let myLocation = CLLocationCoordinate2D(latitude: userLoc.coordinate.latitude, longitude: userLoc.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: myLocation, span: span)
        Map.setRegion(region, animated: true)
        findNearest()
        
    }
    
    func findNearest() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "\(locationName)"
        request.region = Map.region
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response, error) in
            if error != nil {
                print("An error occurred")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for place in response!.mapItems {
                    print("\(place.name ?? "")")
                    print("\(place.phoneNumber ?? "")")
                    let placemark =  CLLocation(latitude: place.placemark.coordinate.latitude, longitude: place.placemark.coordinate.longitude)
                    if self.closestLocation == nil {
                        self.closestLocation = placemark
                        self.minDistance = placemark.distance(from: self.userLoc)
                        self.closestLocationAddress = place.placemark.subThoroughfare! + " " + place.placemark.thoroughfare! + " " + place.placemark.locality! + " " + place.placemark.administrativeArea!
                    }
                    else if self.minDistance > placemark.distance(from:self.userLoc) {
                        self.closestLocation = placemark
                        self.minDistance = placemark.distance(from: self.userLoc)
                        self.closestLocationAddress = place.placemark.subThoroughfare! + " " + place.placemark.thoroughfare! + " " + place.placemark.locality! + " " + place.placemark.administrativeArea!
                    }
                }
                self.addAnnotation()
                self.updateView()
            }
        })
    }
    func addAnnotation() {
        let annot = MKPointAnnotation()
        annot.coordinate = self.closestLocation!.coordinate
        annot.title = "\(locationName)"
        Map.addAnnotation(annot)
    }
    func updateView() {
        address.text = closestLocationAddress
        distance.text = "\(minDistance) meters"
    }
    
    @IBAction func openInMaps(_ sender: Any) {
        let coord = closestLocation!.coordinate
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coord))
        mapItem.name = "\(locationName)"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    

    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         //Get the new view controller using segue.destination.
//         //Pass the selected object to the new view controller.
//        let map = segue.destination as! MapViewController
//        map.locationName = locationName
//
//    }
//

}
