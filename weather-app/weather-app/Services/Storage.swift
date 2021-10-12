//
//  Storage.swift
//  weather-app
//
//  Created by Agustin Errecalde on 11/10/2021.
//

import Foundation
import Combine

@propertyWrapper
struct Storage<T: Codable> {
    private let key: KeyType
    private let defaultValue: T

    init(key: KeyType, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key.rawValue)
        }
    }
}

extension Storage {
    enum KeyType: String {
        case lastLocation = "lastCurrentWeather"
        case ids = "ids"
        case weatherUnit = "weatherUnit"
    }
}

struct AppData {
    @Storage(key: .lastLocation, defaultValue: WeatherModelFake.fakeWeather)
    static var lastCurrentWeather: WeatherModel
    
    @Storage(key: .ids, defaultValue: ["2643743", "3441575", "3433955"])
    static var savedIds: [String]
    
    @Storage(key: .weatherUnit, defaultValue: .celcius)
    static var weatherUnitDefault: Units
}
