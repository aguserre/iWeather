//
//  MainValues.swift
//  weather-app
//
//  Created by Agustin Errecalde on 12/10/2021.
//

enum MainValues: String {
    case Rain = "Rain"
    case Thunderstorm = "Thunderstorm"
    case Drizzle = "Drizzle"
    case Snow = "Snow"
    case Fog = "Fog"
    case Smoke = "Smoke"
    case Mist = "Mist"
    case Clear = "Clear"
    case Clouds = "Clouds"
    case unknown
}
extension MainValues: Codable {
    public init(from decoder: Decoder) throws {
        self = try MainValues(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}
