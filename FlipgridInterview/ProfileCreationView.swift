//
//  ProfileCreationView.swift
//  FlipgridInterview
//
//  Created by Nyghtwel on 2/13/22.
//

import Foundation
import SwiftUI

struct ProfileCreationView: View {
    @StateObject var viewModel = ProfileCreationViewModel()
    var body: some View {
        VStack {
            header()
            helperText()
                .padding(.bottom, 10)
            inputForm(placeholder: "First Name", text:                                $viewModel.user.name)
            inputForm(placeholder: "Email Address", text:                                $viewModel.user.email)
            inputForm(placeholder: "Password", text:                                $viewModel.user.password)
            inputForm(placeholder: "Website", text:                                $viewModel.user.website)
            Spacer()
            BigRedButton(text: "Submit") {
                viewModel.submitPressed()
            }
        }
        .padding([.leading, .trailing], 12)
    }
    func inputForm(placeholder: String, text: Binding<String>) -> some View {
        VStack {
            TextField(placeholder, text: text)
                .font(.footnote)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
    }
    func header() -> some View {
        HStack {
            Text(viewModel.headerText)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
        }
    }
    func helperText() -> some View {
        HStack {
            Text(viewModel.helperText)
                .font(.footnote)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

class ProfileCreationViewModel: ObservableObject {
    @Published var headerText = "Profile Creation"
    @Published var helperText = "Use the form below to submit your portfolio.\nAn email and password are required."
    @Published var user: User
    init() {
        user = User(name: "", email: "", password: "", website: "")
    }
    func submitPressed() {
        guard user.email.isValidEmail else {
            print("email not valid")
            return
        }
        if !user.email.isEmpty && !user.password.isEmpty {
            print("valid profile creation")
        } else {
            print("not valid profile creation")
        }
    }
    // TODO when I have more time, check if password is strong enough
    func isPasswordStrong() -> Bool {
        false
    }
}

struct ProfileCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationView()
    }
}

struct User {
    var name: String
    var email: String
    var password: String
    var website: String
}

fileprivate extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    var isValidWebsiteURL: Bool {
        let websiteRegEx = "[A-Z0-9a-z._%+-]+\\.[A-Za-z]{2,64}"
        let websitePred = NSPredicate(format:"SELF MATCHES %@", websiteRegEx)
        return websitePred.evaluate(with: self)
    }
}
