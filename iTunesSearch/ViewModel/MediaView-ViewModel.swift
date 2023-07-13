//
//  MediaView-ViewModel.swift
//  iTunesSearch
//

import Foundation
import Combine

final class ViewModel: ObservableObject {
    @Published private(set) var mediaItems = [Media]()
    @Published var searchText = ""
    private var cancellable = Set<AnyCancellable>()
    private let client: APIClientProtocol
    
    init(client: APIClientProtocol = APICaller()) {
        self.client = client
    }
    
    func getMedia(_ searchText: String) {
        self.client.fetch(MediaResponse.self, endpoint: MusicSearchEndpoint.searchMusic(searchText))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    print(result)
                case .finished:
                    break
                }
            }, receiveValue: { mediaResponse in
                print(mediaResponse.resultCount)
                self.mediaItems = mediaResponse.results.sorted { $0.artistName < $1.artistName }
            })
            .store(in: &cancellable)
    }
}
