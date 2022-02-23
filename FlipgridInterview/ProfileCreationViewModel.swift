//
//  ProfileCreationViewModel.swift
//  FlipgridInterview
//
//  Created by Nyghtwel on 2/22/22.
//

import Foundation
import SwiftUI

class ProfileCreationViewModel: ObservableObject {
    @Published var headerText = "Profile Creation"
    @Published var helperText = "Use the form below to submit your portfolio.\nAn email and password are required."
    @Published var user: User
    @Published var showConfirmation = false
    @Published var isShowingInvalidEmailError = false
    @Published var isShowingEmptyEmailError = false
    @Published var isShowingEmptyPasswordError = false
    
    enum ProfileCreationError: Error {
        case invalidEmail
        case missingEmail
        case missingPassword
        var errorMessage: String {
            switch self {
            case .invalidEmail:  return "Invalid Email"
            case .missingEmail:  return "Email Required"
            case .missingPassword:  return "Password Required"
            }
        }
    }
    
    init() {
        user = User(name: "", email: "", password: "", website: "")
    }
    
    func submitPressed() {
        resetErrors()
        if user.email.isEmpty {
            isShowingEmptyEmailError = true
        } else if !user.email.isValidEmail {
            isShowingInvalidEmailError = true
        }
        if user.password.isEmpty {
            isShowingEmptyPasswordError = true
        }
        if user.isValidUser {
            showConfirmation = true
            print("valid profile creation")
        } else {
            print("not valid profile creation")
        }
    }
    
    private func resetErrors() {
        isShowingEmptyEmailError = false
        isShowingInvalidEmailError = false
        isShowingEmptyPasswordError = false
    }
    // TODO when I have more time, check if password is strong enough
    private func isPasswordStrong() -> Bool {
        false
    }
}
