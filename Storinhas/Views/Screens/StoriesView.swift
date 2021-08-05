//
//  StoriesView.swift
//  Storinhas
//
//  Created by Erick Almeida on 08/07/21.
//

import SwiftUI

struct StoriesView: View {
    @EnvironmentObject var storiesManager: StoriesManager
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                HStack {
                    Text("STORIES_TITLE")
                        .font(Theming.fonts.title)
                        .foregroundColor(Color("DarkPurple"))
                    Spacer()
                }.padding(.leading, UIScreen.main.bounds.width / 9)
                
                Spacer()
            }.padding(.top, UIScreen.main.bounds.height / 5.5)
            
            if storiesManager.stories.count == 0 {
                VStack {
                    Spacer()
                    Spacer()
                    Image("onboardingCat")
                        .resizable()
                        .frame(width: 400, height: 400, alignment: .center)
                    Spacer()
                    Text("STORIES_WIP_WARNING")
                        .font(Theming.fonts.title)
                        .foregroundColor(Color("DarkPurple"))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.leading, UIScreen.main.bounds.width / 15)
            } else {
                
                
                Text("grid com hsitórias salvas")
                
            }
            
            
        }
        
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView().environmentObject(StoriesManager())
    }
}
