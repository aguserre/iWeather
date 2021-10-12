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
        guard progress >= 0, !pageViewModels.isEmpty else { return 0 }
        let index = min(Int(progress), pageViewModels.count - 1)
        
        return index
    }
    
    func isSelected(index: Int) -> Bool {
        return getIndex() == index
    }
    
}
