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

struct ProfileCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationView()
    }
}
