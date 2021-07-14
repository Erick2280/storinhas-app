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
    var backgroundPath: ImagePath?
    var elements: [PageElement]
}

struct PageElement {
    var x: Double
    var y: Double
    var scale: Double
    var imagePath: ImagePath
    
    mutating func saveOffset(x: Double, y: Double) {
        self.x += x
        self.y += y
    }
}

extension PageElement: Hashable {
    static func == (lhs: PageElement, rhs: PageElement) -> Bool {
        return
            lhs.x == rhs.x &&
            lhs.y == rhs.y &&
            lhs.scale == rhs.scale &&
            lhs.imagePath == rhs.imagePath
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(scale)
        hasher.combine(imagePath)
    }
}

enum ImagePath: Equatable, Hashable {
    case catalogedAsset(named: String)
}

enum StoryStatus {
    case editing, draft, published
}

enum StoryOrientation {
    case portrait, landscape
}

