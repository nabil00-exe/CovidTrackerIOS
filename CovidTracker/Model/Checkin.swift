//
//  Checkin.swift
//  CovidTracker
//
//  Created by Apple Esprit on 15/4/2022.
//

import Foundation

struct Checkin {
    internal init(_id : String? = nil, checkin : String? = nil, checkout : String? = nil, location : String? = nil, user : User? = nil) {
        self._id = _id
        self.checkin = checkin
        self.checkout = checkout
        self.location = location
        self.user = user
    }
    var _id : String?
    var checkin : String?
    var checkout : String?
    var location : String?
    var user : User?
}
