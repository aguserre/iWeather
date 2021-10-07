//
//  HomeViewModel.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI
import SpriteKit

final class HomeViewModel: ObservableObject {
    @Published var offset: CGFloat = 0
    @Published var weathers: [WeatherModel]
    
    init() {
        weathers = weatherFakes
    }
    
    func getIndex() -> Int {
        let progress = Int(round(offset / UIScreen.main.bounds.width))
        let index = min(Int(progress), weathers.count - 1)
        
        return index
    }
    
    func getIndicatorOffset() -> CGFloat {
        let progress = offset / UIScreen.main.bounds.width
        let maxWidth: CGFloat = 12 + 7
        
        return progress * maxWidth
    }
    
}
