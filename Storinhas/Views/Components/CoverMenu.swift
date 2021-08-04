//
//  CoverMenu.swift
//  Storinhas
//
//  Created by Nadia Bordoni on 26/07/21.
//

import SwiftUI

struct CoverMenu: View {
    let personArray = ["persona1-1", "persona1-2", "persona1-3", "persona1-4", "persona2-1", "persona2-2", "persona2-3", "persona2-4", "persona3-1", "persona3-2", "persona3-3","persona3-4", "persona4-1", "persona4-2", "persona4-3","persona4-4","persona5-1", "persona5-2","persona5-3", "persona6-1", "persona6-2","persona6-3", "group-1","group-2","group-3","group-4", "group-5", "group-6", "group-7","group-8", "animals-1", "animals-2", "animals-3", "animals-4", "animals-5", "animals-6", "animals-7", "animals-8", "animals-9", "animals-10", "animals-11"]
    let sceneArray = ["livro-1", "livro-2", "livro-3", "livro-4"]
    
    let tabBarPerson = ["person", "personSelected"]
    let tabBarScene = ["scene", "sceneSelected"]
    let tabBarText = ["text", "textSelected"]
    
    @State var selectedDrawer: SelectedCoverDrawer = .none

    @State var storyPage: StoryPage = StoryPage(backgroundPath: .catalogedAsset(named: "livro-1"), elements: [], history: StoryPageHistory())
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        let pageCanvas = PageCanvas(storyPage: $storyPage, editable: true)
        
        
        ZStack {
            HStack {
                                
                                Spacer()
                                
                                VStack {
                                
                                NavigationLink(
                                    
                                    destination: ChallengesView(),
                                    label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(Color("DarkPurple"))
                                            .font(.largeTitle)
                                            .onTapGesture {
                                                presentationMode.wrappedValue.dismiss()
                                            }
                                    })
                                    .navigationBarBackButtonHidden(true)
                                    .navigationBarHidden(true)
                                    .navigationBarTitle("")
                                    
                                    Spacer()
                                    
                                }.padding(.top, UIScreen.main.bounds.height / 55)
                                
                            }.padding(.trailing, UIScreen.main.bounds.width / 40)
            ZStack {
                
                switch self.selectedDrawer {
                
                case .none:
                    EmptyView()
                    
                case .personDrawer:
                    ElementDrawer(selectedArray: .array(elements: personArray), storyPage: $storyPage)
                    
                case .sceneDrawer:
                    ElementDrawer(selectedArray: .array(elements: sceneArray), storyPage: $storyPage, drawerMode: .background)
                    
                    
                case .textDrawer:
                    ElementDrawer(selectedArray: .array(elements: personArray), storyPage: $storyPage)
                //acho que aqui tem que chamar um text field, nao sei
                    
                }
                
            }
            
            
            HStack {
                
                ZStack {
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width / 8, height: UIScreen.main.bounds.height, alignment: .center)
                        .cornerRadius(30, corners: [.topRight, .bottomRight])
                        .shadow(radius: 20)
                        .foregroundColor(Color( red: 237/255, green: 244/255, blue: 255/255))
                        .edgesIgnoringSafeArea(.all)
                    
                    
                    VStack {
                        
                        Image(tabBarPerson[selectedDrawer == .personDrawer ? 1 : 0])
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                            .padding(.init(top: UIScreen.main.bounds.width / 25, leading: 0, bottom: UIScreen.main.bounds.width / 25, trailing: 0))
                            .onTapGesture {
                                switch self.selectedDrawer {
                                    case .personDrawer: self.selectedDrawer = .none
                                    default: self.selectedDrawer = .personDrawer
                                }
                            }
                        
                        Image(tabBarScene[selectedDrawer == .sceneDrawer ? 1 : 0])
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                            .padding(.init(top: UIScreen.main.bounds.width / 25, leading: 0, bottom: UIScreen.main.bounds.width / 25, trailing: 0))
                            .onTapGesture {
                                switch self.selectedDrawer {
                                    case .sceneDrawer: self.selectedDrawer = .none
                                    default: self.selectedDrawer = .sceneDrawer
                                }
                            }
                        
                        Image(tabBarText[selectedDrawer == .textDrawer ? 1 : 0])
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                            .padding(.init(top: UIScreen.main.bounds.width / 25, leading: 0, bottom: UIScreen.main.bounds.width / 25, trailing: 0))
                            .onTapGesture {
                                switch self.selectedDrawer {
                                    case .textDrawer: self.selectedDrawer = .none
                                    default: self.selectedDrawer = .textDrawer
                                }
                            }.padding(.bottom, 180)
                        
                        HStack{
                            Button(action: {
                                pageCanvas.undo()
                            }, label: {
                                Image(systemName: "arrow.uturn.left.circle.fill")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.height / 25, height: UIScreen.main.bounds.height / 25, alignment: .center)
                            }).disabled(!storyPage.history.undoAvailable).padding(.horizontal, 8.0)
                            
                            Button(action: {
                                pageCanvas.redo()
                            }, label: {
                                Image(systemName: "arrow.uturn.right.circle.fill")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.height / 25, height: UIScreen.main.bounds.height / 25, alignment: .center)
                            }).disabled(!storyPage.history.redoAvailable).padding(.horizontal, 8.0)
                        }
                        
                    }
                    
                    
                }
                
                .ignoresSafeArea()
                
                Spacer()
                
                pageCanvas.frame(width: 418, height: 532, alignment: .center)
                    .clipped()
                    .padding(.bottom, UIScreen.main.bounds.height / 7)
                
                
                Spacer(minLength: UIScreen.main.bounds.width / 4.2)
                
            }
            
            
        }.padding(.top, 18.0)
        .background(Theming.gradients.background)
        
        
        
    }
    
    public enum SelectedCoverDrawer {
        case none
        case personDrawer
        case sceneDrawer
        case textDrawer
    }
}

struct CoverMenu_Previews: PreviewProvider {
    static var previews: some View {
        CoverMenu()
    }
}
