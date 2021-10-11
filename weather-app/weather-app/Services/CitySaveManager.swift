//
//  CitySaveManager.swift
//  weather-app
//
//  Created by Agustin Errecalde on 11/10/2021.
//

import Foundation
import Combine

@propertyWrapper
struct Storage<T: Codable> {
    private let key: Identifiers
    private let defaultValue: T

    init(key: Identifiers, defaultValue: T) {
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
    enum Identifiers: String {
        case lastLocation = "lastCurrentWeather"
    }
}

struct AppData {
    @Storage(key: .lastLocation, defaultValue: WeatherModelFake.fakeWeather)
    static var lastCurrentWeather: WeatherModel
}
