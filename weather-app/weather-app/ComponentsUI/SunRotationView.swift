//
//  SunRotationView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

struct SunRotationView: View {
    
    @Binding var percent: CGFloat
    var icon: String
    
    private let circleHeight: CGFloat = 100
    private let colors: [Color] = [
        Color("clearNight"),
        Color("clearNight"),
        Color.orange,
        Color("clear"),
        Color("clear"),
        Color("clear"),
        Color("clear"),
        Color.orange,
        Color("clearNight"),
        Color("clearNight")
    ]
     
    var body: some View {
        let pinHeight = circleHeight * 0.4
        let completion = percent * 0.01
        Circle()
            .trim(from: 0, to: completion)
            .stroke(style: StrokeStyle(lineWidth: 16,
                                       lineCap: .butt,
                                       lineJoin: .miter,
                                       miterLimit: 10))
            .fill(AngularGradient(gradient: .init(colors: colors),
                                  center: .center,
                                  startAngle: .zero,
                                  endAngle: .init(degrees: 360)))
            .rotationEffect(.degrees(-90))
            .frame(width: circleHeight, height: circleHeight)
            .overlay(
                Image(systemName: icon)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.yellow)
                    .frame(width: pinHeight, height: pinHeight)
                    .offset(y: -pinHeight / 2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .rotationEffect(Angle(degrees: 360 * Double(completion)))
            )
    }
}
