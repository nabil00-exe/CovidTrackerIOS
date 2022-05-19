//
//  ProfileViewController.swift
//  CovidTracker
//
//  Created by Mac-Mini_2021 on 12/04/2022.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController,UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource{
    
    

    //variables
    var userViewModel = UserViewModel()
    var checkinViewModel = CheckinViewModel()
    var owner : User?
    var checkin : Checkin?
    var checkins : [Checkin] = []
    
    //Widgets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var QR_code: UIImageView!
    
    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var myLocationsbtn: UIButton!
    @IBOutlet weak var checkinCollection: UITableView!
    
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checkins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkinCell")
        let contentView = cell?.contentView
        let labelNameLoc = contentView?.viewWithTag(1) as! UILabel
        let checkinDate = contentView?.viewWithTag(2) as! UILabel
        let checkoutDate = contentView?.viewWithTag(3) as! UILabel
        
        var checkin = checkins[indexPath.row]
        checkinDate.text = checkin.checkin!
        checkoutDate.text = checkin.checkout!
        LocationViewModel().retrieveLocById(idLoc: checkin.location!){ [self] success, result in
            if success {
                labelNameLoc.text = result?.name!
                
                }
            }
        return cell!
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logOut.tintColor = UIColor.white
        myLocationsbtn.tintColor = UIColor.white
        userViewModel.getUserByToken(userToken: UserDefaults.standard.string(forKey: "token")!) { [self] success, result in
            if success {
                let user = result
                nameLabel.text = (result?.name)!
                emailLabel.text = (result?.email)!
                QR_code.image = generateQRCode(from: (user?.passqr)!)
                
            }
        }
        retrieveCheckinByOwner()

        // Do any additional setup after loading the view.
    }
    

    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let QRFilter = CIFilter(name: "CIQRCodeGenerator") {
            QRFilter.setValue(data, forKey: "inputMessage")
            guard let QRImage = QRFilter.outputImage else {
                return nil
            }
            return UIImage(ciImage: QRImage)
        }
        return nil
    }
    func retrieveCheckinByOwner() {
        userViewModel.getUserByToken(userToken: UserDefaults.standard.string(forKey: "token")!) { [self] success, result in
            if success {
               
                CheckinViewModel().retrieveCheckinByOwner(idOwner: result!.id) {
                    success, checkinList in
                    if success {
                        
                        self.checkins = checkinList!
                        self.checkinCollection.reloadData()
                    } else {
                        print("error retrieving locations")
                    }
                }
                
            }
    }
            
        
    }
    
    @IBAction func myLocationsbtn(_ sender: Any) {
        performSegue(withIdentifier: "myLocations", sender: nil)
    }
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "token")
        performSegue(withIdentifier: "logout", sender: nil)
    }
    
}
