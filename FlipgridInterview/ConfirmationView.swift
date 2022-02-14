//
//  ConfirmationView.swift
//  FlipgridInterview
//
//  Created by Nyghtwel on 2/13/22.
//

import Foundation
import SwiftUI

struct ConfirmationView: View {
    @StateObject var viewModel: ConfirmationViewModel
    var body: some View {
        VStack(spacing: 8) {
            header()
            helperText()
            VStack(alignment: .center, spacing: 4) {
                if !viewModel.user.website.isEmpty {
                    body(viewModel.user.website)
                }
                if !viewModel.user.name.isEmpty {
                    body(viewModel.user.name)
                }
                if !viewModel.user.email.isEmpty {
                    body(viewModel.user.email)
                }
            }
            Spacer()
            BigRedButton(text: "Sign In") {
                viewModel.signInPressed()
            }
        }
        .padding([.leading, .trailing], 10)
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
    func body(_ text: String) -> some View {
        Text(text)
            .font(.footnote)
    }
}

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

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(viewModel: ConfirmationViewModel(user: User(name: "", email: "scdsc", password: "scadc", website: "adcs.com")))
    }
}

struct BigRedButton: View {
    private var action: () -> Void
    private var text: String
    init(text: String, action: @escaping () -> Void) {
        self.action = action
        self.text = text
    }
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Spacer()
                Text(text)
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
