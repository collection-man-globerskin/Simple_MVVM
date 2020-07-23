//
//  User.swift
//  ViewModelBindableEntities
//
//  Created by Julian Llorensi on 23/07/2020.
//  Copyright © 2020 Julian Llorensi. All rights reserved.
//

import Foundation

enum Gender: Int {
    case male = 0
    case female = 1
    case other = 2
}

struct User {
    var name: String
    var mobileNumber: String
    var email: String
    var age: UInt8
    var gender: Gender
}
