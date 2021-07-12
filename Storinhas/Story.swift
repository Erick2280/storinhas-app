//
//  Story.swift
//  Storinhas
//
//  Created by Erick Almeida on 12/07/21.
//

import Foundation

class Story {
    var status: StoryStatus
    var pages: [StoryPage]
    var orientation: StoryOrientation
    var title: String
    
    init(title: String, orientation: StoryOrientation) {
        self.status = .editing
        self.pages = []
        self.orientation = .landscape
        self.title = title
    }
}

struct StoryPage {
    var background: BackgroundImage
    var elements: [PageElement]
}

struct PageElement {
    var x: Double
    var y: Double
    var image: ElementImage
}

enum BackgroundImage {
    
}

enum ElementImage {
    
}

enum StoryStatus {
    case editing, draft, published
}

enum StoryOrientation {
    case portrait, landscape
}

