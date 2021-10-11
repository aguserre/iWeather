//
//  weather_appApp.swift
//  weather-app
//
//  Created by Agustin Errecalde on 05/10/2021.
//

import SwiftUI

@main
struct weather_appApp: App {
    
    private let mainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: mainViewModel)
        }
    }
}
