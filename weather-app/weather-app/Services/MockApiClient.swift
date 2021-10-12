//
//  MockApiClient.swift
//  weather-app
//
//  Created by Agustin Errecalde on 12/10/2021.
//

import Combine

struct MockApiClient: Requestable {
    func make(
        _ fetchType: FetchType
    ) -> AnyPublisher<WeatherModel, Error> {
        Just(WeatherModelFake().fakeWeather)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
