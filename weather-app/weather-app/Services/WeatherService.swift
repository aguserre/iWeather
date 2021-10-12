//
//  WeatherService.swift
//  weather-app
//
//  Created by Agustin Errecalde on 07/10/2021.
//

import SwiftUI
import Combine

struct ApiClient: Requestable {
    func make(
        _ fetchType: FetchType
    ) -> AnyPublisher<WeatherModel, Error> {
        let baseUrl = ApiUrlBase.weatherById
        var isCurrentWeather = false
        guard let weatherUrl = URL(string: baseUrl.rawValue) else { fatalError("Invalid URL") }
        
        guard var components = URLComponents(url: weatherUrl, resolvingAgainstBaseURL: true) else { fatalError("Couldn't create URLComponents") }
        var queryItems = [URLQueryItem]()
        switch fetchType {
        case .byId(let id):
            isCurrentWeather = false
            queryItems.append(URLQueryItem(name: "id", value: id))
        case .coordinates(let lon, let lat):
            isCurrentWeather = true
            queryItems.append(URLQueryItem(name: "lat", value: String(lat)))
            queryItems.append(URLQueryItem(name: "lon", value: String(lon)))
        }
        queryItems.append(URLQueryItem(name: "units", value: AppData.weatherUnitDefault.rawValue))
        queryItems.append(URLQueryItem(name: "appid", value: ApiKey.weatherApiKey.rawValue))
        
        components.queryItems = queryItems
        
        let request = URLRequest(url: components.url!)
            
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .map {
                var model = $0
                model.isCurrent = isCurrentWeather
                return model
            }
            .eraseToAnyPublisher()
    }
}

private extension ApiClient {
    private enum ApiUrlBase: String {
        case weatherById = "http://api.openweathermap.org/data/2.5/weather"
    }
    
    private enum ApiKey: String {
        case weatherApiKey = "9f783be210d7bc60e414702cc8af8f5e"
    }
}

enum FetchType {
    case byId(id: String)
    case coordinates(lon: Double, lat: Double)
}
