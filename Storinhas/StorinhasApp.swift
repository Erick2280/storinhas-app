//
//  StorinhasApp.swift
//  Storinhas
//
//  Created by Erick Almeida on 08/07/21.
//

import SwiftUI

@main
struct StorinhasApp: App {
    
    var pageManager: PageManager = PageManager(pageIndex: 0)
    
    var body: some Scene {
        WindowGroup {
            StoryOverview().environmentObject(pageManager)
        }
    }
}
