//
//  Fields.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Jonathan Duong on 14/12/2023.
//

import Foundation

struct Fields: Codable {
    var difficultyLevel: Int?
    var destination: String?
    var magicSeaweedLink: String?
    var photos: [Photo]?
    var peakSurfSeasonBegins: String?
    var destinationStateCountry: String?
    var peakSurfSeasonEnds: String?
    var influencers: [String]?
    var surfBreak: [String]?
    var address: String?
    var surfSpot: SurfSpot?

    enum CodingKeys: String, CodingKey {
        case difficultyLevel = "Difficulty Level"
        case destination = "Destination"
        case magicSeaweedLink = "Magic Seaweed Link"
        case photos = "Photos"
        case peakSurfSeasonBegins = "Peak Surf Season Begins"
        case destinationStateCountry = "Destination State/Country"
        case peakSurfSeasonEnds = "Peak Surf Season Ends"
        case influencers = "Influencers"
        case surfBreak = "Surf Break"
        case address = "Address"
    }
}
