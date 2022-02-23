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
            Group {
                inputForm(placeholder: "First Name", text: $viewModel.user.name)
                inputForm(
                    placeholder: "Email Address",
                    text: $viewModel.user.email,
                    hasError: viewModel.isShowingEmptyEmailError || viewModel.isShowingInvalidEmailError
                )
                if viewModel.isShowingEmptyEmailError {
                    errorMessage(error: .missingEmail)
                }
                if viewModel.isShowingInvalidEmailError {
                    errorMessage(error: .invalidEmail)
                }
                inputForm(
                    placeholder: "Password",
                    text: $viewModel.user.password,
                    hasError: viewModel.isShowingEmptyPasswordError
                )
                if viewModel.isShowingEmptyPasswordError {
                    errorMessage(error: .missingPassword)
                }
                inputForm(placeholder: "Website", text: $viewModel.user.website)
            }
            Spacer()
            BigRedButton(text: "Submit") {
                viewModel.submitPressed()
            }
            NavigationLink(
                isActive: $viewModel.showConfirmation,
                destination: { ConfirmationView(viewModel: ConfirmationViewModel(user: viewModel.user)) },
                label: { EmptyView() }
            )
        }
        .navigationBarHidden(true)
        .padding([.leading, .trailing], 15)
    }
    
    func inputForm(placeholder: String, text: Binding<String>, hasError: Bool = false) -> some View {
        VStack {
            TextField(placeholder, text: text)
                .font(.footnote)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .strokeBorder(hasError ? .red : .black, style: StrokeStyle(lineWidth: 1.0))
        )
    }
    
    func errorMessage(error: ProfileCreationViewModel.ProfileCreationError) -> some View {
        HStack {
            Text(error.errorMessage)
                .font(.caption)
                .foregroundColor(.red)
                .italic()
            Spacer()
        }
        .padding(.leading, 10)
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
    @Published var showConfirmation = false
    @Published var isShowingInvalidEmailError = false
    @Published var isShowingEmptyEmailError = false
    @Published var isShowingEmptyPasswordError = false
    @Published var errorSet = Set<ProfileCreationError>()
    
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
        guard errorSet.isEmpty else { return }
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
    func isPasswordStrong() -> Bool {
        false
    }
}

struct ProfileCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationView()
    }
}
