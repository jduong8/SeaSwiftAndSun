//
//  SurfSpot.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Jonathan Duong on 14/12/2023.
//

import Foundation

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
