//
// ImageModel.swift
// Gallery
//
// Created by HarshaHrudhay on 11/08/25.
//

import Foundation
import CoreData
import SwiftUI

struct ImageItem: Identifiable {
    
    var id: UUID
    var name: String
    var category: String
    var isFavorite: Bool
    var imageData: Data?
    
    var uiImage: UIImage? {
        if let data = imageData {
            return UIImage(data: data)
        }
        return nil
    }

}

extension ImageEntity {
    
    func toImageItem() -> ImageItem {
        
        ImageItem(
            id: self.id ?? UUID(),
            name: self.name ?? "",
            category: self.category ?? "",
            isFavorite: self.isFavourite,
            imageData: self.imageData
        )
    }
}


