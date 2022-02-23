//
//  Custom Views.swift
//  FlipgridInterview
//
//  Created by Nyghtwel on 2/13/22.
//

import Foundation
import SwiftUI

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
