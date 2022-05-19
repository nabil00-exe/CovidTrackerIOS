//
//  ReclamationViewController.swift
//  CovidTracker
//
//  Created by Mac-Mini_2021 on 14/04/2022.
//

import UIKit

class ReclamationViewController: UIViewController, UINavigationControllerDelegate {

    //var
    var reclamation = Reclamation()
    var reclamationViewModel = ReclamationViewModel()
    
    //widget
    @IBOutlet weak var dateTestTV: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmReclamation(_ sender: Any) {
        reclamation.dateTest = dateTestTV.date
        reclamation.dateReclamation = Date()
        reclamationViewModel.createReclamation(reclamation: reclamation, completed: {
            (success) in
            if success {
                let alert = UIAlertController(title: "Success", message: "Reclamation passed successfully", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        })
    }
    
    

}
