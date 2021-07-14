//
//  TextButton.swift
//  Storinhas
//
//  Created by Erick Almeida on 08/07/21.
//

import SwiftUI

struct TextButton: View {
    @Binding var text: String
    
    var style: TextButtonStyle = .secondary
    var action: (() -> Void)?
    
    var body: some View {
        
        Button(action: {
            if (action != nil) {
                action!()
            }
        }) {
            if (style == .primary) {
                HStack {
                    Text(LocalizedStringKey(text))
                        .foregroundColor(Color.white)
                }
                .frame(width: 350, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(32)
                .padding(.horizontal)
                .background(Theming.gradients.purple)
                .cornerRadius(256)
            }
            
            if (style == .secondary) {
                HStack {
                    Text(LocalizedStringKey(text))
                        .foregroundColor(Color("Purple"))
                }
                .frame(width: 350, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(32)
                .padding(.horizontal)
                .overlay(
                    Capsule()
                        .stroke(Theming.gradients.purple, lineWidth: 4)
                )
            }
        }.font(Theming.fonts.button)
    }
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(text: Binding.constant("ACTION_SAVE"), style: .primary)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Primary button")
            .padding()

        TextButton(text: Binding.constant("ACTION_SKIP"))
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Default button")
            .padding()
    }
}

enum TextButtonStyle {
    case primary, secondary
}
