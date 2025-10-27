//
// FavouriteView.swift
// Gallery
//
// Created by HarshaHrudhay on 11/08/25.
//

import SwiftUI

struct FavouriteView: View {

    @EnvironmentObject var viewModel: ImageViewModel

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var favorites: [ImageItem] {
        viewModel.images.filter { $0.isFavorite }
    }

    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                LinearGradient(colors: [Color.bgcolor, Color.bgcolor2], startPoint: .bottomLeading, endPoint: .topLeading)
                    .ignoresSafeArea()

                ScrollView {
                    
                    if favorites.isEmpty {
                        
                        VStack {
                            
                            Spacer()
                            Text("No Favourites Yet")
                                .foregroundColor(.white)
                                .padding()
                            Spacer()
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    } else {
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            
                            ForEach(favorites) { image in
                                
                                ZStack(alignment: .topTrailing) {
                                    
                                    VStack(spacing: 8) {
                                        
//                                        Link("hello",
//                                             destination: URL(string: "https://apple.com")!)
//                                        .buttonStyle(.bordered)
//                                        .buttonBorderShape(.roundedRectangle)
//                                        .controlSize(.regular)
                                        
                                        if let data = image.imageData, let uiImage = UIImage(data: data) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 150)
                                                .clipped()
                                                .cornerRadius(12)
                                            
                                        } else {
                                            
                                            Image(image.name)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 150)
                                                .clipped()
                                                .cornerRadius(12)
                                        }

                                        Text(image.name)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                        
                                    }
                                    
                                    .padding(4)
                                    .background(LinearGradient(colors: [Color.bgcolor2, Color.bgcolor], startPoint: .bottomLeading, endPoint: .topLeading).opacity(0.6))
                                    .cornerRadius(12)

                                    Button(action: {
                                        
                                        
                                        viewModel.deleteImage(image)
                                        
                                    }) {
                                        
                                        Image(systemName: "trash")
                                            .foregroundColor(.white)
                                            .padding(8)
                                            .background(Color.red.opacity(0.8))
                                            .clipShape(Circle())
                                            .padding(10)
                                        
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Favourites")
        }
    }
}

#Preview {
    FavouriteView()
}
