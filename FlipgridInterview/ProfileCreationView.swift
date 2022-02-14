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
            helpText()
                .padding(.bottom, 10)
            inputForm(placeholder: "First Name", text:                                $viewModel.user.name)
            inputForm(placeholder: "Email Address", text:                                $viewModel.user.email)
            inputForm(placeholder: "Password", text:                                $viewModel.user.password)
            inputForm(placeholder: "Website", text:                                $viewModel.user.website)
            Spacer()
            submitButton()
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
    func helpText() -> some View {
        HStack {
            Text(viewModel.helpText)
                .font(.footnote)
                .foregroundColor(.gray)
            Spacer()
        }
    }
    func submitButton() -> some View {
        Button(action: {
            print("submit tapped")
        }, label: {
            HStack {
                Spacer()
                Text("Submit")
                    .fontWeight(.semibold)
                    .font(.callout)
                Spacer()
            }
            .padding()
            .foregroundColor(.white)
            .background(.red)
            .cornerRadius(15)
        })
    }
}

class ProfileCreationViewModel: ObservableObject {
    @Published var headerText = "Profile Creation"
    @Published var helpText = "Use the form below to submit your portfolio.\nAn email and password are required."
    @Published var user: User
    init() {
        user = User(name: "", email: "", password: "", website: "")
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
