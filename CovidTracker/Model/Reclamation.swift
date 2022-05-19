//
//  Reclamation.swift
//  CovidTracker
//
//  Created by Apple Esprit on 15/4/2022.
//

import Foundation

struct Reclamation {
    
    internal init(_id: String? = nil, dateTest : Date? = nil, dateReclamation : Date? = nil, user : User? = nil) {
        self._id = _id
        self.dateTest = dateTest
        self.dateReclamation = dateReclamation
        self.user = user
    }
    
    var _id : String?
    var dateTest : Date?
    var dateReclamation : Date?
    var user : User?

}
