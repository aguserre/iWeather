//
//  weather_appApp.swift
//  weather-app
//
//  Created by Agustin Errecalde on 05/10/2021.
//

import SwiftUI

@main
struct weather_appApp: App {
    
    private let viewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: viewModel)
        }
    }
}
