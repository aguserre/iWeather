//
//  WeatherModelFake.swift
//  weather-app
//
//  Created by Agustin Errecalde on 11/10/2021.
//

import Foundation

class WeatherModelFake {
    static var fakeWeather: WeatherModel = WeatherModel(coord: Coordinates(lon: 0,
                                                                                             lat: 0),
                                                                          weather: [Weather(id: 0,
                                                                                            main: .Clear,
                                                                                            description: "- -",
                                                                                            icon: "-")],
                                                                          base: "",
                                                                          main: MainData(temp: 00,
                                                                                         feels_like: 0,
                                                                                         temp_min: 0,
                                                                                         temp_max: 0,
                                                                                         pressure: 0,
                                                                                         humidity: 0),
                                                                          visibility: 0,
                                                                          wind: Wind(speed: 0,
                                                                                     deg: 2),
                                                                          clouds: Clouds(all: 0),
                                                                          dt: 19000,
                                                                          sys: Sys(country: "US",
                                                                                   sunrise: 0,
                                                                                   sunset: 0),
                                                                          timezone: -25200,
                                                                          id: 42001,
                                                                          name: "- -",
                                                                                      cod: 200)
}
