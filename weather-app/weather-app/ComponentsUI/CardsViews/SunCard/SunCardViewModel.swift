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
    @Published var sunsetText: String
    @Published var sunriseText: String
    @Published var percent: CGFloat = 0
    
    init(currentPercent: CGFloat, isNight: Bool, sunsetText: String, sunriseText: String) {
        self.currentPercent = currentPercent
        self.isNight = isNight
        self.sunsetText = sunsetText
        self.sunriseText = sunriseText
    }
    
}
