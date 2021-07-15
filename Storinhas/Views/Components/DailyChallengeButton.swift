//
//  DailyChallengeButton.swift
//  Storinhas
//
//  Created by Vítor Bárrios Luís de Albuquerque on 13/07/21.
//

import SwiftUI

struct DailyChallengeButton: View {
    
    var imagemPersonagem: String
    
    var body: some View {
        
        
        ZStack {
            
            Rectangle()
                .fill(Theming.gradients.sunrise)
                .frame(width: UIScreen.main.bounds.height / 1.3, height: UIScreen.main.bounds.height / 4.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(25)
            
            
            Image(imagemPersonagem)
                .offset(x: UIScreen.main.bounds.width / 2.5, y: -UIScreen.main.bounds.height / 30)

            
            VStack(alignment: .leading, spacing: nil, content: {
                Text("CHALLENGES_DAILYCHALLENGE")
                    .font(Theming.fonts.title)
                    .tracking(3)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .padding(.trailing, UIScreen.main.bounds.width / 1.85)
                    .padding(.bottom)
                    .fixedSize(horizontal: true, vertical: false)
                    
                Text("CHALLENGES_DAILYCHALLENGETITLE")
                    .fixedSize(horizontal: true, vertical: false)
                    .lineLimit(1)
                    .font(.custom("SF-Pro-Rounded-Regular", size: 32))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.trailing, UIScreen.main.bounds.width / 1.54)
            })
            .frame(width: UIScreen.main.bounds.height / 1.45, height: UIScreen.main.bounds.height / 5, alignment: .leading)
            .padding(.bottom)

            
        }
        
        
        
        
    }
}



struct DailyChallengeButton_Previews: PreviewProvider {
    static var previews: some View {
        DailyChallengeButton(imagemPersonagem: "Coelhinho")
            .landscape()
    }
}

