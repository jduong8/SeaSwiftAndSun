//
//  SurfSpotAnnotation.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Jonathan Duong on 14/12/2023.
//

import Foundation
import CoreLocation

struct SurfSpotAnnotation: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
