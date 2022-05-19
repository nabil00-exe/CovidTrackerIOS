//
//  checkinConfirmationViewController.swift
//  CovidTracker
//
//  Created by Apple Esprit on 6/5/2022.
//

import UIKit
import Foundation
class checkinConfirmationViewController: UIViewController {

    var checkin = Checkin()
    var checkinViewModel = CheckinViewModel()
    var location = Location()
    var locationViewModel = LocationViewModel()
    var i = 0
    
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var togglebtn: UIButton!
    
    
    @IBAction func confirmCheckin(_ sender: Any) {
        
                if (i == 0){
                    let currentDate = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "YYYY-MM-dd, HH:mm:ss"
                    checkin.checkin = dateFormatter.string(from: currentDate)
                    print("-------------checkin time--------------")
                    print(checkin.checkin)
                    togglebtn.setTitle("Confirm check out", for: .normal)
                    i=1
                } else {
                    let currentDate2 = Date()
                    let dateFormatter2 = DateFormatter()
                    dateFormatter2.dateFormat = "YYYY-MM-dd, HH:mm:ss"
                    checkin.checkout = dateFormatter2.string(from: currentDate2)
                    print("-------------checkout time--------------")
                    print(checkin.checkout)
                    checkinViewModel.createCheckin(checkin: checkin, completed: {
                        (success) in
                        if success {
                            let place = self.checkin.location
                            let alert = UIAlertController(title: "Success", message: "you have checked out from"+place!, preferredStyle: .alert)
                            self.present(alert, animated: true)
                        }
                    })
                    self.performSegue(withIdentifier: "back", sender: nil)
                }

    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationViewModel.retrieveLocById(idLoc: checkin.location!){ [self] success, result in
            if success {
                print("-----------checkin to location---------------")
                print(result)
                print("--------------------------------")
                labelName.text = result?.name!
                
                }
            }
                
                
            
        // Do any additional setup after loading the view.
    }
}
