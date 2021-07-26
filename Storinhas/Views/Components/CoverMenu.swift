//
//  CoverMenu.swift
//  Storinhas
//
//  Created by Nadia Bordoni on 26/07/21.
//

import SwiftUI

struct CoverMenu: View {
    let personArray = ["persona1-1", "persona1-2", "persona1-3", "persona1-4", "persona2-1", "persona2-2", "persona2-3", "persona2-4", "persona3-1", "persona3-2", "persona3-3","persona3-4", "persona4-1", "persona4-2", "persona4-3","persona4-4","persona5-1", "persona5-2","persona5-3", "persona6-1", "persona6-2","persona6-3", "group-1","group-2","group-3","group-4", "group-5", "group-6", "group-7","group-8", "animals-1", "animals-2", "animals-3", "animals-4", "animals-5", "animals-6", "animals-7", "animals-8", "animals-9", "animals-10", "animals-11"]
    let sceneArray = ["scene-1", "scene-2", "scene-3", "scene-4", "scene-5", "scene-6"]
    
    let tabBarPerson = ["person", "personSelected"]
    let tabBarScene = ["scene", "sceneSelected"]
    let tabBarText = ["text", "textSelected"]
    
    @State var selectedIndex = 0
    
    @State var personToggle = 0
    @State var sceneToggle = 0
    @State var textToggle = 0
    @State var storyPage: StoryPage = StoryPage(backgroundPath: .catalogedAsset(named: "livro"), elements: [], history: StoryPageHistory())
    
    var body: some View {
        ZStack {
            
            ZStack {
                
                switch selectedIndex {
                
                case 0:
                    //nada selecionado
                    Text("")
                    
                case 1:
                    //person
                    ElementDrawer(selectedArray: .array(elements: personArray), storyPage: $storyPage)
                    
                case 2:
                    //Scene
                    ElementDrawer(selectedArray: .array(elements: sceneArray), storyPage: $storyPage)
                    
                    
                    
                case 3:
                    //text
                    ElementDrawer(selectedArray: .array(elements: personArray), storyPage: $storyPage)
                    //acho que aqui tem que chamar um texto field, nao sei
                    
                default:
                    //Person
                    ChallengesView()
                    
                }
                
            }
            
            
            HStack {
                
                ZStack {
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width / 8, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(30, corners: [.topRight, .bottomRight])
                        .shadow(radius: 20)
                        .foregroundColor(Color( red: 237/255, green: 244/255, blue: 255/255))
                        .edgesIgnoringSafeArea(.all)
                    
                    
                    VStack {
                        
                        Image("\(tabBarPerson[personToggle])")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                            .padding(.init(top: UIScreen.main.bounds.width / 20, leading: 0, bottom: UIScreen.main.bounds.width / 20, trailing: 0))
                            .onTapGesture {
                                
                                selectedIndex = 1
                                
                                
                                if personToggle == 0 {
                                    personToggle = 1
                                    sceneToggle = 0
                                    textToggle = 0
                                } else {
                                    print("tela de histórias selecionada")
                                }
                            }
                        
                        Image("\(tabBarScene[sceneToggle])")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                            .padding(.init(top: UIScreen.main.bounds.width / 20, leading: 0, bottom: UIScreen.main.bounds.width / 20, trailing: 0))
                            .onTapGesture {
                                
                                selectedIndex = 2
                                
                                
                                if sceneToggle == 0 {
                                    personToggle = 0
                                    sceneToggle = 1
                                    textToggle = 0
                                } else {
                                    print("tela de histórias selecionada")
                                }
                            }
                        
                        Image("\(tabBarText[textToggle])")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                            .padding(.init(top: UIScreen.main.bounds.width / 20, leading: 0, bottom: UIScreen.main.bounds.width / 20, trailing: 0))
                            .onTapGesture {
                                
                                selectedIndex = 3
                                
                                
                                if textToggle == 0 {
                                    personToggle = 0
                                    sceneToggle = 0
                                    textToggle = 1
                                } else {
                                    print("tela de histórias selecionada")
                                }
                            }
                        HStack{
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "arrow.uturn.left.circle.fill")
                            })
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "arrow.uturn.right.circle.fill")
                            })
                        }
                       
                        
                    }.padding(.bottom, 100)
                    
                    
                }
                
                .ignoresSafeArea()
                
                Spacer()
                
                PageCanvas(storyPage: $storyPage, editable: true)
                    .frame(width: 418, height: 532, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, UIScreen.main.bounds.height / 7)
                    
                
                Spacer(minLength: UIScreen.main.bounds.width / 3.2)
                
                
                
            }
            
        }.background(Theming.gradients.background)
    }
}

struct CoverMenu_Previews: PreviewProvider {
    static var previews: some View {
        CoverMenu()
    }
}
