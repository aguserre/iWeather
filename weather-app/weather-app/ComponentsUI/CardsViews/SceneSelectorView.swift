//
//  SceneSelectorView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 07/10/2021.
//

import SwiftUI
import SpriteKit

struct SceneSelectorView: View {

    private let condition: MainValues

    init(condition: MainValues) {
        self.condition = condition
    }

    var body: some View {
        if condition == .Rain {
            EmitterView(type: .Rain)
                .transition(.opacity)
                .edgesIgnoringSafeArea(.all)
                .animation(.linear.delay(0.5))
        }
        
        if condition == .Thunderstorm {
            EmitterView(type: .Thunderstorm)
                .transition(.opacity)
                .edgesIgnoringSafeArea(.all)
                .animation(.linear.delay(0.5))
        }

        if condition == .Snow {
            EmitterView(type: .Snow)
                .transition(.opacity)
                .edgesIgnoringSafeArea(.all)
                .animation(.linear.delay(0.5))
        }
        
        if condition == .Drizzle {
            EmitterView(type: .Drizzle)
                .transition(.opacity)
                .edgesIgnoringSafeArea(.all)
                .animation(.linear.delay(0.5))
        }
        
        if condition == .Fog || condition == .Smoke || condition == .Mist {
            EmitterView(type: .Fog)
                .transition(.opacity)
                .edgesIgnoringSafeArea(.all)
                .animation(.linear.delay(0.5))
        }
        
        if condition == .Clouds {
            EmitterView(type: .Clouds)
                .transition(.opacity)
                .edgesIgnoringSafeArea(.all)
                .animation(.linear.delay(0.5))
        }
        
    }
}
