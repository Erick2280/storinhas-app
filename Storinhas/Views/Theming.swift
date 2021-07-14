//
//  Theming.swift
//  Storinhas
//
//  Created by Erick Almeida on 12/07/21.
//

import Foundation
import SwiftUI

struct Theming {
    struct fonts {
        static let title = Font.custom("Londrina Solid", size: 48.0)
        static let body = Font.custom("Londrina Solid", size: 32.0)
        static let button = Font.custom("Londrina Solid", size: 36.0)
    }

    struct gradients {
        static let purple = LinearGradient(gradient: Gradient(colors: [Color("DeepBlue"), Color("Purple")]), startPoint: .top, endPoint: .bottom)
        static let sunrise = LinearGradient(gradient: Gradient(colors: [Color("LightOrange"), Color("Coral")]), startPoint: .top, endPoint: .bottom)
    }
}

struct Theming_Previews: PreviewProvider {
    static var previews: some View {
        VStack (alignment: .leading) {
            Text("Title")
                .font(Theming.fonts.title)

            Text("This is a body text.")
                .font(Theming.fonts.body)
                .padding(.vertical)
            
        }
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Fonts")
        .padding()
        
        VStack (alignment: .leading) {
            RoundedRectangle(cornerSize: CGSize(width: 16.0, height: 16.0))
                .fill(Theming.gradients.purple)
                .frame(width: 128, height: 128)
                .padding(.vertical, 8)
            
            RoundedRectangle(cornerSize: CGSize(width: 16.0, height: 16.0))
                .fill(Theming.gradients.sunrise)
                .frame(width: 128, height: 128)
                .padding(.vertical, 8)
            
        }
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Gradients")
        .padding()
    
    }
}
