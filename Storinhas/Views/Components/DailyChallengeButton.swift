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
        
        
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            ZStack {
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.height / 1.3, height: UIScreen.main.bounds.height / 4.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(25)
                
                
                Image(imagemPersonagem)
                    .offset(x: UIScreen.main.bounds.width / 2.5, y: -UIScreen.main.bounds.height / 30)
//                    .padding(.init(top: 0, leading: UIScreen.main.bounds.width / 1.3, bottom: UIScreen.main.bounds.width / 11, trailing: 0))
                
                VStack {
                    Text("CHALLENGES_DAILYCHALLENGE")
                        .font(.custom("LondrinaSolid-Regular", size: 44))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, UIScreen.main.bounds.width / 1.85)
                        .padding(.bottom)
                        
                        
                    Text("CHALLENGES_DAILYCHALLENGEDESCRIPTION")
                        .font(.custom("SF-Pro-Rounded-Regular", size: 32))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, UIScreen.main.bounds.width / 1.54)
                        
                }
                .frame(width: UIScreen.main.bounds.height / 1.45, height: UIScreen.main.bounds.height / 5, alignment: .leading)
                .padding(.bottom)

                
            }
            
            
        })
        
        
        
        
    }
}




struct DailyChallengeButton_Previews: PreviewProvider {
    static var previews: some View {
        DailyChallengeButton(imagemPersonagem: "Coelhinho")
            .landscape()
    }
}

