//
// ImageViewModel.swift
// Gallery
//
// Created by HarshaHrudhay on 11/08/25.
//

import SwiftUI
import CoreData
import Combine

class ImageViewModel: ObservableObject {

    @Published var images: [ImageItem] = []

    private let context = PersistenceController.shared.container.viewContext

    init() {
        fetchImages()
    }

    func fetchImages() {
        
        let request: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        do {
            let result = try context.fetch(request)
            self.images = result.map { $0.toImageItem() }
        } catch {
            print(" Error fetching: \(error)")
        }
    }

    
    func deleteImage(_ image: ImageItem) {
        
        let request: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", image.id as CVarArg)
        do {
            if let entity = try context.fetch(request).first {
                context.delete(entity)
                saveContext()
            }
        } catch {
            print(" Error deleting image: \(error)")
        }
    }

    private func saveContext() {
        
        do {
            try context.save()
            fetchImages()
        } catch {
            print(" Error saving context: \(error)")
        }
    }


    func addImage(name: String, category: String, imageData: Data? = nil) {
        
        let newImage = ImageEntity(context: context)
        newImage.id = UUID()
        newImage.name = name
        newImage.category = category
        newImage.isFavourite = false
        newImage.imageData = imageData
        saveContext()
        
    }

    func toggleFavorite(for image: ImageItem) {
        
        let request: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", image.id as CVarArg)
        do {
            if let entity = try context.fetch(request).first {
                entity.isFavourite.toggle()
                saveContext()
            }
        } catch {
            print(" Error toggling favorite: \(error)")
        }
        
    }
    
    func addImageFromDevice(uiImage: UIImage, name: String, category: String) {
        
        let newImage = ImageEntity(context: context)
        newImage.id = UUID()
        newImage.name = name
        newImage.category = category
        newImage.isFavourite = false
        if let imageData = uiImage.pngData() {
            newImage.imageData = imageData
        }
        saveContext()
    }
    

    
}
