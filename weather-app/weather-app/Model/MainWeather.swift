//
//  MainWeather.swift
//  weather-app
//
//  Created by Agustin Errecalde on 12/10/2021.
//

struct MainWeather {
    let id: Int
    let main: MainValues
    let description: String
    let icon: String
}

extension MainWeather: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.main = try container.decode(MainValues.self, forKey: .main)
        self.description = try container.decode(String.self, forKey: .description)
        self.icon = try container.decode(String.self, forKey: .icon)
    }
}
