//
//  MainData.swift
//  weather-app
//
//  Created by Agustin Errecalde on 12/10/2021.
//

struct MainData {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

extension MainData: Codable {
    enum CodingKeys: String, CodingKey {
        case temp
        case feels_like
        case temp_min
        case temp_max
        case pressure
        case humidity
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.feels_like = try container.decode(Double.self, forKey: .feels_like)
        self.temp_min = try container.decode(Double.self, forKey: .temp_min)
        self.temp_max = try container.decode(Double.self, forKey: .temp_max)
        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
    }
}
