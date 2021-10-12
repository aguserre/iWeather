//
//  RequestableProtocol.swift
//  weather-app
//
//  Created by Agustin Errecalde on 12/10/2021.
//

import Combine

protocol Requestable {
    func make(
        _ fetchType: FetchType
    ) -> AnyPublisher<WeatherModel, Error>
}
