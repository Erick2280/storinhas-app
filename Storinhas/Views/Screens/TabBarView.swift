//
//  TabBarView.swift
//  Storinhas
//
//  Created by Vítor Bárrios Luís de Albuquerque on 19/07/21.
//

import SwiftUI

struct TabBarView: View {
    
    let tabBarBook = ["book", "bookSelected"]
    let tabBarPencil = ["pencil", "pencilSelected"]
    let tabBarCrown = ["crown", "crownSelected"]
    
    @State var selectedIndex = 0
    
    @State var bookToggle = 0
    @State var pencilToggle = 0
    @State var crownToggle = 0
    @State var tabBarToggle = 0
    
    
    var body: some View {
        
        ZStack {
            
            ZStack {
                
                switch selectedIndex {
                    
                case 0:
                    //onboarding
                Text("tela de onboarding")
                    
                case 1:
                    //historias
                StoriesView()
                    
                case 2:
                    //editor
                StoryEditorView()
                    
                default:
                    //desafios
                ChallengesView()
                
                }
                
            }
            
            
            HStack {
                
                ZStack {
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width / 12, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(30, corners: [.topRight, .bottomRight])
                        .shadow(radius: 20)
                        .foregroundColor(Color( red: 237/255, green: 244/255, blue: 255/255))
                        .edgesIgnoringSafeArea(.all)
                    
                    
                    VStack {
                        
                        Image("\(tabBarBook[bookToggle])")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                            .padding(.init(top: UIScreen.main.bounds.width / 10, leading: 0, bottom: 0, trailing: 0))
                            .onTapGesture {
                                
                                selectedIndex = 1
                                
                                if bookToggle == 0 {
                                    bookToggle = 1
                                    crownToggle = 0
                                    pencilToggle = 0
                                } else {
                                    print("tela de histórias selecionada")
                                }
                            }
                            .padding(.top)
                        
                        Spacer()

                        Image("\(tabBarPencil[pencilToggle])")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                            .padding(.init(top: UIScreen.main.bounds.width / 5, leading: 0, bottom: UIScreen.main.bounds.width / 5, trailing: 0))
                            .onTapGesture {
                                
                                selectedIndex = 2
                                
                                if pencilToggle == 0 {
                                    pencilToggle = 1
                                    bookToggle = 0
                                    crownToggle = 0
                                } else {
                                    print("tela de histórias selecionada")
                                }
                            }
                        
                        Spacer()
                        
                        Image("\(tabBarCrown[crownToggle])")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                            .padding(.init(top: 0, leading: 0, bottom: UIScreen.main.bounds.width / 10, trailing: 0))
                            .onTapGesture {
                                
                                selectedIndex = 3
                                
                                if crownToggle == 0 {
                                    crownToggle = 1
                                    bookToggle = 0
                                    pencilToggle = 0
                                } else {
                                    print("tela de histórias selecionada")
                                }
                            }
                            .padding(.bottom)

                    }
                    
                    
                }
                
                .ignoresSafeArea()
                
                Spacer()
                

                
            }
            
        }

    }
}


<<<<<<< HEAD
=======
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

>>>>>>> e955a4f622f21f2bb3ba16fff7e1914870795eca
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
