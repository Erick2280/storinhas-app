//
//  ElementDrawer.swift
//  Storinhas
//
//  Created by Nadia Bordoni on 20/07/21.
//

import SwiftUI

struct ElementDrawer: View {
    /*
     Array de cada tipo de elemento
     person
     object
     scene
     bubble
     
     func (selectindex) {
     if selecindex = 0 {
     elemento(array pessoa)
     }
     if selecindex = 1 {
     elemento(array object)
     }
     if selecindex = 2 {
     elemento(array scene)
     }
     if selecindex = 3 {
     elemento(array bubble)
     }
     */

    @ObservedObject var manager: Manager = Manager.shared
    
//    @State var selectedArray: SelectedArray = .none
    
    var body: some View {
        /*
         gaveta (array)
         */
        VStack{
            Button(action: {
                manager.selectedArray = .array(elements: manager.personArray)
            }
            , label: {
                Text("Button")
            })
            
            Spacer()
            ZStack(){
                Rectangle()
                    .foregroundColor(.blue)
                    .cornerRadius(20.0)
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 40){
                        
                        if case .array(let elements) = manager.selectedArray {
                            ForEach(0..<elements.count){ num in
                                Image("\(elements[num])")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding(.leading)
                            }
                        }
                        
                        
                    }
                })
                
            }.frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/10, alignment: .center)
            
        }
        
        
        
    }
    
//    enum SelectedArray {
//        case none
//        case array(elements: [String])
//    }
    
}

public class Manager: ObservableObject {
    
    @Published var selectedArray: SelectedArray = .none
    
    static var shared: Manager = Manager()
    
    @Published var personArray = ["persona1-1", "persona1-2", "persona1-3", "persona1-4", "persona2-1", "persona2-2", "persona2-3", "persona2-4", "persona3-1", "persona3-2", "persona3-3","persona3-4", "persona4-1", "persona4-2", "persona4-3","persona4-4", "group-1","group-2","group-3","group-4", "group-5", "group-6", "group-7","group-8", "animals-1", "animals-2", "animals-3", "animals-4", "animals-5", "animals-6", "animals-7", "animals-8", "animals-9", "animals-10"]
    @Published  var objectArray = ["object-1", "object-2", "object-3", "object-4", "object-5", "object-6", "object-7", "object-8", "object-9", "object-10", "object-11", "object-12", "object-13"]
    @Published  var sceneArray = ["scene-1", "scene-2", "scene-3" ]
    
}

public enum SelectedArray {
     case none
     case array(elements: [String])
 }

struct ElementDrawer_Previews: PreviewProvider {
    static var previews: some View {
        ElementDrawer()
        //            .landscape()
    }
}
