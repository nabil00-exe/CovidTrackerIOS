//
//  LocationCellViewController.swift
//  CovidTracker
//
//  Created by Apple Esprit on 6/5/2022.
//

import UIKit
import MapKit
import CoreLocation
import Foundation

class LocationCellViewController: UIViewController {

    var location = Location()
    //widget
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cafeLabel: UILabel!
    @IBOutlet weak var capLabel: UILabel!
    @IBOutlet weak var qrImage: UIImageView!
    @IBOutlet weak var mapLoc: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = location.name
        self.cafeLabel.text = location.categorie
        self.capLabel.text = String(location.capacity ?? 0)
        self.qrImage.image = generateQRCode(from: (location.id)!)
        print(location)
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
        annotation1.title = location.name
        annotation1.subtitle = location.categorie
        self.mapLoc.addAnnotation(annotation1)
         
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

    

}
