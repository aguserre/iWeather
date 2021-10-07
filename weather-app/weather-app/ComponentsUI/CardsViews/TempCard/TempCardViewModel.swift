//
//  TempCardViewModel.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

final class TempCardViewModel: ObservableObject {
    @Published var cityName: String
    @Published var currentTemp: String
    @Published var spaces: CGFloat
    @Published var weatherDescription: String
    @Published var minTemp: String
    @Published var maxTemp: String

    
    init(cityName: String, currentTemp: String, spaces: CGFloat, weatherDescription: String, minTemp: String, maxTemp: String) {
        self.cityName = cityName
        self.currentTemp = currentTemp
        self.spaces = spaces
        self.weatherDescription = weatherDescription
        self.minTemp = "L: \(minTemp)º"
        self.maxTemp = "H: \(maxTemp)º"
        
    }
}
