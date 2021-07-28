//
//  saveOverlay.swift
//  Storinhas
//
//  Created by Nadia Bordoni on 28/07/21.
//

import SwiftUI

struct saveOverlay: View {
    var body: some View {
        ZStack(){
            Rectangle()
                .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height/5, alignment: .center)
                .cornerRadius(30)
                .shadow(radius: 20)
                .foregroundColor(.white)

            
            VStack(){
                Text("Gostaria de salvar a história?")
                    .font(Theming.fonts.title)
                    .foregroundColor(Color("DarkPurple"))
                HStack(){
                    TextButton(text: .constant("Não Salvar"), style: .secondary, action: {})
                        .padding()
                    
                    TextButton(text: .constant("   Salvar   "), style: .primary, action: {})
                        .padding()
                        
                }.padding(0)
            }
            
        }
    
    }
}

struct saveOverlay_Previews: PreviewProvider {
    static var previews: some View {
        saveOverlay()
    }
}
