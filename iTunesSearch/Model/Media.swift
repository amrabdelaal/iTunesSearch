//
//  Media.swift
//  iTunesSearch
//

import Foundation

struct MediaResponse: Decodable {
    let resultCount: Int
    let results: [Media]
}

struct Media: Decodable, Hashable, Equatable {
    let wrapperType: String
    let kind: String
    let artistId: Int
    let collectionId: Int?
    let trackId: Int
    var artistName: String
    let collectionName: String
    let trackName: String
    let collectionCensoredName: String
    let trackCensoredName: String
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: Date
    let collectionExplicitness: String
    let trackExplicitness: String
    let discCount: Int
    let discNumber: Int
    let trackCount: Int
    let trackNumber: Int
    let trackTimeMillis: Int?
    let country: String
    let currency: String
    let primaryGenreName: String
    let isStreamable: Bool
    
    static func ==(lhs: Media, rhs: Media) -> Bool {
        return lhs.trackId == rhs.trackId
    }
}
