//
//  MusicSearch-Endpoint.swift
//  iTunesSearch
//

import Foundation

enum MusicSearchEndpoint: Endpoint {
    case searchMusic(_ searchKeyword: String)
    
    var method: String {
        switch self {
        default:
            return HTTPMethod.get.rawValue
        }
    }
    
    var schema: String {
        switch self {
        default:
            return HTTPSchema.https.rawValue
        }
    }
    
    var baseUrl: String {
        switch self {
        default:
            return NetworkParts.baseUrl.rawValue
        }
    }
    
    var path: String {
        switch self {
        default:
            return NetworkPaths.searchPath.rawValue
        }
        
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .searchMusic(let searchKeyword):
            return [URLQueryItem(name: NetworkParametersKeys.term.rawValue, value: searchKeyword),
                    URLQueryItem(name: NetworkParametersKeys.country.rawValue, value: "de"),
                    URLQueryItem(name: NetworkParametersKeys.media.rawValue, value: "music"),
                    URLQueryItem(name: NetworkParametersKeys.sort.rawValue, value: "alphabetically"),
                    URLQueryItem(name: NetworkParametersKeys.limit.rawValue, value: "25"),
                    URLQueryItem(name: NetworkParametersKeys.offset.rawValue, value: "10")]
        }
    }
}
