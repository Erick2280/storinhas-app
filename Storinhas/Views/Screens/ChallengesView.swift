//
//  ChallengesView.swift
//  Storinhas
//
//  Created by Erick Almeida on 08/07/21.
//

import SwiftUI

struct ChallengesView: View {
    
    @ObservedObject var manager: Manager = Manager()

    let data = Array(1...10)
    
    let layout = [
        
        GridItem(.flexible(), spacing: UIScreen.main.bounds.height / 6.8), GridItem(.flexible())
    ]
    
    var body: some View {
        
        
        NavigationView {
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: UIScreen.main.bounds.height / 17) {
                
                
                NavigationLink(
                    destination: getDestination(),
                    label: {
                        DailyChallengeButton(imagemPersonagem: "Coelhinho")
                    })
                
                Spacer()
                
                LazyHGrid(rows: layout, spacing: UIScreen.main.bounds.height / 25) {
                    
                    ForEach(data, id: \.self) { item in
                        HStack(alignment: .center, spacing: UIScreen.main.bounds.height / 25) {

                            Rectangle()
                                .frame(width: UIScreen.main.bounds.height / 8.2, height: UIScreen.main.bounds.height / 8.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(20)
                            
                        }
                        
                    }
                    
                    Spacer()
                }
                .padding(.init(top: 0, leading: UIScreen.main.bounds.width / 15, bottom: UIScreen.main.bounds.width / 11, trailing: 0))

                Spacer()
            }
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        
        
        
    }
    
    func getDestination() -> AnyView {
        return AnyView(ChallengeDetailsView())
    }
    
}

class Manager: ObservableObject {
    @Published var nextView: Bool = false

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


struct ChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesView()
            .landscape()
    }
}
