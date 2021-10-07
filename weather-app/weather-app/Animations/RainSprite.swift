//
//  RainSprite.swift
//  weather-app
//
//  Created by Agustin Errecalde on 07/10/2021.
//

import Foundation
import SpriteKit


class RainSprite: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        backgroundColor = .clear
        anchorPoint = CGPoint(x: 0.5, y: 1)
        
        guard let node = SKEmitterNode(fileNamed: "RainSprite") else { return }
        addChild(node)
        
        node.particlePositionRange.dx = size.width
    }
}

class SunSprite: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        backgroundColor = .clear
        anchorPoint = CGPoint(x: 0.15, y: 0.85)
        
        guard let node = SKEmitterNode(fileNamed: "SunClear") else { return }
        addChild(node)
        
    }
}
