//
//  HomeView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 05/10/2021.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { proxy in
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(weatherFakes, id: \.id) { weather in
                        WeatherCardView(weather: weather)
                            .frame(width: proxy.size.width)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct WeatherCardView: View {

    let weather: WeatherModel
    
    var body: some View {
        VStack {
            Text(weather.name)
        }
    }
}






let weatherFakes: [WeatherModel] = [WeatherModel(coord: Coordinates(long: 20, lat: 20),
                               weather: Weather(id: 2, main: "Clear", description: "clear", icon: "01d"),
                               base: "",
                               main: MainData(temp: 282.55,
                                              feels_like: 546,
                                              temp_min: 200,
                                              temp_max: 300,
                                              pressure: 1023,
                                              humidity: 100),
                               visibility: 16093,
                               wind: Wind(speed: 1.5,
                                          deg: 2),
                               clouds: Clouds(all: 1),
                               dt: 1560350645,
                               sys: Sys(type: 1, id: 5122, message: 0.0139, country: "US", sunrise: 123456, sunset: 123456),
                               tymezone: -25200,
                               id: 42000,
                               name: "Mountain View",
                               cod: 200),
                                   
                                   WeatherModel(coord: Coordinates(long: 20, lat: 20),
                                                                  weather: Weather(id: 2, main: "Clear", description: "cloudyDay", icon: "01d"),
                                                                  base: "",
                                                                  main: MainData(temp: 282.55,
                                                                                 feels_like: 546,
                                                                                 temp_min: 200,
                                                                                 temp_max: 300,
                                                                                 pressure: 1023,
                                                                                 humidity: 100),
                                                                  visibility: 16093,
                                                                  wind: Wind(speed: 1.5,
                                                                             deg: 2),
                                                                  clouds: Clouds(all: 1),
                                                                  dt: 1560350645,
                                                                  sys: Sys(type: 1, id: 5122, message: 0.0139, country: "US", sunrise: 123456, sunset: 123456),
                                                                  tymezone: -25200,
                                                                  id: 42000,
                                                                  name: "Bragado",
                                                                  cod: 200)]
