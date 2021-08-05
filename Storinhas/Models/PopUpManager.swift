//
//  PopUpManager.swift
//  Storinhas
//
//  Created by Vítor Bárrios Luís de Albuquerque on 04/08/21.
//

import Foundation

class PopUpManager: ObservableObject {
    @Published var showPopUp: Bool
    
    init(showPopUp: Bool) {
        self.showPopUp = false
    }
}

class SavedStoriesManager: ObservableObject {
    
    @Published var noStoriesSaved: Bool
    
    init(noStoriesSaved: Bool) {
        self.noStoriesSaved = true
    }
}
