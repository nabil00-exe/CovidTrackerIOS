//
//  LocationViewModel.swift
//  CovidTracker
//
//  Created by Apple Esprit on 16/4/2022.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit

public class LocationViewModel : ObservableObject {
    
    static let sharedInstance = LocationViewModel()
    var userViewModel = UserViewModel()
    
    
    func createLocation(location: Location!, completed: @escaping (Bool) -> Void) {
        print(UserDefaults.standard.string(forKey: "token")!)
        AF.request(LOCATION_URL + "create",
                   method: .post,
                   parameters: [
                    "name": location.name!,
                    "categorie": location.categorie!,
                    "capacity": location.capacity!,
                    "owner": UserDefaults.standard.string(forKey: "userID")!,
                    "latitude": location.latitude!,
                    "longitude": location.longitude!,
                    
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Location captured!")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    func retrieveAllLoc(  completed: @escaping (Bool, [Location]?) -> Void ) {
           AF.request(LOCATION_URL,
                      method: .get)
               .validate(statusCode: 200..<300)
               .validate(contentType: ["application/json"])
               .responseData { response in
                   switch response.result {
                   case .success:
                    let jsonData = JSON(response.data!)
                    var locations : [Location]? = []
                    for location in jsonData {
                        locations!.append(self.makeItem(jsonItem: location.1))
                    }
                    completed(true,locations!)
                   case let .failure(error):
                       debugPrint(error)
                       completed(false, nil)
                   }
               }
       }
    
    func retrieveLocByOwner(idOwner: String?, completed: @escaping (Bool, [Location]?) -> Void) {
        
        let url = LOCATION_URL + "owner/" + idOwner!
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData {
                
                response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var locations : [Location]? = []
                    for location in jsonData {
                        locations!.append(self.makeItem(jsonItem: location.1))
                    }
                    completed(true,locations!)
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                }
            }
        
            
    }
    func retrieveLocById(idLoc: String?, completed: @escaping (Bool, Location?) -> Void) {
        
        let url = LOCATION_URL + idLoc!
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData {
                
                response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var location : Location? = self.makeItem(jsonItem: jsonData)
                    completed(true,location!)
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                }
            }
    }
    
    func supprimerLoc(idLoc: String?, completed: @escaping (Bool) -> Void ) {
        let url = LOCATION_URL + idLoc!
        AF.request(url,
                   method: .delete,
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
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
    func makeItem(jsonItem: JSON) -> Location {
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
