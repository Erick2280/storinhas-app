//
//  StoryContainer+CoreDataProperties.swift
//  Storinhas
//
//  Created by Erick Almeida on 05/08/21.
//
//

import Foundation
import CoreData


extension StoryContainer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoryContainer> {
        return NSFetchRequest<StoryContainer>(entityName: "StoryContainer")
    }

    @NSManaged public var json: Data?

}

extension StoryContainer : Identifiable {

}
