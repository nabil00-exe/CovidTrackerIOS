//
//  User.swift
//  CovidTracker
//
//  Created by Apple Esprit on 15/4/2022.
//

import Foundation

struct User {
    
    internal init(id: String? = nil, email: String? = nil, password : String? = nil, name : String? = nil, passqr : String? = nil) {
        self.id = id
        self.email = email
        self.password = password
        self.name = name
        self.passqr = passqr
    }
    
    var id : String?
    var email : String?
    var password : String?
    var name : String?
    var passqr : String?
}
