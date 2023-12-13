//
//  Photo.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Jonathan Duong on 14/12/2023.
//

import Foundation

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
