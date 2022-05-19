//
//  CheckerViewController.swift
//  CovidTracker
//
//  Created by Apple Esprit on 19/4/2022.
//

import UIKit
import Alamofire

class CheckerViewController: UIViewController {

    var user : User?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        let token = UserDefaults.standard.string(forKey: "token")
        
        if token != nil {
            UserViewModel().getUserByToken(userToken: token!) {
                success, user in
                if success {
                    self.performSegue(withIdentifier: "connected", sender: nil)
                } else {
                    self.performSegue(withIdentifier: "notConnected", sender: nil)
                }
            }
        } else {
            print("token not found")
            self.performSegue(withIdentifier: "notConnected", sender: nil)
        }
    }
    

}
