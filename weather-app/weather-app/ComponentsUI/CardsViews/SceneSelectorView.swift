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
            SpriteView(scene: RainSprite(rainIntensity: .intermediate), options: [.allowsTransparency])
                .transition(.opacity)
                .edgesIgnoringSafeArea(.all)
        }
        
        if condition == .Snow {
            SpriteView(scene: RainSprite(rainIntensity: .moderate), options: [.allowsTransparency])
                .transition(.opacity)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
