//
// ImageUploadView.swift
// Gallery
//
// Created by HarshaHrudhay on 12/08/25.
//

import SwiftUI
import PhotosUI

struct ImageUploadView: View {

    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var imageData: Data?

    @EnvironmentObject var viewModel: ImageViewModel
    @Environment(\.dismiss) var dismiss

    @State private var imageName = ""
    @State private var selectedCategory = "Education"

    let categories = ["Landscape", "Portrait", "Travel", "Education", "Shopping"]

    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                LinearGradient(colors: [Color.bgcolor, Color.bgcolor2], startPoint: .bottomLeading, endPoint: .topLeading)
                    .ignoresSafeArea()

                VStack {
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                        
                    }
                    
                    .pickerStyle(.automatic)
                    .padding()

                    PhotosPicker("Select Image", selection: $avatarItem, matching: .images)
                    
                        .onChange(of: avatarItem) { newItem in
                            Task {
                                if let item = newItem, let loadedImage = try? await item.loadTransferable(type: Data.self) {
                                    imageData = loadedImage
                                    if let uiImage = UIImage(data: loadedImage) {
                                        avatarImage = Image(uiImage: uiImage)
                                    }
                                    
                                } else {
                                    print("Failed to load image")
                                }
                            }
                        }
                        .padding()

                    if let avatarImage = avatarImage {
                        
                        avatarImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
//                            .clipShape(Circle())
                            .padding()
                        
                    }

                    TextField("Enter Image Name", text: $imageName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300, height: 50)
                        .padding(.horizontal, 50)

                    Button(action: {
                        
                        if let imageData = imageData, !imageName.isEmpty {
                            viewModel.addImage(name: imageName, category: selectedCategory, imageData: imageData)
                            dismiss()
                            
                        } else {
                            
                            print("Please select an image and provide a name.")
                            
                        }
                    }) {
                        
                        Text("Save Image")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(imageData != nil && !imageName.isEmpty ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                    }
                    .padding(.horizontal, 50)
                    .disabled(imageData == nil || imageName.isEmpty)

                    Spacer()
                }
                
                .padding(.vertical, 50)
                .navigationTitle("Add Image")
                
//                .navigationBarBackButtonHidden(true)
                
            }
        }
    }
}

#Preview {
    ImageUploadView()
}
