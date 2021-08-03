//
//  StoryEditorView.swift
//  Storinhas
//
//  Created by Erick Almeida on 08/07/21.
//

import SwiftUI

struct StoryEditorView: View {
    
    init(){
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    @ObservedObject var manager: Manager = Manager()
    
    var body: some View {
        
        NavigationView {
            
            NavigationLink(
                destination: getDestination(),
                label: {
                    TextButton(text: Binding.constant("ACTION_CREATE_STORY"), style: .primary, action: {
                        manager.storyOverView = true
                    })
                    
                })
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .navigationBarTitle("")
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .fullScreenCover(isPresented: $manager.storyOverView, content: {
            getDestination()
        })
        
        
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
        StoryEditorView()
    }
}
