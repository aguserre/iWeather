//
//  WeatherProvider.swift
//  weather-app
//
//  Created by Agustin Errecalde on 12/10/2021.
//

import Combine

struct WeatherProvider {
    let apiClient: Requestable

    func allWeathersById(id: String) -> AnyPublisher<WeatherModel, Error> {
        apiClient.make(.byId(id: id))
    }
    
    func allWeathersByCoords(lon: Double, lat: Double) -> AnyPublisher<WeatherModel, Error> {
        apiClient.make(.coordinates(lon: lon, lat: lat))
    }
}
