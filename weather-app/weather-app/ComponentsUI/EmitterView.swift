//
//  EmitterView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 07/10/2021.
//

import SpriteKit
import SwiftUI

struct EmitterView: UIViewRepresentable {
    
    var type: MainValues
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let emitter = CAEmitterLayer()
        emitter.emitterShape = .line
        emitter.emitterCells = createEmitterCells(name: type == .Rain ? "drop" : (type == .Snow ? "spark" : ""))
        
        emitter.emitterSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        emitter.emitterPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
        
        view.layer.addSublayer(emitter)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }

    func createEmitterCells(name: String) -> [CAEmitterCell] {
        let cell = CAEmitterCell()
        let image = UIImage(named: name)?.cgImage
        cell.contents = image
        cell.color = UIColor.white.cgColor
        cell.birthRate = 100
        cell.lifetimeRange = 20
        cell.velocity = type == .Rain ? 400 : 120
        cell.scale = type == .Rain ? 0.6 : 0.1
        cell.scaleRange = type == .Rain ? 0.1 : 0.3
        cell.emissionLongitude = .pi
        cell.emissionRange = type == .Rain ? 0.1 : 1
        
        return [cell]
    }
}
