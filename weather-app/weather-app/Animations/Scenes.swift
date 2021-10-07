//
//  RainSprite.swift
//  weather-app
//
//  Created by Agustin Errecalde on 07/10/2021.
//

import Foundation
import SpriteKit
import SwiftUI

final class RainSprite: SKScene {
    private var rainIntensity: Intensity
    
    init(rainIntensity: Intensity) {
        self.rainIntensity = rainIntensity
        super.init(size: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        backgroundColor = .clear
        anchorPoint = CGPoint(x: 0.5, y: 1)
        
        guard let node = SKEmitterNode(fileNamed: "RainSprite") else { return }
        node.particlePositionRange.dx = size.width
        node.particleBirthRate = rainIntensity.rawValue
        node.particleSpeed = rainIntensity == .intense ? 500 : 100
        addChild(node)
    }
}
enum Intensity: CGFloat {
    case moderate = 20, intermediate = 200 , intense = 300
}
