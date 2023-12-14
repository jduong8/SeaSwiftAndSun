//
//  SurfSpotModel.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Jonathan Duong on 11/12/2023.
//

import Foundation
import MapKit
import SwiftUI

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

enum SurfSpot: String, CaseIterable {
    case manuBay = "Manu Bay"
    case superbank = "SuperBank"
    case southernPeru = "Southern Peru"
    case rockawayBeach = "Rockaway Beach"
    case skeletonBay = "Skeleton Bay"
    case theBubble = "The Bubble"
    case kittyHawk = "Kitty Hawk"
    case pipeline = "Pipeline"
    case supertubes = "Supertubes"
    case pastaPoint = "Pasta Point"

    var coordinates: (latitude: Double, longitude: Double) {
        switch self {
        case .manuBay:
            return (-37.822779, 174.800723)
        case .superbank:
            return (-27.999566, 153.431633)
        case .southernPeru:
            return (-12.122954, -77.043640)
        case .rockawayBeach:
            return (40.578891, -73.830047)
        case .skeletonBay:
            return (-22.684431, 14.522112)
        case .theBubble:
            return (28.734101, -13.867322)
        case .kittyHawk:
            return (36.072045, -75.693100)
        case .pipeline:
            return (21.663770, -158.051876)
        case .supertubes:
            return (34.031801, 24.933020)
        case .pastaPoint:
            return (4.316244, 73.591637)
        }
    }
}

struct SurfSpotAnnotation: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
