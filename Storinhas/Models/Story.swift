//
//  Story.swift
//  Storinhas
//
//  Created by Erick Almeida on 12/07/21.
//

import Foundation
import CoreData
import SwiftUI

class StoriesManager: ObservableObject {
    var persistentContainer: NSPersistentContainer = {

          let container = NSPersistentContainer(name: "Storinhas")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()
    @Published var stories: [Story] = []
    
    func fetch() {
        do {
            if let storiesContainer = try self.persistentContainer.viewContext.fetch(StoryContainer.fetchRequest()) as? [StoryContainer] {
                for storyContainer in storiesContainer {
                    stories.append(try! JSONDecoder().decode(Story.self, from: storyContainer.json!))
                }
            }
        } catch {}
    }
    
    func update() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StoryContainer")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                persistentContainer.viewContext.delete(objectData)
            }
            
            for story in stories {
                let storyContainer: StoryContainer = StoryContainer(context: persistentContainer.viewContext)
                storyContainer.json = try! JSONEncoder().encode(story)
                try! persistentContainer.viewContext.save()
            }
        } catch {}
    }
}

class Story: ObservableObject, Codable {
    @Published var status: StoryStatus
    @Published var pages: [StoryPage]
    @Published var orientation: StoryOrientation
    @Published var title: String
    
    init(title: String, orientation: StoryOrientation, amountOfPages: Int = 0) {
        self.status = .editing
        self.pages = []
        self.orientation = .landscape
        self.title = title
        
        for _ in 0..<amountOfPages {
            let history = StoryPageHistory()
            let element = StoryPage(backgroundPath: nil, elements: [], history: history)
            element.history.backup(element)
            pages.append(element)
        }
    }
    
    func reset(title: String = "", orientation: StoryOrientation = .landscape, amountOfPages: Int = 8) {
        self.status = .editing
        self.pages = []
        self.orientation = .landscape
        self.title = title
        
        for _ in 0..<amountOfPages {
            let history = StoryPageHistory()
            let element = StoryPage(backgroundPath: nil, elements: [], history: history)
            element.history.backup(element)
            pages.append(element)
        }
    }
    
    enum CodingKeys: CodingKey {
        case status, pages, orientation, title
    }
     
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.pages, forKey: .pages)
        try container.encode(self.orientation, forKey: .orientation)
        try container.encode(self.title, forKey: .title)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(StoryStatus.self, forKey: .status)
        self.pages = try container.decode([StoryPage].self, forKey: .pages)
        self.orientation = try container.decode(StoryOrientation.self, forKey: .orientation)
        self.title = try container.decode(String.self, forKey: .title)
    }
}

struct StoryPage: Codable {
    var backgroundPath: ImagePath?
    var elements: [PageElement]
    var history: StoryPageHistory

    enum CodingKeys: CodingKey {
        case backgroundPath, elements
    }
     
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.backgroundPath, forKey: .backgroundPath)
        try container.encode(self.elements, forKey: .elements)
    }
    
    init(backgroundPath: ImagePath?, elements: [PageElement], history: StoryPageHistory) {
        self.backgroundPath = backgroundPath
        self.elements = elements
        self.history = history
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.backgroundPath = try container.decode(ImagePath?.self, forKey: .backgroundPath)
        self.elements = try container.decode([PageElement].self, forKey: .elements)
        self.history = StoryPageHistory()
    }
}

class PageManager: ObservableObject {
    
    @Published var pageIndex: Int
    
    init(pageIndex: Int) {
        self.pageIndex = 0
    }

}

class StoryPageHistory: ObservableObject, Codable {
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

struct PageElement: Codable {
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

enum ImagePath: Equatable, Hashable, Codable {
    case catalogedAsset(named: String)
    case catalogedAssetWithOverlaidText(named: String, overlaidText: String)
    case externalImage(uiImage: UIImage)
    
    enum CodingKeys: CodingKey {
        case catalogedAsset, catalogedAssetWithOverlaidText, externalImage
    }
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            switch self {
            case .catalogedAsset(let name):
                try container.encode(name, forKey: .catalogedAsset)
            case .catalogedAssetWithOverlaidText(let name, let overlaidText):
                var nestedContainer = container.nestedUnkeyedContainer(forKey: .catalogedAssetWithOverlaidText)
                try nestedContainer.encode(name)
                try nestedContainer.encode(overlaidText)
            case .externalImage(let uiImage):
                try container.encode(uiImage, forKey: .catalogedAsset)
            }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let key = container.allKeys.first
        
        switch key {
        case .catalogedAsset:
            let name = try container.decode(String.self, forKey: .catalogedAsset)
            self = .catalogedAsset(named: name)
        case .catalogedAssetWithOverlaidText:
            var nestedContainer = try container.nestedUnkeyedContainer(forKey: .catalogedAssetWithOverlaidText)
            let name = try nestedContainer.decode(String.self)
            let overlaidText = try nestedContainer.decode(String.self)
            self = .catalogedAssetWithOverlaidText(named: name, overlaidText: overlaidText)
        case .externalImage:
            let uiImage = try container.decode(UIImage.self, forKey: .externalImage)
            self = .externalImage(uiImage: uiImage)
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode enum."
                )
            )
        }
    }
}

enum StoryStatus: String, Codable {
    case editing, draft, published
}

enum StoryOrientation: String, Codable {
    case portrait, landscape
}

enum ImageEncodingQuality {
  case png
  case jpeg(quality: CGFloat)
}

extension KeyedEncodingContainer {
    mutating func encode(
        _ value: UIImage,
        forKey key: KeyedEncodingContainer.Key,
        quality: ImageEncodingQuality = .png
    ) throws {
        let imageData: Data?
        switch quality {
        case .png:
            imageData = value.pngData()
        case .jpeg(let quality):
            imageData = value.jpegData(compressionQuality: quality)
        }
        guard let data = imageData else {
            throw EncodingError.invalidValue(
                value,
                EncodingError.Context(codingPath: [key], debugDescription: "Failed convert UIImage to data")
            )
        }
        try encode(data, forKey: key)
    }
}

extension KeyedDecodingContainer {
    func decode(
        _ type: UIImage.Type,
        forKey key: KeyedDecodingContainer.Key
    ) throws -> UIImage {
        let imageData = try decode(Data.self, forKey: key)
        if let image = UIImage(data: imageData) {
            return image
        } else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [key], debugDescription: "Failed load UIImage from decoded data")
            )
        }
    }
}
