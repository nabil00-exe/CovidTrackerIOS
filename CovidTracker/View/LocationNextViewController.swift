//
//  LocationNextViewController.swift
//  CovidTracker
//
//  Created by Mac-Mini-2021 on 26/4/2022.
//

import UIKit
import GMStepper

class LocationNextViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var location: Location!
    let pickerData = ["Coffee shop","Resto","Shop", "School"]
    
    func numberOfComponents(in categorieInput: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ categorieInput: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ categorieInput: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    
    //widgets
    @IBOutlet weak var locNameTV: UITextField!
    @IBOutlet weak var categorieInput: UIPickerView!
    @IBOutlet weak var capacityStepper: GMStepper!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locNameTV.showDoneButtonOnKeyboard()
        categorieInput.setValue(UIColor.white, forKeyPath: "textColor")
        categorieInput.delegate = self
        categorieInput.dataSource = self
        
    }
    
    @IBAction func createLoc(_ sender: Any) {
        location!.name = locNameTV.text
        location!.categorie = pickerData[categorieInput.selectedRow(inComponent: 0)]
        location!.capacity = Int(capacityStepper.value)
        print(location)
        LocationViewModel().createLocation(location: location!, completed: { (success) in
            if success {
                let alert = UIAlertController(title: "Success", message: "Your property's location is added successfully!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                    self.performSegue(withIdentifier: "back", sender: nil)
                }
                alert.addAction(action)
                self.present(alert, animated: true)
            } else {
               print("error saving location")
                return
            }
        })
    }
    

}

