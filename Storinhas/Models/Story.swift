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
    var history: StoryPageHistory
}

class StoryPageHistory {
    var undoStoryPages: [StoryPage]
    var redoStoryPages: [StoryPage]
    var undoAvailable: Bool
    var redoAvailable: Bool
    
    init() {
        self.undoStoryPages = []
        self.redoStoryPages = []
        self.undoAvailable = false
        self.redoAvailable = false
    }
    
    func backup(_ storyPage: StoryPage) {
        undoStoryPages.append(storyPage)
        
        if (undoStoryPages.count > 16) {
            undoStoryPages.removeFirst()
        }
        
        self.redoStoryPages = []
        updateAvailability()
    }
    
    func undo() -> StoryPage? {
        if !undoAvailable { return nil }
        
        self.redoStoryPages.append(undoStoryPages.popLast()!)

        if (redoStoryPages.count > 16) {
            redoStoryPages.removeFirst()
        }

        let undoneStoryPage = undoStoryPages.last
        
        updateAvailability()
        return undoneStoryPage
    }
    
    func redo() -> StoryPage? {
        if !redoAvailable { return nil }
        
        self.undoStoryPages.append(redoStoryPages.popLast()!)
        
        if (undoStoryPages.count > 16) {
            undoStoryPages.removeFirst()
        }
        
        let redoneStoryPage = undoStoryPages.last
        
        updateAvailability()
        return redoneStoryPage
    }
    
    func updateAvailability() {
        if (self.undoStoryPages.count > 1) {
            self.undoAvailable = true
        } else {
            self.undoAvailable = false
        }
        
        if (self.redoStoryPages.count > 0) {
            self.redoAvailable = true
        } else {
            self.redoAvailable = false
        }
    }
}

struct PageElement {
    var x: Double
    var y: Double
    var scale: Double
    var horizontalFlip: Bool = false
    var imagePath: ImagePath
    
    mutating func saveTranslationOffset(x: Double, y: Double) {
        self.x += x
        self.y += y
    }
    
    mutating func saveScaleMultiplier(scaleMultiplier: Double) {
        self.scale *= scaleMultiplier
    }
    
    mutating func toggleHorizontalFlip() {
        self.horizontalFlip = !self.horizontalFlip
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
