//
//  WeatherPageViewModel.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI
import Combine

final class WeatherPageViewModel: ObservableObject {
    let id = UUID()
    //main
    @Published var isCurrentWeather: Bool
    @Published var mainTemp: String
    @Published var cityName: String
    @Published var weatherDescription: String
    @Published var minTemp: String
    @Published var maxTemp: String
    @Published var backgroundColor: String
    @Published var intensity: CGFloat
    @Published var weatherMainStatus: MainValues
    
    //visibility
    @Published var visibility: String
    
    //wind
    @Published var windVelocity: String
    
    //sun state
    @Published var dayState: CGFloat
    @Published var isNight: Bool
    @Published var sunsetTime: String
    @Published var currentTime: String
    @Published var sunriseTime: String
    @Published var icon: String
    
    //Pressure
    @Published var pressure: Int
    
    //Humidity
    @Published var humidity: String
    
    //Map
    @Published var latitude: Double
    @Published var longitude: Double

    init(weather: WeatherModel) {
        let mainWeather = weather.weather.first?.main
        intensity = mainWeather == .Rain ? 200 : (mainWeather == .Snow ? 20 : 0)
        isCurrentWeather = weather.isCurrent ?? false
        backgroundColor = weather.backGroundColor
        mainTemp = String(Int(weather.main.temp))
        cityName = weather.name
        weatherDescription = weather.weather.first?.description ?? " "
        minTemp = String(weather.main.temp_min)
        maxTemp = String(weather.main.temp_max)
        visibility = "\(weather.visibility) m"
        windVelocity = "\(weather.wind.speed) m/s"
        dayState = CGFloat(weather.currentInHours*100/24)
        isNight = weather.isNight
        sunsetTime = "Sunset: \(weather.sunsetInHours) Hs"
        sunriseTime = "Sunrise: \(weather.sunriseInHours) Hs"
        pressure = weather.main.pressure
        humidity = "\(weather.main.humidity)%"
        latitude = weather.coord.lat
        longitude = weather.coord.lon
        icon = weather.weather.first?.icon ?? "sun.fill"
        weatherMainStatus = mainWeather ?? .Clear
        currentTime = weather.currentTime
    }
    
    
    func getSpaces() -> CGFloat {
        (15 * CGFloat(String(mainTemp).count)) + 15
    }
    
    func getTempViewModel() -> TempCardViewModel {
        TempCardViewModel(cityName: cityName,
                          currentTemp: mainTemp,
                          spaces: getSpaces(),
                          weatherDescription: weatherDescription.capitalized,
                          minTemp: minTemp,
                          maxTemp: maxTemp,
                          icon: icon)
    }
    
    func getVisibilityCardViewModel() -> SmallCardViewModel {
        SmallCardViewModel(title: "Visibility",
                           imagetitle: "eye",
                           description: visibility,
                           size: UIScreen.main.bounds.size)
    }
    
    func getWindCardViewModel() -> SmallCardViewModel {
        SmallCardViewModel(title: "Wind",
                           imagetitle: "wind",
                           description: windVelocity,
                           size: UIScreen.main.bounds.size)
    }
    
    func getSunCardViewModel() -> SunCardViewModel {
        SunCardViewModel(currentPercent: dayState,
                         isNight: isNight,
                         sunsetText: sunsetTime,
                         sunriseText: sunriseTime,
                         icon: icon,
                         currentTime: currentTime)
    }
    
    func getPressureCardViewModel() -> PressureCardViewModel {
        PressureCardViewModel(title: "Pressure",
                              imagetitle: "barometer",
                              preassure: pressure,
                              size: UIScreen.main.bounds.size)
    }
    
    func getHumidityCardViewModel() -> SmallCardViewModel {
        SmallCardViewModel(title: "Humidity",
                           imagetitle: "wind",
                           description: humidity,
                           size: UIScreen.main.bounds.size)
    }
    
    func getMapCardViewModel() -> MapCardViewModel {
        MapCardViewModel(longitude: longitude,
                         latitude: latitude)
    }
    
}
