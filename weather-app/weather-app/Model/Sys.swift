//
//  Sys.swift
//  weather-app
//
//  Created by Agustin Errecalde on 12/10/2021.
//

struct Sys {
    let country: String
    let sunrise: Int
    let sunset: Int
}

extension Sys: Codable {
    enum CodingKeys: String, CodingKey {
        case country
        case sunrise
        case sunset
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.country = try container.decode(String.self, forKey: .country)
        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
    }
}
