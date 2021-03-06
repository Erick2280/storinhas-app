//
//  ComponentMenu.swift
//  Storinhas
//
//  Created by Nadia Bordoni on 19/07/21.
//

import SwiftUI

struct ComponentMenu: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let personArray = ["persona1-1", "persona1-2", "persona1-3", "persona1-4", "persona2-1", "persona2-2", "persona2-3", "persona2-4", "persona3-1", "persona3-2", "persona3-3","persona3-4", "persona4-1", "persona4-2", "persona4-3","persona4-4","persona5-1", "persona5-2","persona5-3", "persona6-1", "persona6-2","persona6-3", "group-1","group-2","group-3","group-4", "group-5", "group-6", "group-7","group-8", "animals-1", "animals-2", "animals-3", "animals-4", "animals-5", "animals-6", "animals-7", "animals-8", "animals-9", "animals-10", "animals-11"]
    let objectArray = ["object-1", "object-2", "object-3", "object-4", "object-5", "object-6", "object-7", "object-8", "object-9", "object-10", "object-11", "object-12", "object-13", "object-14"]
    let sceneArray = ["scene-1", "scene-2", "scene-3", "scene-4", "scene-5", "scene-6"]
    let bubbleArray = ["bubble-1", "bubble-2", "bubble-3", "bubble-4", "bubble-5"]
    
    let tabBarPerson = ["person", "personSelected"]
    let tabBarObject = ["object", "objectSelected"]
    let tabBarScene = ["scene", "sceneSelected"]
    let tabBarBubble = [ "bubble", "bubbleSelected"]
    
    @State var selectedDrawer: SelectedComponentDrawer = .none

    @ObservedObject var manager: Manager = Manager()
    
    @State var storyPage: StoryPage = StoryPage(backgroundPath: .catalogedAsset(named: "scene-1"), elements: [], history: StoryPageHistory())
    @EnvironmentObject var pageManager: PageManager
    @EnvironmentObject var story: Story

    var body: some View {
        let pageCanvas = PageCanvas(storyPage: $story.pages[pageManager.pageIndex], editable: true)

        NavigationView {
            ZStack {
                
                HStack {
                    Button(action: {
                        //pagina anterior
                        if pageManager.pageIndex == 0 {
                            print("error")
                        } else {
                            pageManager.pageIndex -= 1
                            print(pageManager.pageIndex)
                        }
                        
                    }, label: {
                        Image("previousPage")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 20, height: UIScreen.main.bounds.width / 20, alignment: .center)
                            .padding(.leading, UIScreen.main.bounds.width / 7.5)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        //proxima pagina
                        if pageManager.pageIndex == story.pages.count - 1 {
                            print("error")
                        } else {
                            pageManager.pageIndex += 1
                            print(pageManager.pageIndex)
                        }
                        
                    }, label: {
                        Image("nextPage")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 20, height: UIScreen.main.bounds.width / 20, alignment: .center)
                            .padding(.trailing, UIScreen.main.bounds.width / 90)
                    })
                    
                }
                .padding(.bottom, UIScreen.main.bounds.height / 4.5)
                
                ZStack {
                    
                    switch self.selectedDrawer {
                    
                    case .none:
                        EmptyView()
                        
                    case .personDrawer:
                        ElementDrawer(selectedArray: .array(elements: personArray), storyPage: $story.pages[pageManager.pageIndex])
                        
                    case .objectDrawer:
                        ElementDrawer(selectedArray: .array(elements: objectArray), storyPage: $story.pages[pageManager.pageIndex])
                        
                    case .sceneDrawer:
                        ElementDrawer(selectedArray: .array(elements: sceneArray), storyPage: $story.pages[pageManager.pageIndex], drawerMode: .background)
                        
                    case .bubbleDrawer:
                        ElementDrawer(selectedArray: .array(elements: bubbleArray), storyPage: $story.pages[pageManager.pageIndex], drawerMode: .elementWithOverlaidText)
                        
                    case .challengeDrawer:
                        ChallengesView()
                        
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
                            
                            Image(tabBarObject[selectedDrawer == .objectDrawer ? 1 : 0])
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                                .padding(.init(top: UIScreen.main.bounds.width / 25, leading: 0, bottom: UIScreen.main.bounds.width / 25, trailing: 0))
                                .onTapGesture {
                                    switch self.selectedDrawer {
                                        case .objectDrawer: self.selectedDrawer = .none
                                        default: self.selectedDrawer = .objectDrawer
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
                            
                            Image(tabBarBubble[selectedDrawer == .bubbleDrawer ? 1 : 0])
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width / 14, height: UIScreen.main.bounds.width / 14, alignment: .center)
                                .padding(.init(top: UIScreen.main.bounds.width / 25, leading: 0, bottom: UIScreen.main.bounds.width / 25, trailing: 0))
                                .onTapGesture {
                                    switch self.selectedDrawer {
                                        case .bubbleDrawer: self.selectedDrawer = .none
                                        default: self.selectedDrawer = .bubbleDrawer
                                    }
                                }.padding(.bottom, 8)
                            
                            HStack{
                                Button(action: {
                                    pageCanvas.undo()
                                }, label: {
                                    Image(systemName: "arrow.uturn.left.circle.fill")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.height / 25, height: UIScreen.main.bounds.height / 25, alignment: .center)
                                }).disabled(!pageCanvas.storyPage.history.undoAvailable)
                                .padding(.horizontal, 8.0)
                                
                                Button(action: {
                                    pageCanvas.redo()
                                }, label: {
                                    Image(systemName: "arrow.uturn.right.circle.fill")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.height / 25, height: UIScreen.main.bounds.height / 25, alignment: .center)
                                }).disabled(!pageCanvas.storyPage.history.redoAvailable)
                                .padding(.horizontal, 8.0)
                            }


                            
                        }
                        
                    }
                    .ignoresSafeArea()
                    
                    Spacer()
                    
                    pageCanvas
                        .frame(width: 755, height: 507.34, alignment: .center)
                        .clipped()
                        .padding(.bottom, UIScreen.main.bounds.height / 5)
//                        .padding(.leading, UIScreen.main.bounds.width / 7)
                        
                    Spacer()
 
                }
                
                //VOLTAR PARA OVERVIEW
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        
                    
                    NavigationLink(
                        
                        destination: StoryOverview(),
                        label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color("DarkPurple"))
                                .font(.largeTitle)
                                .onTapGesture {
                                    manager.coverView = false
                                    manager.editorView = false
                                    manager.finishStoryView = false
                                    
                                    presentationMode.wrappedValue.dismiss()
                                    
                                }
                        })
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                        .navigationBarTitle("")
                        
                        Spacer()
                        
                    }.padding(.top, UIScreen.main.bounds.height / 30)
                    
                }.padding(.trailing, UIScreen.main.bounds.width / 60)
                
            }
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
            .background(Theming.gradients.background)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
    
    public enum SelectedComponentDrawer {
        case none
        case personDrawer
        case objectDrawer
        case sceneDrawer
        case bubbleDrawer
        case challengeDrawer
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
        ComponentMenu().environmentObject(PageManager(pageIndex: 0)).environmentObject(Story(title: "", orientation: .landscape, amountOfPages: 8))
    }
}
