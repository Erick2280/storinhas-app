//
//  ComponentMenu.swift
//  Storinhas
//
//  Created by Nadia Bordoni on 19/07/21.
//

import SwiftUI

struct ComponentMenu: View {
    let personArray = ["persona1-1", "persona1-2", "persona1-3", "persona1-4", "persona2-1", "persona2-2", "persona2-3", "persona2-4", "persona3-1", "persona3-2", "persona3-3","persona3-4", "persona4-1", "persona4-2", "persona4-3","persona4-4","persona5-1", "persona5-2","persona5-3", "persona6-1", "persona6-2","persona6-3", "group-1","group-2","group-3","group-4", "group-5", "group-6", "group-7","group-8", "animals-1", "animals-2", "animals-3", "animals-4", "animals-5", "animals-6", "animals-7", "animals-8", "animals-9", "animals-10", "animals-11"]
    let objectArray = ["object-1", "object-2", "object-3", "object-4", "object-5", "object-6", "object-7", "object-8", "object-9", "object-10", "object-11", "object-12", "object-13", "object-14"]
    let sceneArray = ["scene-1", "scene-2", "scene-3", "scene-4", "scene-5", "scene-6"]
    //let bubbleArray = []
    
    let tabBarPerson = ["person", "personSelected"]
    let tabBarObject = ["object", "objectSelected"]
    let tabBarScene = ["scene", "sceneSelected"]
    let tabBarBubble = [ "bubble", "bubbleSelected"]
    
    @State var selectedIndex = 0
    
    @State var personToggle = 0
    @State var objectToggle = 0
    @State var sceneToggle = 0
    @State var bubbleToggle = 0
    @State var storyPage: StoryPage = StoryPage(backgroundPath: .catalogedAsset(named: "scene-1"), elements: [
        PageElement(x: -0.4, y: -0.2, scale: 0.1, imagePath: .catalogedAsset(named: "TestRabbit")),
        PageElement(x: -0.3, y: 0.3, scale: 0.1, imagePath: .catalogedAsset(named: "TestRabbit")),
        PageElement(x: -0.2, y: 0.1, scale: 0.1, imagePath: .catalogedAsset(named: "TestTurtle"))
    ], history: StoryPageHistory())
    
    
    var body: some View {
        let pageCanvas = PageCanvas(storyPage: $storyPage, editable: true)
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
                    //object
                    ElementDrawer(selectedArray: .array(elements: objectArray), storyPage: $storyPage)
                    
                    
                    
                case 3:
                    //Scene
                    ElementDrawer(selectedArray: .array(elements: sceneArray), storyPage: $storyPage, changeBackground: true)
                    
                    
                    
                case 4:
                    //bubble
                    ElementDrawer(selectedArray: .array(elements: personArray), storyPage: $storyPage)
                    
                    
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
                            .padding(.init(top: UIScreen.main.bounds.width / 25, leading: 0, bottom: UIScreen.main.bounds.width / 25, trailing: 0))
                            .onTapGesture {
                                
                                selectedIndex = 1
                                
                                
                                if personToggle == 0 {
                                    personToggle = 1
                                    objectToggle = 0
                                    sceneToggle = 0
                                    bubbleToggle = 0
                                } else {
                                    print("tela de histórias selecionada")
                                }
                            }
                        
                        Image("\(tabBarObject[objectToggle])")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                            .padding(.init(top: UIScreen.main.bounds.width / 25, leading: 0, bottom: UIScreen.main.bounds.width / 25, trailing: 0))
                            .onTapGesture {
                                
                                selectedIndex = 2
                                
                                
                                if objectToggle == 0 {
                                    personToggle = 0
                                    objectToggle = 1
                                    sceneToggle = 0
                                    bubbleToggle = 0
                                } else {
                                    print("tela de histórias selecionada")
                                }
                            }
                        
                        Image("\(tabBarScene[sceneToggle])")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                            .padding(.init(top: UIScreen.main.bounds.width / 25, leading: 0, bottom: UIScreen.main.bounds.width / 25, trailing: 0))
                            .onTapGesture {
                                
                                selectedIndex = 3
                                
                                
                                if sceneToggle == 0 {
                                    personToggle = 0
                                    objectToggle = 0
                                    sceneToggle = 1
                                    bubbleToggle = 0
                                } else {
                                    print("tela de histórias selecionada")
                                }
                            }
                        
                        Image("\(tabBarBubble[bubbleToggle])")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                            .padding(.init(top: UIScreen.main.bounds.width / 25, leading: 0, bottom: UIScreen.main.bounds.width / 25, trailing: 0))
                            .onTapGesture {
                                
                                selectedIndex = 4
                                
                                
                                if bubbleToggle == 0 {
                                    personToggle = 0
                                    objectToggle = 0
                                    sceneToggle = 0
                                    bubbleToggle = 1
                                } else {
                                    print("tela de histórias selecionada")
                                }
                            }.padding(.bottom, 8)
                        
                        HStack{
                            Button(action: {
                                pageCanvas.undo()
                            }, label: {
                                Image(systemName: "arrow.uturn.left.circle.fill")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.height / 25, height: UIScreen.main.bounds.height / 25, alignment: .center)
                            }).padding(.horizontal, 8.0)
                            
                            Button(action: {
                                pageCanvas.redo()
                            }, label: {
                                Image(systemName: "arrow.uturn.right.circle.fill")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.height / 25, height: UIScreen.main.bounds.height / 25, alignment: .center)
                            }).padding(.horizontal, 8.0)
                        }
                        
                    }
                    
                    
                    
                }
                
                .ignoresSafeArea()
                
                Spacer()
                
                PageCanvas(storyPage: $storyPage, editable: true)
                    .frame(width: 500, height: 500, alignment: .center)
                    .padding(.bottom, UIScreen.main.bounds.height / 7)
                    
                
                Spacer(minLength: UIScreen.main.bounds.width / 3.2)
                
                
                
            }
            
        }.padding(.top, 18.0)
        .background(Theming.gradients.background)
        
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ComponentMenu_Previews: PreviewProvider {
    static var previews: some View {
        ComponentMenu()
            
    }
}

