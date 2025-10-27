//
//  ImageAddView.swift
//  Gallery
//
//  Created by HarshaHrudhay on 11/08/25.
//

import SwiftUI
import PhotosUI

struct ImageAddView: View {
    
    @EnvironmentObject var viewModel: ImageViewModel
    @Environment(\.dismiss) var dismiss

    @State private var searchText = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedUIImage: UIImage? = nil
    @State private var customName: String = ""

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    let allImages = [
        "landscape1", "landscape2", "landscape3", "landscape4", "landscape5",
        "food1", "food2", "food3", "food4", "food5",
        "car1", "car2", "car3",
        "animals1", "animals2", "animals3", "animals4", "animals5"
    ]

    var filteredImages: [String] {
        if searchText.isEmpty {
            return allImages
        } else {
            return allImages.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [Color.bgcolor, Color.bgcolor2], startPoint: .bottomLeading, endPoint: .topLeading)
                .ignoresSafeArea()

            VStack(spacing: 10) {
                
                
                HStack {
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.iconbg)
                    TextField("Search by category or name", text: $searchText)
                        .foregroundStyle(Color.black)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.vertical, 8)
//                        .padding(.top, 20)
                    
                }
                
                .padding(.horizontal)
                .background(Color.white.opacity(0.15))
                .cornerRadius(10)
                .padding(.top, 10)
                .padding(.horizontal)
//                .padding(.bottom, 10)

               
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    
                    Text("Upload from Device")
                    
                        .foregroundColor(.bgcolor2)
                        .frame(width: 350, height: 25)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.bgcolor.opacity(0.8))
                        .cornerRadius(8)
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            selectedUIImage = uiImage
                        }
                    }
                }
                
                if let uiImage = selectedUIImage {
                    
                    VStack(spacing: 12) {
                        
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(12)

                        TextField("Enter image name", text: $customName)
                            .padding()
                            .textFieldStyle(PlainTextFieldStyle())
                            .background(Color.white.opacity(0.2))
//                            .cornerRadius(8)
                            
                            .foregroundColor(.white)

                        Button("Save Image") {
                            
                            if !customName.trimmingCharacters(in: .whitespaces).isEmpty {
                                viewModel.addImageFromDevice(uiImage: uiImage, name: customName, category: "Custom")
                                selectedUIImage = nil
                                customName = ""
                                dismiss()
                                
                            }
                        }
                        
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color.bgcolor2.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        
                    }
                    
                    .padding()
                    
                }
                
                
                
                ScrollView {
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        ForEach(filteredImages, id: \.self) { imageName in
                            
                            VStack {
                                
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                                    .cornerRadius(12)

                                Text(imageName)
                                    .foregroundColor(.white)
                                    .font(.caption)
                                    .padding(.top, 4)
                            }
                            
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(12)
                            .padding(4)
                            .onTapGesture {
                                let category = detectCategory(from: imageName)
                                viewModel.addImage(name: imageName, category: category)
                                dismiss()
                            }
                            
                        }
                    }
                    .padding()
                }
            }
        }
    }

    func detectCategory(from imageName: String) -> String {
        if imageName.lowercased().contains("landscape") { return "Landscape" }
        if imageName.lowercased().contains("food") { return "Food" }
        if imageName.lowercased().contains("car") { return "Car" }
        if imageName.lowercased().contains("animals") { return "Animals" }
        return "Unknown"
    }
}

#Preview {
    ImageAddView()
}



struct ImageGridItemView: View {
    let imageName: String
    let onTap: () -> Void

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(height: 150)
            .clipped()
            .background(Color.white.opacity(0.2))
            .cornerRadius(12)
            .padding(4)
            .onTapGesture {
                onTap()
            }
    }
}



//LazyVGrid(columns: columns, spacing: 20) {
//    ForEach(filteredImages, id: \.self) { imageName in
//        Image(imageName)
//            .resizable()
//            .scaledToFit()
//            .frame(height: 150)
//            .clipped()
//            .background(Color.white.opacity(0.2))
//            .cornerRadius(12)
//            .padding(4)
//            .onTapGesture {
//                let category = detectCategory(from: imageName)
//                viewModel.addImage(name: imageName, category: category, imageData: nil)
//                dismiss()
//            }
//    }
//}
//.padding()
