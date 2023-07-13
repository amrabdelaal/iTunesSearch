//
//  Listview.swift
//  iTunesSearch
//

import SwiftUI

struct Listview: View {
    @StateObject private var viewModel = ViewModel()
    var searchText = ""
    
    var body: some View {
        ScrollView {
            if viewModel.mediaItems.count > 0 {
                ForEach(viewModel.mediaItems, id: \.self) { item in
                    NavigationLink {
                        DetailView(mediaItem: item)
                    } label: {
                        MediaItemView(mediaItem: item)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.getMedia(searchText)
        }
        .navigationTitle("List View")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct Listview_Previews: PreviewProvider {
    static var previews: some View {
        Listview(searchText: "book club")
    }
}
