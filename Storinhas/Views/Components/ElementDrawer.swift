//
//  ElementDrawer.swift
//  Storinhas
//
//  Created by Nadia Bordoni on 20/07/21.
//

import SwiftUI

struct ElementDrawer: View {
    
    var selectedArray: SelectedArray
    @Binding var storyPage: StoryPage
    
    var body: some View {
        
        VStack{
            Spacer()
            ZStack(){
                Rectangle()
                    .foregroundColor(.blue)
                    .cornerRadius(20.0)
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 40){
                        
                        if case .array(let elements) = selectedArray {
                            ForEach(0..<elements.count){ num in
                                Button(action: {
                                    storyPage.elements.append(PageElement(x: 0, y: 0, scale: 0.1, imagePath:.catalogedAsset(named: "\(elements[num])" )) )
                                }, label: {
                                    Image("\(elements[num])")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding(.leading)
                                })
                        }
                        }
                    }
                })
                
            }.frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/10, alignment: .center)
            .padding(.init(top: 0, leading: UIScreen.main.bounds.width / 5, bottom: UIScreen.main.bounds.height / 30, trailing: 0))
            
        }

    }
    
    public enum SelectedArray {
        case none
        case array(elements: [String])
    }

}



struct ElementDrawer_Previews: PreviewProvider {
    static var previews: some View {
        ElementDrawer(selectedArray: .array(elements: ["persona1-1", "persona1-2", "persona1-3", "persona1-4", "persona2-1", "persona2-2", "persona2-3", "persona2-4", "persona3-1", "persona3-2", "persona3-3","persona3-4", "persona4-1", "persona4-2", "persona4-3","persona4-4", "group-1","group-2","group-3","group-4", "group-5", "group-6", "group-7","group-8", "animals-1", "animals-2", "animals-3", "animals-4", "animals-5", "animals-6", "animals-7", "animals-8", "animals-9", "animals-10"]), storyPage: Binding.constant(StoryPage(backgroundPath: nil, elements: [
            PageElement(x: -0.4, y: -0.2, scale: 0.1, imagePath: .catalogedAsset(named: "TestRabbit")),
            PageElement(x: -0.3, y: 0.3, scale: 0.1, imagePath: .catalogedAsset(named: "TestRabbit")),
            PageElement(x: -0.2, y: 0.1, scale: 0.1, imagePath: .catalogedAsset(named: "TestTurtle"))
        ], history: StoryPageHistory())))
        //            .landscape()
    }
}