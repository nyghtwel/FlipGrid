//
//  User.swift
//  FlipgridInterview
//
//  Created by Nyghtwel on 2/13/22.
//

import Foundation

struct User {
    var name: String
    var email: String
    var password: String
    var website: String
    
    var isValidUser: Bool {
        !hasEmailError && !hasPasswordError
    }
    var hasEmailError: Bool { email.isEmpty || !email.isValidEmail }
    var hasPasswordError: Bool { password.isEmpty }
}

