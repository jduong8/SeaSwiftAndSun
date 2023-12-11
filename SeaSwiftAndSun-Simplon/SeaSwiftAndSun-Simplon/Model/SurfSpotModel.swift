//
//  SurfSpotModel.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Jonathan Duong on 11/12/2023.
//

import Foundation

// MARK: - Records
struct Records: Codable {
    var records: [Record]?
}

// MARK: - Record
struct Record: Codable {
    var id: String?
    var createdTime: String?
    var fields: Fields?
}

// MARK: - Fields
struct Fields: Codable {
    var difficultyLevel: Int?
    var destination: String?
    var magicSeaweedLink: String?
    var photos: [Photo]?
    var peakSurfSeasonBegins: String?
    var destinationStateCountry: String?
    var peakSurfSeasonEnds: String?
    var influencers, surfBreak: [String]?
    var address: String?

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

// MARK: - Photo
struct Photo: Codable {
    var id: String?
    var width: Int?
    var height: Int?
    var url: String?
    var filename: String?
    var size: Int?
    var type: String?
    var thumbnails: Thumbnails?
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    var small: Full?
    var large: Full?
    var full: Full?
}

// MARK: - Full
struct Full: Codable {
    var url: String?
    var width: Int?
    var height: Int?
}
