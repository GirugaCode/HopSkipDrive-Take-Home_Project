//
//  Endpoint.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/16/21.
//

import Foundation

protocol Endpoint {
    /// HTTP or HTTPS
    var scheme: String { get }
    
    /// Base URL of request
    var baseURL: String { get }
    
    /// URL path ex. /services/rest
    var path: String { get }
    
    /// Parameters for URL, API key
    var parameters: [URLQueryItem] { get }
    
    /// ex. "GET"
    var method: String { get }
}
