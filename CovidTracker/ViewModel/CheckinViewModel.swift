//
//  CheckinViewModel.swift
//  CovidTracker
//
//  Created by Apple Esprit on 16/4/2022.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

public class CheckinViewModel : ObservableObject {
    static let sharedInstance = CheckinViewModel()
    var userViewModel = UserViewModel()
    var locationViewModel = LocationViewModel()
    
    func createCheckin(checkin: Checkin!, completed: @escaping (Bool) -> Void) {
       
        AF.request(CHECKIN_URL + "create",
                   method: .post,
                   parameters: [
                    "checkin": checkin.checkin!,
                    "checkout": checkin.checkout!,
                    "location": checkin.location!,
                    "user": UserDefaults.standard.string(forKey: "userID")!
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("checkin succeed!")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    func retrieveCheckinByOwner(idOwner: String?, completed: @escaping (Bool, [Checkin]?) -> Void) {
        
        let url = CHECKIN_URL + "owner/" + idOwner!
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData {
                
                response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var checkins : [Checkin]? = []
                    for checkin in jsonData {
                        checkins!.append(self.makeCheckin(jsonItem: checkin.1))
                    }
                    completed(true,checkins!)
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                }
            }
        
            
    }
    
    
    func makeUser(jsonItem: JSON) -> User {
        return User(
            id: jsonItem["id"].stringValue,
            email: jsonItem["email"].stringValue,
            password: jsonItem["password"].stringValue,
            name: jsonItem["name"].stringValue,
            passqr: jsonItem["passqr"].stringValue
            
        )
    }
    func makeCheckin(jsonItem: JSON) -> Checkin {
        Checkin(
            _id: jsonItem["_id"].stringValue,
            checkin: jsonItem["checkin"].stringValue,
            checkout: jsonItem["checkout"].stringValue,
            location: jsonItem["location"].stringValue,
            user: UserViewModel.sharedInstance.makeItem(jsonItem: jsonItem["user"])
        )
    }
    
    func makeLocation(jsonItem: JSON) -> Location {
        Location(
            id: jsonItem["id"].stringValue,
            name: jsonItem["name"].stringValue,
            categorie: jsonItem["categorie"].stringValue,
            capacity: jsonItem["capacity"].intValue,
            owner: UserViewModel.sharedInstance.makeItem(jsonItem: jsonItem["user"]),
            latitude: jsonItem["latitude"].doubleValue,
            longitude: jsonItem["longitude"].doubleValue
        )
    }
    
}
