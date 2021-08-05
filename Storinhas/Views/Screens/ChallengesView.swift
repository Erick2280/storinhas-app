//
//  ChallengesView.swift
//  Storinhas
//
//  Created by Erick Almeida on 08/07/21.
//

import SwiftUI

struct ChallengesView: View {
    var body: some View {
        ZStack {
            
            VStack {
                
                HStack {
                    Text("CHALLENGES_TITLE")
                        .font(Theming.fonts.title)
                        .foregroundColor(Color("DarkPurple"))
                    Spacer()
                }.padding(.leading, UIScreen.main.bounds.width / 9)
                
                Spacer()
            }.padding(.top, UIScreen.main.bounds.height / 5.5)
            
            VStack {
                Spacer()
                Spacer()
                Image("onboardingCat")
                    .resizable()
                    .frame(width: 400, height: 400, alignment: .center)
                Spacer()
                Text("CHALLENGES_WIP_WARNING")
                    .font(Theming.fonts.title)
                    .foregroundColor(Color("DarkPurple"))
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.leading, UIScreen.main.bounds.width / 15)
        }
        
    }
        
        
        
    }


struct ChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesView()
    }
}
