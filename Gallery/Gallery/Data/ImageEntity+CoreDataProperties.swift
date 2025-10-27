//
// ImageEntity+CoreDataProperties.swift
// Gallery
//
// Created by HarshaHrudhay on 11/08/25.
//

import Foundation
import CoreData

extension ImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var name: String?
    @NSManaged public var imageData: Data?

}

extension ImageEntity : Identifiable {

}
