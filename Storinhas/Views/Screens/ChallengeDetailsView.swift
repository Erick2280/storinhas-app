//
//  ChallengeDetailsView.swift
//  Storinhas
//
//  Created by Vítor Bárrios Luís de Albuquerque on 13/07/21.
//

import SwiftUI

struct ChallengeDetailsView: View {
    var body: some View {
       
        NavigationView {
            
            ZStack {
                
                
                
                VStack {
                    
                    Text("CHALLENGES_DAILYCHALLENGE")
                        .font(Theming.fonts.title)
                        .foregroundColor(Color("DarkPurple"))
                        .tracking(3)
                    
                    
                    ZStack {
                        
                        Rectangle()
                            .fill(Theming.gradients.sunrise)
                            .cornerRadius(30)
                        
                        VStack {
                            
                            Spacer(minLength: UIScreen.main.bounds.height / 20)
                            
                            Text("CHALLENGES_DAILYCHALLENGETITLE")
                                .font(Theming.fonts.body.bold())
                                .foregroundColor(.white)
                            
                            Spacer(minLength: UIScreen.main.bounds.height / 30)
                            
                            Text("CHALLENGES_WARNING")
                                .font(.custom("SF-Pro-Rounded-Regular", size: 20))
                                .foregroundColor(.white)
                            
                            Spacer(minLength: UIScreen.main.bounds.height / 30)
                            
                            VStack(alignment: .leading, spacing: UIScreen.main.bounds.height / 200, content: {
                                
                                HStack {
                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.height / 30, height: UIScreen.main.bounds.height / 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding()
                                    
                                    Text("CHALLENGE_REQUIREMENT1")
                                        .font(.custom("SF-Pro-Rounded-Regular", size: 20))
                                        .foregroundColor(.white)
                                    
                                }
                                
                                HStack {
                                    
                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.height / 30, height: UIScreen.main.bounds.height / 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding()
                                    
                                    Text("CHALLENGE_REQUIREMENT2")
                                        .font(.custom("SF-Pro-Rounded-Regular", size: 20))
                                        .foregroundColor(.white)
                                    
                                }
                                
                                HStack {
                                    
                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.height / 30, height: UIScreen.main.bounds.height / 30, alignment: .center)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .padding()
                                    
                                    Text("CHALLENGE_REQUIREMENT3")
                                        .font(.custom("SF-Pro-Rounded-Regular", size: 20))
                                        .foregroundColor(.white)
                                    
                                }
                                
                                
                            })
                            
                            Spacer(minLength: 80)
                         
                            
                            
                        }
                        
                        
                        
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.height / 3, alignment: .center)
                    
                    .padding(.vertical, UIScreen.main.bounds.height / 15)
                    
                    TextButton(text: Binding.constant("ACTION_START"), style: .primary)
                        .padding(.bottom, UIScreen.main.bounds.height / 15)
                    

                    
                    
                }
                
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color("DarkPurple"))
                    .font(.largeTitle)
                    .padding(.init(top: 0, leading: UIScreen.main.bounds.width / 0.75, bottom: UIScreen.main.bounds.height / 1.4, trailing: 0))
                
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
       
    }
}



struct ChallengeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeDetailsView()
            .landscape()
    }
}
