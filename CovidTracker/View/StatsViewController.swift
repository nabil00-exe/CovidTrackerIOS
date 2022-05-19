//
//  StatsViewController.swift
//  CovidTracker
//
//  Created by Mac-Mini_2021 on 14/04/2022.
//

import UIKit
import WebKit

class StatsViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var statmap: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "https://app.developer.here.com/coronavirus/"
        let urlRequest = URLRequest(url: URL(string: url)!)
        statmap.load(urlRequest)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
