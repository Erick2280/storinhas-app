//
//  editOverlay.swift
//  Storinhas
//
//  Created by Nadia Bordoni on 30/07/21.
//

import SwiftUI

struct editOverlay: View {
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
            Text("Quer editar esta história?")
                .font(Theming.fonts.title)
                .foregroundColor(Color("DarkPurple"))
            HStack(){
                TextButton(text: .constant("Continuar lendo"), style: .secondary, action: {
                    //a historia nao é salva para visualização
                })
                .padding()
                
                TextButton(text: .constant("Ir para o editor"), style: .primary, action: {
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


struct editOverlay_Previews: PreviewProvider {
    static var previews: some View {
        editOverlay()
    }
}
