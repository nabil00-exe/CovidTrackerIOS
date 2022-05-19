//
//  ReclamationViewModel.swift
//  CovidTracker
//
//  Created by Apple Esprit on 16/4/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

public class ReclamationViewModel : ObservableObject {
    static let sharedInstance = ReclamationViewModel()
    
    func createReclamation(reclamation: Reclamation!, completed: @escaping (Bool) -> Void) {
        AF.request(RECLAMATION_URL + "create",
                   method: .post,
                   parameters: [
                    "dateTest": reclamation.dateTest!,
                    "dateReclamation": reclamation.dateReclamation!,
                    "user": UserDefaults.standard.string(forKey: "userID")!
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Reclamation passed!")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
}
