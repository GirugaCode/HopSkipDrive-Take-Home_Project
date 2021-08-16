//
//  NetworkService.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/16/21.
//

import Foundation

class NetworkService {
    /// Executes the web call and will decode the JSON response with the provided Codable object
    /// - Parameters:
    ///     - endpoint: the endpoint to make the HTTP request
    ///     - completion: JSON response converted to provide Codable object in succession or failure otherwise
    class func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        
        /// Checks if URL is constructed without issues
        guard let url = components.url else { return }
        
        /// Create a URL session with the HTTP method
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        /// Reference to URL session and define our data
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            // Error handling for error response
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            guard response != nil, let data = data else { return }
            
            DispatchQueue.main.async {
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    // Validate and provide to appropriate response object
                    completion(.success(responseObject))
                } else {
                    // Handles failure response
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "response"])
                    completion(.failure(error))
                }
            }
        }
        
        dataTask.resume()
        
    }
}
