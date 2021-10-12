//
//  Coordinates.swift
//  weather-app
//
//  Created by Agustin Errecalde on 12/10/2021.
//

struct Coordinates {
    let lon: Double
    let lat: Double
}
extension Coordinates: Codable {
    enum CodingKeys: String, CodingKey {
        case lon
        case lat
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.lon = try container.decode(Double.self, forKey: .lon)
        self.lat = try container.decode(Double.self, forKey: .lat)
    }
}
