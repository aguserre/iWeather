//
//  SunCardViewModel.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

final class SunCardViewModel: ObservableObject {
    
    var currentPercent: CGFloat
    var isNight: Bool
    let title = "Current time"
    @Published var sunsetText: String
    @Published var sunriseText: String
    @Published var percent: CGFloat = 0
    @Published var icon: String
    @Published var currentTime: String
    
    init(currentPercent: CGFloat, isNight: Bool, sunsetText: String, sunriseText: String, icon: String, currentTime: String) {
        self.currentPercent = currentPercent
        self.isNight = isNight
        self.sunsetText = sunsetText
        self.sunriseText = sunriseText
        self.icon = icon
        self.currentTime = currentTime
    }
    
}
