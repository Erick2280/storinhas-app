//
//  saveOverlay.swift
//  Storinhas
//
//  Created by Nadia Bordoni on 28/07/21.
//

import SwiftUI

struct saveOverlay: View {
    var body: some View {
            VStack(){
                NavigationLink(
                    destination: ChallengesView(),
                    label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color("DarkPurple"))
                            .font(.largeTitle)
                            //.onTapGesture {
                               // presentationMode.wrappedValue.dismiss()
                            //}
                    })
                    .padding(.leading, UIScreen.main.bounds.width / 2.5)
                    .padding()
                Text("Gostaria de salvar a história?")
                    .font(Theming.fonts.title)
                    .foregroundColor(Color("DarkPurple"))
                HStack(){
                    TextButton(text: .constant("Não Salvar"), style: .secondary, action: {
                        //a historia nao é salva para visualização
                    })
                        .padding()
                    
                    TextButton(text: .constant("    Salvar    "), style: .primary, action: {
                        //a historia fica visualizavel na home e tambem possível de ler
                    })
                        .padding()
                        
                }.padding()
            }.background(Rectangle()
                            .cornerRadius(30)
                            .shadow(radius: 20)
                            .foregroundColor(.white))
                            .padding(50)
                            .clipped()
        }
    
    }

struct saveOverlay_Previews: PreviewProvider {
    static var previews: some View {
        saveOverlay()
    }
}
