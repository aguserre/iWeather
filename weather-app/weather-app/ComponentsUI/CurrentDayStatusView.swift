//
//  SunRotationView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

struct CurrentDayStatusView: View {
    
    @Binding var percent: CGFloat
    @Binding var iconImage: String
    @Binding var currentTime: String
    
    private let circleHeight: CGFloat = 80
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
        let pinHeight = circleHeight * 0.35
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
                ZStack {
                    Circle()
                        .strokeBorder(Color(UIColor.systemIndigo), lineWidth: 5, antialiased: true)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: pinHeight, height: pinHeight)
                        .offset(y: -pinHeight / 2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .rotationEffect(Angle(degrees: 360 * Double(completion)))
                    
                    Text("\(currentTime)\nHs")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
            )
    }
}
