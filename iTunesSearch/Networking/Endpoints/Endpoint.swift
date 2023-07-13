//
//  Endpoint.swift
//  iTunesSearch
//

import Foundation

protocol Endpoint {
    /// Set the targeted HTTP Method
    var method: String { get }
    
    /// Set the targeted HTTP Method
    var schema: String { get }
    
    /// Pass base url of targeted endpoint
    var baseUrl: String { get }
    
    /// Specify endpoint path
    var path: String { get }
    
    /// Setting related parameters requested for the endpoint
    var parameters: [URLQueryItem] { get }
}
