//
//  WeatherService.swift
//  weather-app
//
//  Created by Agustin Errecalde on 07/10/2021.
//

import SwiftUI
import Combine

class WeatherService {
    
    func fetch(byId: String) -> AnyPublisher<WeatherModel, Error> {
        let baseUrl = "http://api.openweathermap.org/data/2.5/weather"
        guard let weatherUrl = URL(string: baseUrl) else { fatalError("Invalid URL") }
        guard var components = URLComponents(url: weatherUrl, resolvingAgainstBaseURL: true) else { fatalError("Couldn't create URLComponents") }
        components.queryItems = [URLQueryItem(name: "id", value: byId),
                                 URLQueryItem(name: "units", value: "metric"),
                                 URLQueryItem(name: "appid", value: "9f783be210d7bc60e414702cc8af8f5e")]
        let request = URLRequest(url: components.url!)
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
