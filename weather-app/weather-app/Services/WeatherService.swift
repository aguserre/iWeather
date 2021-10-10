//
//  WeatherService.swift
//  weather-app
//
//  Created by Agustin Errecalde on 07/10/2021.
//

import SwiftUI
import Combine

final class WeatherService {
    
    enum Units: String {
        case celcius = "metric"
    }
    
    func getWeathersInfo(byId: String, metrics: Units) -> AnyPublisher<WeatherModel, Error> {
        let baseUrl = ApiUrlBase.weatherById
        guard let weatherUrl = URL(string: baseUrl.rawValue) else { fatalError("Invalid URL") }
        guard var components = URLComponents(url: weatherUrl, resolvingAgainstBaseURL: true) else { fatalError("Couldn't create URLComponents") }
        components.queryItems = [URLQueryItem(name: "id", value: byId),
                                 URLQueryItem(name: "units", value: metrics.rawValue),
                                 URLQueryItem(name: "appid", value: ApiKey.weatherApiKey.rawValue)]
        let request = URLRequest(url: components.url!)
        debugPrint(request)
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

private extension WeatherService {
    private enum ApiUrlBase: String {
        case weatherById = "http://api.openweathermap.org/data/2.5/weather"
    }
    
    private enum ApiKey: String {
        case weatherApiKey = "9f783be210d7bc60e414702cc8af8f5e"
    }
}
