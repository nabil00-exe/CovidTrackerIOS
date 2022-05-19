//
//  MyLocationsViewController.swift
//  CovidTracker
//
//  Created by Mac-Mini-2021 on 18/05/2022.
//

import UIKit
import Foundation
import MapKit
import CoreLocation
class MyLocationsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MKMapViewDelegate {
    
    // Widgets
    @IBOutlet weak var locationCollection: UICollectionView!
    @IBOutlet weak var mapViewLoc: MKMapView!
    @IBOutlet weak var addLoc: UIBarButtonItem!
    
    // Variables
    var locations : [Location] = []
    var owner: User?
    var location : Location?
    var userViewModel = UserViewModel()
    var annotation = MKPointAnnotation()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let contentView = cell.contentView
        let labelName = contentView.viewWithTag(1) as! UILabel
        let labelCategorie = contentView.viewWithTag(2) as! UILabel
        let labelCap = contentView.viewWithTag(3) as! UILabel
        //cell.layer.cornerRadius = 40.0
        var location = locations[indexPath.row]
            labelName.text = location.name
            labelCategorie.text = location.categorie
            labelCap.text = String(location.capacity ?? 2)
            
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.location = locations[indexPath.row]
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: locations[indexPath.row].latitude!, longitude: locations[indexPath.row].longitude!)
        annotation.title = self.location?.name
        annotation.subtitle = self.location?.categorie
        self.mapViewLoc.addAnnotation(annotation)
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()

        mapViewLoc.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        retrieveLocByOwner()
    }
    
    @IBAction func addLoc(_ sender: Any) {
        self.performSegue(withIdentifier: "openmap", sender: nil)
    }
    
    func retrieveLocByOwner() {
        userViewModel.getUserByToken(userToken: UserDefaults.standard.string(forKey: "token")!) { [self] success, result in
            if success {
               
                LocationViewModel().retrieveLocByOwner(idOwner: result!.id) {
                    success, locationList in
                    if success {
                        
                        self.locations = locationList!
                        self.locationCollection.reloadData()
                    } else {
                        print("error retrieving locations")
                    }
                }
                
            }
    }

    }

}
