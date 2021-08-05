//
//  OnboardingView.swift
//  Storinhas
//
//  Created by Vítor Bárrios Luís de Albuquerque on 05/08/21.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack {
            
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Image("onboardingCat")
                        .resizable()
                        .frame(width: 400, height: 400, alignment: .center)

                    
                    Spacer()
                }
                .padding(.leading, UIScreen.main.bounds.width / 15)
                .padding(.top, UIScreen.main.bounds.height / 3)
            }
            HStack {
                VStack {
                    ZStack {
                        
                        Image("bubble-1")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 2.5, height: UIScreen.main.bounds.height / 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text("ONBOARDING_WELCOME")
                            .font(Theming.fonts.button)
                            .foregroundColor(Color("DarkPurple"))
                            .multilineTextAlignment(.center)
                    }.padding(.trailing, UIScreen.main.bounds.width / 10)
                }.padding(.bottom, UIScreen.main.bounds.height / 3)
            }
            
            
            
            
            
            
        }.padding(.trailing)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
