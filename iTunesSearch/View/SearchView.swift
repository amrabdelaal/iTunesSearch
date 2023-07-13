//
//  ContentView.swift
//  iTunesSearch
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding()
                    TextField("e.g. Book club", text: $searchText)
                        .frame(height: 40)
                }
                .border(.black, width: 2)
                .cornerRadius(2)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                
                NavigationLink {
                    Listview(searchText: searchText)
                } label: {
                    Text("Start Search")
                        .foregroundColor(.black)
                        .padding()
                }
                .frame(height: 40)
                .border(.black, width: 1)
                .cornerRadius(2)
                .disabled(searchText.isEmpty ? true : false)
                .opacity(searchText.isEmpty ? 0.4 : 1.0)
                
                Spacer()
            }
            .navigationTitle("Search View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
