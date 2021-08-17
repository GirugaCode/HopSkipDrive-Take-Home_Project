//
//  HopSkipDriveModels.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/16/21.
//

import Foundation

// MARK: - HopSkipDrive
struct HopSkipDriveResponse: Codable {
    let rides: [Ride]
}

// MARK: - Ride
struct Ride: Codable {
    let tripID: Int
    let inSeries: Bool
    let startsAt, endsAt: String
    let estimatedEarningsCents, estimatedRideMinutes: Int
    let estimatedRideMiles: Double
    let orderedWaypoints: [OrderedWaypoint]

    enum CodingKeys: String, CodingKey {
        case tripID = "trip_id"
        case inSeries = "in_series"
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case estimatedEarningsCents = "estimated_earnings_cents"
        case estimatedRideMinutes = "estimated_ride_minutes"
        case estimatedRideMiles = "estimated_ride_miles"
        case orderedWaypoints = "ordered_waypoints"
    }
}

// MARK: - OrderedWaypoint
struct OrderedWaypoint: Codable {
    let id: Int
    let anchor: Bool
    let passengers: [Passenger]
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let address: String
    let lat, lng: Double
}

// MARK: - Passenger
struct Passenger: Codable {
    let id: Int
    let boosterSeat: Bool
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case id
        case boosterSeat = "booster_seat"
        case firstName = "first_name"
    }
}

