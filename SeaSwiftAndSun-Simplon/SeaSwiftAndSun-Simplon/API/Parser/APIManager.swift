//
//  APIManager.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Jonathan Duong on 12/12/2023.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func fetchData<T: Decodable>(model: T.Type) async throws -> T {
        guard let url = URL(string: APIConstants.urlString) else {
            throw APIError.invalidPath
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue(APIConstants.token, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.decoding
        }
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(T.self, from: data)
        
        return decoded
    }

    func addSpot(_ spot: Record) async throws {
      guard let url = URL(string: APIConstants.urlString) else {
        throw APIError.invalidPath
      }

        let body: [String: Any] = [
            "id": UUID().uuidString,
            "createdTime": "2018-06-26T16:51:23.000Z",
            "fields": 
            
        ]
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = HTTPMethod.post.rawValue
      urlRequest.setValue(APIConstants.token, forHTTPHeaderField: "Authorization")
      urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

      let encoder = JSONEncoder()
      let encodedSpot = try encoder.encode(spot)

      urlRequest.httpBody = encodedSpot

        let (_, response) = try await URLSession.shared.data(for: urlRequest)

      guard (response as? HTTPURLResponse)!.statusCode == 200 else {
        throw APIError.decoding
      }
    }
}

extension APIManager {
    enum APIError: Error {
        case invalidPath
        case decoding
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    struct APIConstants {
        static let urlString = "https://api.airtable.com/v0/appWuDFWA6Ez92RRX/Surf%20Destinations"
        static let token = "Bearer patm5xMcdBnc29e7y.2daf005f0d722e3a09c90e00da040a1b289110d3724f78078f8a35fd8e413d41"
    }
}
