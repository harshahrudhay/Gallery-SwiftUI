//
// ContentView.swift
// Gallery
//
// Created by HarshaHrudhay on 11/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "safari")
                        Text("Explore")
                    }

                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }

                FavouriteView()
                    .tabItem {
                        Image(systemName: "heart")
                        Text("Favourites")
                    }
            }
            .accentColor(.iconbg)
        }
    }
}

#Preview {
    ContentView()
}
