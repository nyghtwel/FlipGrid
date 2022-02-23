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
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack(spacing: 8) {
            header()
            helperText()
            VStack(alignment: .center, spacing: 4) {
                if !viewModel.user.website.isEmpty, let url = uRLCheck(viewModel.user.website) {
                    Link(destination: url) {
                        Text(viewModel.user.website)
                            .foregroundColor(.blue)
                            .underline()
                            .font(.footnote)
                    }
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
                // pop back to profile creation since sign-in does not require any func
                presentation.wrappedValue.dismiss()
            }
        }
        .navigationBarHidden(true)
        .padding([.leading, .trailing], 10)
    }
    
    // recreate URL if string is missing http://
    func uRLCheck(_ url: String) -> URL {
        !url.hasPrefix("http://") ? URL(string: "http://\(url)")! : URL(string: url)!
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
        VStack {
            if text.isValidURL {
                Link(destination: URL(string: text)!) {
                    Text(text)
                        .foregroundColor(.blue)
                        .underline()
                        .font(.footnote)
                }
            } else {
                Text(text)
                    .font(.footnote)
            }
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(viewModel: ConfirmationViewModel(user: User(name: "", email: "scdsc", password: "scadc", website: "google.com")))
    }
}
