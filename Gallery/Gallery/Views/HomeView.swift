//
// HomeView.swift
// Gallery
//
// Created by HarshaHrudhay on 11/08/25.
//
import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: ImageViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        NavigationStack {
            



            ZStack {
                
                LinearGradient(colors: [Color.bgcolor, Color.bgcolor2],
                               startPoint: .bottomLeading,
                               endPoint: .topLeading)
                .ignoresSafeArea()
                
                
                VStack {
                    
                    Text("Photo Gallery")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.textbg)
                        .padding()
                    
                    ScrollView {
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            
                            ForEach(viewModel.images) { image in
                                
                                ZStack(alignment: .topTrailing) {
                                    
                                    VStack(spacing: 4) {
                                        
                                        
                                        if let uiImage = image.uiImage {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 150)
                                                .cornerRadius(12)
                                        } else {
                                            Image(image.name)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 150)
                                                .cornerRadius(12)
                                        }
                                        
                                        
                                        Text(image.name)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                    .padding(4)
                                    .background(Color.white.opacity(0.05))
                                    .cornerRadius(12)
                                    
                                    
                                    
                                    VStack(alignment: .trailing, spacing: 10) {
                                        
                                        
                                        Button {
                                            viewModel.toggleFavorite(for: image)
                                        } label: {
                                            Image(systemName: image.isFavorite ? "heart.fill" : "heart")
                                                .foregroundColor(.white)
                                                .padding(8)
                                                .background(Color.red.opacity(0.8))
                                                .clipShape(Circle())
                                        }
                                        
                                        
                                        
                                        Button {
                                            
                                            viewModel.deleteImage(image)
                                        } label: {
                                            
                                            Image(systemName: "trash")
                                                .foregroundColor(.white)
                                                .padding(8)
                                                .background(Color.black.opacity(0.7))
                                                .clipShape(Circle())
                                        }
                                        
                                    }
                                    .padding(10)
                                }
                            }
                        }
                        .padding()
                    }
                }
                
                
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink {
                            
                            ImageAddView()
                            
                        } label: {
                            
                            Text("+")
                                .font(.title)
                                .frame(width: 60, height: 60)
                                .foregroundStyle(Color.bgcolor)
                                .background(Color.bgcolor2)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                            
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ImageViewModel())
}
