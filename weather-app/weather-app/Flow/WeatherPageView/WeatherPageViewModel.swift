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
    private var mainTemp: String
    private var cityName: String
    private var weatherDescription: String
    private var minTemp: String
    private var maxTemp: String
    private var intensity: CGFloat
    private var visibility: String
    private var windVelocity: String
    private var dayState: CGFloat
    private var isNight: Bool
    private var sunsetTime: String
    private var currentTime: String
    private var sunriseTime: String
    private var pressure: Int
    private var humidity: String
    private var latitude: Double
    private var longitude: Double
    
    @Published var isCurrentWeather: Bool
    @Published var weatherMainStatus: MainValues
    @Published var icon: String
    @Published var backgroundColor: String


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
        
        guard let isCurrent = weather.isCurrent,
        isCurrent else { return }
        AppData.lastCurrentWeather = weather
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
    
    func getVisibilityCardViewModel() -> GenericCardViewModel {
        GenericCardViewModel(title: "Visibility",
                           imagetitle: "eye",
                           description: visibility,
                           size: UIScreen.main.bounds.size)
    }
    
    func getWindCardViewModel() -> GenericCardViewModel {
        GenericCardViewModel(title: "Wind",
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
    
    func getHumidityCardViewModel() -> GenericCardViewModel {
        GenericCardViewModel(title: "Humidity",
                           imagetitle: "wind",
                           description: humidity,
                           size: UIScreen.main.bounds.size)
    }
    
    func getMapCardViewModel() -> MapCardViewModel {
        MapCardViewModel(longitude: longitude,
                         latitude: latitude)
    }
    
}
