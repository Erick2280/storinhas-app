//
//  StoryEditorView.swift
//  Storinhas
//
//  Created by Erick Almeida on 08/07/21.
//

import SwiftUI

struct StoryEditorView: View {
    
    @EnvironmentObject var popUpManager: PopUpManager
    
    init(){
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    @ObservedObject var manager: Manager = Manager()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                VStack {
                    
                    HStack {
                        Text("EDITOR_TITLE")
                            .font(Theming.fonts.title)
                            .foregroundColor(Color("DarkPurple"))
                        Spacer()
                    }.padding(.leading, UIScreen.main.bounds.width / 9)
                    
                    Spacer()
                }.padding(.top, UIScreen.main.bounds.height / 5.5)
                
                NavigationLink(
                    destination: getDestination(),
                    label: {
                        TextButton(text: Binding.constant("ACTION_CREATE_STORY"), style: .primary, action: {
                            manager.storyOverView = true
    //                        popUpManager.showPopUp = false
                        })
                        
                    })
                    .fullScreenCover(isPresented: $manager.storyOverView, content: {
                        getDestination()
                    })
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                    .navigationBarTitle("")
            }
            .statusBar(hidden: true)
            
            
        }

        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        
        
        
    }
    
    func getDestination() -> AnyView {
        if manager.storyOverView == true {
            return AnyView(StoryOverview())
        } else {
            return AnyView(StoryOverview())
        }
    }
    
}


struct StoryEditorView_Previews: PreviewProvider {
    static var previews: some View {
        StoryEditorView().environmentObject(PopUpManager(showPopUp: false))
    }
}
