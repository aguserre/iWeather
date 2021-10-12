//
//  HomeViewModel.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

final class WeatherViewModel: ObservableObject {
    @Published var offset: CGFloat = 0
    @Published var pageViewModels: [WeatherPageViewModel]

    init(pageViewModels: [WeatherPageViewModel]) {
        self.pageViewModels = pageViewModels
    }
    
    func getIndex() -> Int {
        let progress = Int(round(offset / UIScreen.main.bounds.width))
        let index = min(Int(progress), pageViewModels.count - 1)
        
        return index
    }
    
    func getIndicatorOffset() -> CGFloat {
        let progress = offset / UIScreen.main.bounds.width
        let maxWidth: CGFloat = 12 + 7
        
        return progress * maxWidth
    }
    
    func isSelected(index: Int) -> Bool {
        return getIndex() == index
    }
    
}
