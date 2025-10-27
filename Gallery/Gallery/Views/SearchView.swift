//
// SearchView.swift
// Gallery
//
// Created by HarshaHrudhay on 11/08/25.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var viewModel : ImageViewModel
    
    @State private var searchText = ""

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var filtered: [ImageItem] {
        if searchText.isEmpty {
            return viewModel.images
        }
        
        return viewModel.images.filter {
            $0.category.lowercased().contains(searchText.lowercased()) ||
            $0.name.lowercased().contains(searchText.lowercased())
        }
        
    }

    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                LinearGradient(colors: [Color.bgcolor, Color.bgcolor2], startPoint: .bottomLeading, endPoint: .topLeading)
                    .ignoresSafeArea()

                VStack {
                    
                    TextField("Search by category or name", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    ScrollView {
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            
                            ForEach(filtered) { image in
                                
                                VStack(spacing: 8) {
                                    
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
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(12)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Search")
        }
    }
}

#Preview {
    SearchView()
}
