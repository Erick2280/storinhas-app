//
//  ComponentMenu.swift
//  Storinhas
//
//  Created by Nadia Bordoni on 19/07/21.
//

import SwiftUI

struct ComponentMenu: View {
    
    let tabBarPerson = ["person", "personSelected"]
    let tabBarObject = ["object", "objectSelected"]
    let tabBarScene = ["scene", "sceneSelected"]
    let tabBarBubble = [ "bubble", "bubbleSelected"]
    
    @State var selectedIndex = 0
    
    @State var personToggle = 0
    @State var objectToggle = 0
    @State var sceneToggle = 0
    @State var bubbleToggle = 0
    
    @ObservedObject var manager: Manager = Manager.shared
    
    var body: some View {
        
        ZStack {
            
            ZStack {
                
                switch selectedIndex {
                
                case 0:
                    //nada selecionado
                    Text("")
                    
                case 1:
                    //person
                    ElementDrawer()
                    
                case 2:
                    //object
                    ElementDrawer()
                    
                    
                case 3:
                    //Scene
                    ElementDrawer()
                    
                    
                case 4:
                    //bubble
                    ElementDrawer()
                    
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
                                manager.selectedArray = .array(elements: manager.personArray)
                                
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
                            .padding(.init(top: UIScreen.main.bounds.width / 20, leading: 0, bottom: UIScreen.main.bounds.width / 20, trailing: 0))
                            .onTapGesture {
                                
                                selectedIndex = 2
                                manager.selectedArray = .array(elements: manager.objectArray)
                                
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
                            .padding(.init(top: UIScreen.main.bounds.width / 20, leading: 0, bottom: UIScreen.main.bounds.width / 20, trailing: 0))
                            .onTapGesture {
                                
                                selectedIndex = 3
                                manager.selectedArray = .array(elements: manager.sceneArray)
                                
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
                            .padding(.init(top: UIScreen.main.bounds.width / 20, leading: 0, bottom: UIScreen.main.bounds.width / 20, trailing: 0))
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
                            }
                        // incluir os outros botoes
                        
                    }.padding(.bottom, 100)
                    
                    
                }
                
                .ignoresSafeArea()
                
                Spacer()
                
                
                
            }
            
        }
        
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
            .landscape()
    }
}

struct LandscapeModifier: ViewModifier {
    let height = UIScreen.main.bounds.width
    let width = UIScreen.main.bounds.height
    
    var isPad: Bool {
        return height >= 768
    }
    
    var isRegularWidth: Bool {
        return height >= 414
    }
    
    func body(content: Content) -> some View {
        content
            .previewLayout(.fixed(width: width, height: height))
            .environment(\.horizontalSizeClass, isRegularWidth ? .regular: .compact)
            .environment(\.verticalSizeClass, isPad ? .regular: .compact)
    }
}

extension View {
    func landscape() -> some View {
        self.modifier(LandscapeModifier())
    }
}
