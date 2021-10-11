//
//  SceneSelectorView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 07/10/2021.
//

import SwiftUI
import SpriteKit

struct SceneSelectorView: View {

    private var condition: MainValues

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

        if condition == .Snow {
            EmitterView(type: .Snow)
                .transition(.opacity)
                .edgesIgnoringSafeArea(.all)
                .animation(.linear.delay(0.5))
        }
    }
}
