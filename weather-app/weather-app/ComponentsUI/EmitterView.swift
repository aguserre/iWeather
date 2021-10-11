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
        emitter.emitterShape = getEmitterShape()
        emitter.emitterCells = createEmitterCells()
        emitter.emitterSize = getEmitterSize()
        emitter.emitterPosition = getEmitterPosition()
        
        view.layer.addSublayer(emitter)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }

    func createEmitterCells() -> [CAEmitterCell]? {
        let cell = CAEmitterCell()
        guard let image = getImage() else { return nil }
        cell.contents = image
        cell.birthRate = getBirthRate()
        cell.lifetimeRange = 20
        cell.velocity = getVelocity()
        cell.scale = getScale()
        cell.scaleRange = getScaleRange()
        cell.emissionLongitude = .pi
        cell.emissionRange = getemissionRange()
        cell.color = getCellColor()
        
        return [cell]
    }
    
    private func getEmitterSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: type == .Clouds ? UIScreen.main.bounds.height/2 : 1)
    }
    
    private func getEmitterPosition() -> CGPoint {
        return CGPoint(x: type == .Clouds ? UIScreen.main.bounds.width : UIScreen.main.bounds.width / 2,
                       y: type == .Clouds ? 60 : 0)

    }
    
    private func getBirthRate() -> Float {
        switch type {
        case .Rain, .Snow:
            return 200
        case .Thunderstorm:
            return 600
        case .Drizzle:
            return 150
        case .Fog, .Smoke, .Mist:
            return 20
        case .Clear:
            return 0
        case .Clouds:
            return 10
        case .unknown:
            return 0
        }
    }
    
    private func getCellColor() -> CGColor? {
        switch type {
        case .Rain, .Snow, .Drizzle, .Thunderstorm:
            return UIColor.white.cgColor
        case .Fog, .Smoke, .Mist:
            return UIColor.white.withAlphaComponent(0.1).cgColor
        case .Clouds:
            return UIColor.white.withAlphaComponent(0.3).cgColor
        default:
            return nil
        }
    }
    
    private func getEmitterShape() -> CAEmitterLayerEmitterShape {
        switch type {
        case .Clouds:
            return .circle
        default:
            return .line
        }
    }
    
    private func getemissionRange() -> CGFloat {
        switch type {
        case .Rain, .Thunderstorm:
            return 0.1
        case .Drizzle:
            return 0.5
        case .Snow:
            return 1
        case .Mist, .Smoke, .Fog:
            return 0.1
        case .Clouds:
            return 0.1
        default:
            return 0
        }
    }
    
    private func getScaleRange() -> CGFloat {
        switch type {
        case .Rain, .Thunderstorm, .Drizzle:
            return 0.1
        case .Snow:
            return 0.3
        case .Mist, .Smoke, .Fog:
            return 0.08
        case .Clouds:
            return 1
        default:
            return 0
        }
    }
    
    private func getScale() -> CGFloat {
        switch type {
        case .Rain, .Thunderstorm:
            return 0.6
        case .Drizzle:
            return 0.2
        case .Snow:
            return 0.1
        case .Mist, .Smoke, .Fog:
            return 1
        case .Clouds:
            return 0.5
        default:
            return 0
        }
    }
    
    private func getVelocity() -> CGFloat {
        switch type {
        case .Rain, .Thunderstorm:
            return 800
        case .Drizzle:
            return 100
        case .Snow:
            return 80
        case .Mist, .Smoke, .Fog:
            return 100
        case .Clouds:
            return 50
        default:
            return 0
        }
    }
    
    private func getImage() -> CGImage? {
        switch type {
        case .Rain, .Drizzle, .Thunderstorm:
            return UIImage(named: "drop")?.cgImage
        case .Snow:
            return UIImage(named: "spark")?.cgImage
        case .Mist, .Smoke, .Fog:
            return UIImage(named: "fog")?.cgImage
        case .Clear:
            return nil
        case .Clouds:
            return UIImage(named: "fog")?.cgImage
        case .unknown:
            return nil
        }
    }
    
}
