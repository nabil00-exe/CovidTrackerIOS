//
//  CheckinViewController.swift
//  CovidTracker
//
//  Created by Mac-Mini_2021 on 14/04/2022.
//

import UIKit
import AVFoundation

class CheckinViewController: UIViewController, UINavigationControllerDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkinCapture" {
            let destination = segue.destination as! QRcheckinViewController
        }
    }
    @IBAction func scanButton(_ sender: Any) {
        self.performSegue(withIdentifier: "checkinCapture", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
