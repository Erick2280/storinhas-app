//
//  saveOverlay.swift
//  Storinhas
//
//  Created by Nadia Bordoni on 28/07/21.
//

import SwiftUI

struct saveOverlay: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var popUpManager: PopUpManager
    @ObservedObject var manager: Manager
    @EnvironmentObject var savedStoriesManager: SavedStoriesManager
    
    @State private var savedStory: Bool = false
    
    var body: some View {
        
        //        NavigationView {
        VStack(){
            
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(Color("DarkPurple"))
                .font(.largeTitle)
                .onTapGesture {
                    popUpManager.showPopUp = false
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.leading, UIScreen.main.bounds.width / 2.5)
                .padding()
            
            Text("SAVE_WARNING")
                .font(Theming.fonts.title)
                .foregroundColor(Color("DarkPurple"))
            HStack(){
                
                NavigationLink(
                    destination: getDestination(),
                    label: {
                        TextButton(text: .constant("ACTION_DONT_SAVE"), style: .secondary, action: {
                            //a historia nao é salva para visualização
                            manager.nextView = true
                            savedStory = false
                            
                        })
                        .padding()
                    })
                    .fullScreenCover(isPresented: self.$manager.nextView, content: {
                        getDestination()
                        
                    })
                
                
                
                NavigationLink(
                    destination: getDestination(),
                    label: {
                        TextButton(text: .constant("ACTION_SAVE"), style: .primary, padding: 30, action: {
                            //a historia fica visualizavel na home e tambem possível de ler
                            if savedStoriesManager.noStoriesSaved == true {
                                savedStoriesManager.noStoriesSaved = false
                                manager.nextView = true
                                savedStory = true
                            } else {
                                manager.nextView = true
                                savedStory = true
                            }
                        })
                        .padding()
                    })
                    .fullScreenCover(isPresented: self.$manager.nextView, content: {
                        getDestination()
                        
                    })
                
            }.padding()
        }
        .background(
            Rectangle()
                .cornerRadius(30)
                .shadow(radius: 20)
                .foregroundColor(.white))
        .padding(50)
        .padding(.bottom, UIScreen.main.bounds.height / 7)
        .clipped()
        
        //        }
        //        .navigationViewStyle(StackNavigationViewStyle())
        //        .navigationBarHidden(true)
        //        .navigationBarBackButtonHidden(true)
        //        .navigationBarTitle("", displayMode: .inline)
        
        //        .fullScreenCover(isPresented: $manager.nextView, content: {
        //            getDestination()
        //
        //        })
    }
    
    func getDestination() -> AnyView {
        if savedStory == false {
            return AnyView(TabBarView(selectedIndex: 2, bookToggle: 0, pencilToggle: 1, crownToggle: 0, tabBarToggle: 0))
        } else {
            return AnyView(TabBarView(selectedIndex: 1, bookToggle: 1, pencilToggle: 0, crownToggle: 0, tabBarToggle: 0))
        }
    }
    
}

struct saveOverlay_Previews: PreviewProvider {
    static var previews: some View {
        saveOverlay(manager: Manager()).environmentObject(PopUpManager(showPopUp: true)).environmentObject(SavedStoriesManager(noStoriesSaved: true))
    }
}
