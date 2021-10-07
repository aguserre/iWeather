//
//  SceneSelectionView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 07/10/2021.
//

import SwiftUI
import SpriteKit

struct SceneSelectionView: View {
    
    var weatherStatus: String
    
    var body: some View {
        if weatherStatus == "Rain" {
            SpriteView(scene: RainSprite(), options: [.allowsTransparency])
        }
        
        if weatherStatus == "Clear" {
            SpriteView(scene: SunSprite(), options: [.allowsTransparency])
        }
    }
}
