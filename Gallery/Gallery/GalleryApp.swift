//
//  GalleryApp.swift
//  Gallery
//
//  Created by HarshaHrudhay on 27/10/25.
//

import SwiftUI
import CoreData

@main
struct GalleryApp: App {
    
    let persistenceController = PersistenceController.shared
    @StateObject var viewModel = ImageViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewModel)
        }
    }
}
