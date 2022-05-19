//
//  LocationViewController.swift
//  CovidTracker
//
//  Created by Mac-Mini_2021 on 14/04/2022.
//

import UIKit
import Foundation

class LocationViewController: UIViewController , UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var locationTable: UITableView!
    
    //var
    var locations : [Location] = []
    var owner: User?
    var location : Location?
    var userViewModel = UserViewModel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")
        
        let contentView = cell?.contentView
        
        let labelName = contentView?.viewWithTag(1) as! UILabel
        let labelCategorie = contentView?.viewWithTag(2) as! UILabel
        let labelCap = contentView?.viewWithTag(3) as! UILabel
        
        var location = locations[indexPath.row]
            labelName.text = location.name
            labelCategorie.text = location.categorie
            labelCap.text = String(location.capacity ?? 2)
            
        
        
        return cell!
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            LocationViewModel().supprimerLoc(idLoc: locations[indexPath.row].id) {
                success in
                if success {
                    print("location deleted")
                    self.locations.remove(at: indexPath.row)
                    self.locationTable.deleteRows(at: [indexPath], with: .fade)
                    self.locationTable.reloadData()
                } else {
                    print("error while deleting location")
                }
            }
            
            
        } 
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableCell" {
            let destination = segue.destination as! LocationCellViewController
            
            destination.location = self.location!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.location = locations[indexPath.row]
        self.performSegue(withIdentifier: "tableCell", sender: location)
     
    }

    
    @IBAction func addLocation(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        retrieveLocByOwner()
        
    }
    
    
    func retrieveLocByOwner() {
                LocationViewModel().retrieveAllLoc() {
                    success, locationList in
                    if success {
                        
                        self.locations = locationList!
                        self.locationTable.reloadData()
                    } else {
                        print("error retrieving locations")
                    }
                }
                
            
    }

    }

