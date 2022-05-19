//
//  UserViewModel.swift
//  CovidTracker
//
//  Created by Apple Esprit on 16/4/2022.
//

import Alamofire
import SwiftyJSON
import UIKit

public class UserViewModel : ObservableObject {
    
    static let sharedInstance = UserViewModel()
    
    
    func authenticate(email: String, password: String, completed: @escaping (Bool, Any?) -> Void) {
        AF.request(USER_URL + "authenticate",
                   method: .post,
                   parameters: ["email": email, "password": password])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeItem(jsonItem: jsonData["user"])
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "token")
                    UserDefaults.standard.set(user.name!, forKey: "name")
                    UserDefaults.standard.set(user.id!, forKey: "userID")
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func register(user: User, completed: @escaping (Bool) -> Void) {
        AF.request(USER_URL + "register",
                   method: .post,
                   parameters: [
                    "email": user.email!,
                    "password": user.password!,
                    "name": user.name!,
                    "passqr": user.passqr!
                   ] ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Registration made with success!")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    func getUserByToken(userToken : String, completed: @escaping (Bool, User?) -> Void) {
        AF.request(USER_URL + "current",
                   method: .post,
                   parameters: ["token": userToken],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeItem(jsonItem: jsonData)
                    print(user)
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false,nil)
                }
            }
    }
    
    func makeItem(jsonItem: JSON) -> User {
        return User(
            id: jsonItem["id"].stringValue,
            email: jsonItem["email"].stringValue,
            password: jsonItem["hash"].stringValue,
            name: jsonItem["name"].stringValue,
            passqr: jsonItem["passqr"].stringValue
            
        )
    }
    
}
