//
//  LocationMapViewController.swift
//  CovidTracker
//
//  Created by Mac-Mini-2021 on 26/4/2022.
//

import UIKit
import MapKit
class LocationMapViewController: UIViewController, MKMapViewDelegate {

    //widgets
    @IBOutlet weak var mapView: MKMapView!
    
    //var
    
    var location = Location()
    var locationViewModel = LocationViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
    }
    

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let newLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationNext" {
            let destination = segue.destination as! LocationNextViewController
            destination.location = location
        }
    }
    
    @IBAction func pickLoc(_ sender: UIButton) {
        location.latitude = mapView.centerCoordinate.latitude
        location.longitude = mapView.centerCoordinate.longitude
        performSegue(withIdentifier: "locationNext", sender: location)
        
    }
    
    
}
