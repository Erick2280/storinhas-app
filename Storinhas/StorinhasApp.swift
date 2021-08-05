//
//  StorinhasApp.swift
//  Storinhas
//
//  Created by Erick Almeida on 08/07/21.
//

import SwiftUI

@main
struct StorinhasApp: App {
    var story: Story = Story(title: "", orientation: .landscape, amountOfPages: 8)
    var pageManager: PageManager = PageManager(pageIndex: 0)
    var popUpManager: PopUpManager = PopUpManager(showPopUp: false)
    var savedStoriesManager: SavedStoriesManager  = SavedStoriesManager(noStoriesSaved: true)
    
    var body: some Scene {
        WindowGroup {

            TabBarView().environmentObject(pageManager).environmentObject(story).environmentObject(popUpManager).environmentObject(savedStoriesManager)

        }
    }
}
