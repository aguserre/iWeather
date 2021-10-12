//
//  Wind.swift
//  weather-app
//
//  Created by Agustin Errecalde on 12/10/2021.
//

struct Wind {
    let speed: Double
    let deg: Int
}
extension Wind: Codable {
    enum CodingKeys: String, CodingKey {
        case speed
        case deg
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.speed = try container.decode(Double.self, forKey: .speed)
        self.deg = try container.decode(Int.self, forKey: .deg)
    }
}
