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
                .frame(width: UIScreen.main.bounds.height / 1.4, height: UIScreen.main.bounds.height / 4.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(25)
            
            HStack {
                Spacer()
                Image(imagemPersonagem)
                    .padding(.trailing, 50)
                    .padding(.bottom, 50)
            }
            .frame(width: UIScreen.main.bounds.height / 1.4, height: UIScreen.main.bounds.height / 4.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)


            
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
            .padding(.leading, 50)

            
        }
    

        
    }
}



struct DailyChallengeButton_Previews: PreviewProvider {
    static var previews: some View {
        DailyChallengeButton(imagemPersonagem: "Coelhinho")
            .landscape()

    }
}

