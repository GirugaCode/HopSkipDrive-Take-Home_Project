//
//  HopSkipDriveEndpoint.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/16/21.
//

import Foundation

enum HopSkipDriveEndpoint: Endpoint {
    case getRideResults
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "storage.googleapis.com"
        }
    }
    
    var path: String {
        switch self {
        case .getRideResults:
            return "/hsd-interview-resources/simplified_my_rides_response.json"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        default:
            return []
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }

}
