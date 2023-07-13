//
//  APICaller.swift
//  iTunesSearch
//

import Foundation
import Combine

protocol APIClientProtocol {
    func fetch<T: Decodable>(_ t: T.Type, endpoint: Endpoint) -> AnyPublisher<T, Error>
}

struct APICaller: APIClientProtocol {
    func fetch<T: Decodable>(_ t: T.Type, endpoint: Endpoint) -> AnyPublisher<T, Error> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.schema
        urlComponents.host = endpoint.baseUrl
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.parameters
        
        guard let url = urlComponents.url else {
            return Fail(error: NetworkError.urlError).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
