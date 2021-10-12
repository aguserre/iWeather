//
//  WeatherModelFake.swift
//  weather-app
//
//  Created by Agustin Errecalde on 11/10/2021.
//

import Foundation

class WeatherModelFake {
    
    let fakeWeather: WeatherModel
    
    init(coord: Coordinates = Coordinates(lon: 0, lat: 0),
         weather: [MainWeather] = [MainWeather(id: 0, main: .Clear, description: "- -", icon: "-")],
         base: String = "",
         main: MainData = MainData(temp: 00, feels_like: 0, temp_min: 0, temp_max: 0, pressure: 0, humidity: 0),
         visibility: Int = 0,
         wind: Wind = Wind(speed: 0, deg: 2),
         clouds: Clouds = Clouds(all: 0),
         dt: Int = 19000,
         sys: Sys = Sys(country: "US", sunrise: 0, sunset: 0),
         timezone: Int = -25200,
         id: Int = 42001,
         name: String = "- -",
         cod: Int = 200,
         isCurrent: Bool? = false) {
        
        fakeWeather = WeatherModel(coord: coord,
                                   weather: weather,
                                   base: base,
                                   main: main,
                                   visibility: visibility,
                                   wind: wind,
                                   clouds: clouds,
                                   dt: dt,
                                   sys: sys,
                                   timezone: timezone,
                                   id: id,
                                   name: name,
                                   cod: cod,
                                   isCurrent: isCurrent)
    }

}
