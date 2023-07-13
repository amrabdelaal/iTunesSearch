//
//  NetworkConstants.swift
//  iTunesSearch
//

import Foundation

/// Here is example of targeted URL
/// "https://itunes.apple.com/search?term=book+club&country=de&media=music&limit=25"
///
/// Enums that helps in contract URL

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum HTTPSchema: String {
    case http = "http"
    case https = "https"
}

enum NetworkParts: String {
    case baseUrl = "itunes.apple.com"
}

enum NetworkPaths: String {
    case searchPath = "/search"
}

enum NetworkParametersKeys: String {
    case term = "term"
    case country = "country"
    case media = "media"
    case limit = "limit"
    case sort = "sort"
    case offset = "offset"
}

enum NetworkError: Error {
    case urlError
    case dataParsingError
}
