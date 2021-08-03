//
//  ComponentMenu.swift
//  Storinhas
//
//  Created by Nadia Bordoni on 19/07/21.
//

import SwiftUI

struct ComponentMenu: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let personArray = ["persona1-1", "persona1-2", "persona1-3", "persona1-4", "persona2-1", "persona2-2", "persona2-3", "persona2-4", "persona3-1", "persona3-2", "persona3-3","persona3-4", "persona4-1", "persona4-2", "persona4-3","persona4-4", "group-1","group-2","group-3","group-4", "group-5", "group-6", "group-7","group-8", "animals-1", "animals-2", "animals-3", "animals-4", "animals-5", "animals-6", "animals-7", "animals-8", "animals-9", "animals-10"]
    let objectArray = ["object-1", "object-2", "object-3", "object-4", "object-5", "object-6", "object-7", "object-8", "object-9", "object-10", "object-11", "object-12", "object-13"]
    let sceneArray = ["scene-1", "scene-2", "scene-3" ]
    //let bubbleArray = []
    
    let tabBarPerson = ["person", "personSelected"]
    let tabBarObject = ["object", "objectSelected"]
    let tabBarScene = ["scene", "sceneSelected"]
    let tabBarBubble = [ "bubble", "bubbleSelected"]
    
    @EnvironmentObject var pageManager: PageManager
    @EnvironmentObject var story: Story
 
    @State var selectedIndex = 0
    @State var personToggle = 0
    @State var objectToggle = 0
    @State var sceneToggle = 0
    @State var bubbleToggle = 0

    @State var storyPage: StoryPage = StoryPage(backgroundPath: .catalogedAsset(named: "scene-1"), elements: [PageElement(x: -0.4, y: -0.2, scale: 0.1, imagePath: .catalogedAsset(named: "TestRabbit")),PageElement(x: -0.3, y: 0.3, scale: 0.1, imagePath: .catalogedAsset(named: "TestRabbit")),PageElement(x: -0.2, y: 0.1, scale: 0.1, imagePath: .catalogedAsset(named: "TestTurtle"))], history: StoryPageHistory())
    
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack {

                ZStack {
                    
                    switch selectedIndex {
                    
                    case 0:
                        //nada selecionado
                        Text("")
                        
                    case 1:
                        //person
                        ElementDrawer(selectedArray: .array(elements: personArray), storyPage: $story.pages[pageManager.pageIndex])
                        
                    case 2:
                        //object
                        ElementDrawer(selectedArray: .array(elements: objectArray), storyPage: $story.pages[pageManager.pageIndex])
                        
                        
                        
                    case 3:
                        //Scene
                        ElementDrawer(selectedArray: .array(elements: sceneArray), storyPage: $story.pages[pageManager.pageIndex])
                        
                        
                        
                    case 4:
                        //bubble
                        ElementDrawer(selectedArray: .array(elements: personArray), storyPage: $story.pages[pageManager.pageIndex])
                        
                        
                    default:
                        //Person
                        Text("")
                        
                    }
                    
                }
                
                
                HStack {
                    
                    ZStack {
                        
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width / 8, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .cornerRadius(30, corners: [.topRight, .bottomRight])
                            .shadow(radius: 15)
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

                        }.padding(.bottom, 100)
    
                    }
                    .ignoresSafeArea()

                    Spacer()
                                      
                    PageCanvas(storyPage: $story.pages[pageManager.pageIndex], editable: true)
                        .frame(width: 500, height: 500, alignment: .center)
                        .padding(.bottom, UIScreen.main.bounds.height / 7)
                    
                    Spacer(minLength: UIScreen.main.bounds.width / 3.2)

                }
                
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
                            .padding(.leading, UIScreen.main.bounds.width / 7.3)
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
                            .padding(.trailing, UIScreen.main.bounds.width / 80)
                    })
                    
                }
                .padding(.bottom, UIScreen.main.bounds.height / 7)
                
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
                                    presentationMode.wrappedValue.dismiss()
                                    
                                }
                        })
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                        .navigationBarTitle("")
                        
                        Spacer()
                        
                    }.padding(.top, UIScreen.main.bounds.height / 15)
                    
                }.padding(.trailing, UIScreen.main.bounds.width / 40)
                
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        
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
