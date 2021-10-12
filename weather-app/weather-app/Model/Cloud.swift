//
//  Cloud.swift
//  weather-app
//
//  Created by Agustin Errecalde on 12/10/2021.
//

struct Clouds {
    let all: Int
}
extension Clouds: Codable {
    enum CodingKeys: String, CodingKey {
        case all
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.all = try container.decode(Int.self, forKey: .all)
    }
}
