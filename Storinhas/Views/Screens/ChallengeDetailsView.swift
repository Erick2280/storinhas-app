//
//  ChallengeDetailsView.swift
//  Storinhas
//
//  Created by Vítor Bárrios Luís de Albuquerque on 13/07/21.
//

import SwiftUI

struct ChallengeDetailsView: View {
    var body: some View {
        
        VStack {
            
            Text("CHALLENGES_DAILYCHALLENGE")
                .font(.custom("LondrinaSolid-Regular", size: 48))
            
            ZStack {
                
                
                
                Rectangle()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                        .cornerRadius(30)
                
                VStack {
                    Spacer()
                    Text("CHALLENGES_DAILYCHALLENGEDESCRIPTION")
                        .font(.custom("LondrinaSolid-Black", size: 32))
                    Spacer()
                    Text("CHALLENGES_WARNING")
                        .font(.custom("SF-Pro-Rounded-Regular", size: 20))
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: UIScreen.main.bounds.height / 30, content: {
                        Text("CHALLENGE_REQUIREMENT1")
                            .font(.custom("SF-Pro-Rounded-Regular", size: 20))

                        Text("CHALLENGE_REQUIREMENT2")
                            .font(.custom("SF-Pro-Rounded-Regular", size: 20))

                        Text("CHALLENGE_REQUIREMENT3")
                            .font(.custom("SF-Pro-Rounded-Regular", size: 20))
                    })
                        
                        

                        

                    
                    
                  Spacer()

                }
                
            }
            .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.height / 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            .padding(.vertical, UIScreen.main.bounds.height / 20)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("ACTION_START")
                    .font(.custom("LondrinaSolid-Regular", size: 36))
            })
            
        }
    }
}



struct ChallengeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeDetailsView()
            .landscape()
    }
}
