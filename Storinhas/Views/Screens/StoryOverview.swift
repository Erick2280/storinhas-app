//
//  StoryOverview.swift
//  Storinhas
//
//  Created by Vítor Bárrios Luís de Albuquerque on 27/07/21.
//

import SwiftUI

struct StoryOverview: View {
    
    init(){
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    @ObservedObject var manager: Manager = Manager()
    @EnvironmentObject var pageManager: PageManager
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var story: Story
    @EnvironmentObject var popUpManager: PopUpManager
    @EnvironmentObject var savedStoriesManager: SavedStoriesManager
    
    let layout = [
        
        GridItem(.flexible(), spacing: -UIScreen.main.bounds.height / 4.5), GridItem(.flexible(), spacing: -UIScreen.main.bounds.height / 4.5), GridItem(.flexible(), spacing: -UIScreen.main.bounds.height / 4.5), GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack {
                    
                    Spacer()
                    
                    Group {
                        HStack {
                            
                            //EDITAR CAPA
                            NavigationLink(
                                destination: getDestination(),
                                label: {
                                    ZStack {
                                        Rectangle()
                                            
                                            .frame(width: UIScreen.main.bounds.height / 5, height: UIScreen.main.bounds.width / 5, alignment: .center)
                                            .frame(width: UIScreen.main.bounds.height / 5, height: UIScreen.main.bounds.width / 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            
                                            .foregroundColor(Color.init(red: 225/255, green: 225/255, blue: 225/255))
                                            .border(Color.init(red: 196/255, green: 196/255, blue: 196/255), width: 5)
                                            .cornerRadius(5)
                                        
                                        Image("grayPencil")
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.width / 15, height: UIScreen.main.bounds.width / 15, alignment: .center)
                                            .foregroundColor(Color.init(red: 144/255, green: 144/255, blue: 144/255))
                                            .padding(.bottom, UIScreen.main.bounds.height / 8)
                                        
                                        Text("ACTION_EDIT_COVER")
                                            .font(Theming.fonts.button2)
                                            .foregroundColor(Color.init(red: 144/255, green: 144/255, blue: 144/255))
                                            .tracking(3.0)
                                            .multilineTextAlignment(.center)
                                            .padding(.top, UIScreen.main.bounds.height / 9)
                                    }
                                    
                                    .onTapGesture {
                                        if manager.nextView == false && manager.coverView == false {
                                            manager.nextView = true
                                            manager.coverView = true
                                            
                                            manager.finishStoryView = false
                                            manager.editorView = false
                                            manager.storyOverView = false
                                        } else {
                                            manager.finishStoryView = false
                                            manager.editorView = false
                                            manager.storyOverView = false
                                            
                                            manager.coverView = true
                                            manager.nextView = true
                                        }
                                    }
                                })
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true)
                                .navigationBarTitle("")
                        }
                    }
                    
                    Spacer()
                    
                    //PÁGINAS DA HISTÓRIA
                    Group {
                        LazyVGrid(columns: layout, spacing: UIScreen.main.bounds.height / 20) {
                            
                            ForEach(Array(zip(story.pages.indices, story.pages)), id: \.0) { index, page in
                                HStack(alignment: .center, spacing: UIScreen.main.bounds.width) {
                                    
                                    NavigationLink(
                                        destination: getDestination(),
                                        label: {
                                            ZStack {
                                                Rectangle()
                                                    .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.height / 6, alignment: .center)
                                                    .foregroundColor(.white)
                                                
                                                
                                                PageCanvas(storyPage: $story.pages[index], editable: false)
                                                    .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.height / 6, alignment: .center)
                                                    .padding(.trailing, UIScreen.main.bounds.width / 60)
                                                
                                                Button(action: {
                                                    print("alou meu bom")
                                                    
                                                    pageManager.pageIndex = index
                                                    if manager.nextView == false && manager.editorView == false {
                                                        manager.nextView = true
                                                        manager.editorView = true
                                                        
                                                        manager.finishStoryView = false
                                                        manager.coverView = false
                                                        manager.storyOverView = false
                                                    } else {
                                                        manager.editorView = true
                                                        manager.nextView = true
                                                        
                                                        manager.finishStoryView = false
                                                        manager.coverView = false
                                                        manager.storyOverView = false
                                                    }
                                                }, label: {
                                                    Image("")
                                                        .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.height / 6, alignment: .center)
                                                    
                                                    
                                                })
                                                
                                            }
                                        })
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    //BOTÃO FINALIZAR HISTÓRIA
                    NavigationLink(
                        destination: getDestination(),
                        label: {
                            TextButton(text: Binding.constant("ACTION_FINISH_STORY"), style: .primary, action: {
                                if manager.nextView == false && manager.finishStoryView == false {
                                    manager.nextView = true
                                    manager.finishStoryView = true
                                    
                                    manager.coverView = false
                                    manager.editorView = false
                                    manager.storyOverView = false
                                    
                                } else if manager.nextView == false && manager.finishStoryView == false && savedStoriesManager.noStoriesSaved == true {
                                    savedStoriesManager.noStoriesSaved = false

                                        manager.nextView = true
                                        manager.finishStoryView = true
                                        
                                        manager.coverView = false
                                        manager.editorView = false
                                        manager.storyOverView = false
                                    } else {
                                        
                                        manager.coverView = false
                                        manager.editorView = false
                                        manager.storyOverView = false
                                        
                                        manager.finishStoryView = true
                                        manager.nextView = true
                                        
                                    }
                                })
                                
                            })
                            
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true)
                            .navigationBarTitle("")
                            
                            Spacer()
                            
                        }
                        
                        //SAIR DO EDITOR
                        HStack {
                            
                            Spacer()
                            
                            VStack {
                                
                                NavigationLink(
                                    
                                    destination: getDestination(),
                                    label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(Color("DarkPurple"))
                                            .font(.largeTitle)
                                            .onTapGesture {
                                                
                                                popUpManager.showPopUp = true
                                                //                                        presentationMode.wrappedValue.dismiss()
                                            }
                                    })
                                    .navigationBarBackButtonHidden(true)
                                    .navigationBarHidden(true)
                                    .navigationBarTitle("")
                                
                                Spacer()
                                
                            }.padding(.top, UIScreen.main.bounds.height / 30)
                        }.padding(.trailing, UIScreen.main.bounds.width / 40)
                    
                    if popUpManager.showPopUp == true {
                        saveOverlay(manager: Manager())
                        
                        }
                }
                .statusBar(hidden: true)
                .background(Theming.gradients.background)
                .ignoresSafeArea()
                .onAppear(perform: {
                    popUpManager.showPopUp = false
                })
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .fullScreenCover(isPresented: $manager.nextView, content: {
                getDestination()
                
            })
        }
        
        func getDestination() -> AnyView {
            
            if manager.coverView == true {
                return AnyView(CoverMenu())
            } else if manager.editorView == true {
                return AnyView(ComponentMenu(pageManager: _pageManager, story: _story))
            } else if manager.finishStoryView == true {
                return AnyView(TabBarView(selectedIndex: 1, bookToggle: 1, pencilToggle: 0, crownToggle: 0, tabBarToggle: 0))
            } else {
                return AnyView(StoryOverview())
            }
            
        }
        
    }
    
    class Manager: ObservableObject {
        
        @Published var nextView: Bool = false
        @Published var coverView: Bool = false
        @Published var editorView: Bool = false
        @Published var finishStoryView: Bool = false
        @Published var storyOverView: Bool = false
    }
    
    struct StoryOverview_Previews: PreviewProvider {
        
        static var previews: some View {
            StoryOverview().environmentObject(PageManager(pageIndex: 0)).environmentObject(Story(title: "", orientation: .landscape, amountOfPages: 8)).environmentObject(PopUpManager(showPopUp: false)).environmentObject(SavedStoriesManager(noStoriesSaved: true))
        }
    }
