//
//  ConfirmationVIewModel.swift
//  FlipgridInterview
//
//  Created by Nyghtwel on 2/22/22.
//

import Foundation
import SwiftUI

class ConfirmationViewModel: ObservableObject {
    @Published var headerText = ""
    @Published var helperText = "Your super-awesome portfolio has been successfully submitted! The details below will be public within your community!"
    @Published var user: User
    
    init(user: User) {
        self.user = user
        headerText = user.name.isEmpty ? "Hello!" : "Hello, \(user.name)!"
    }
    
    func signInPressed() {
        print("sign in pressed")
    }
}
