//
//  LoadingOverlay.swift
//  weather-app
//
//  Created by Agustin Errecalde on 08/10/2021.
//

import SwiftUI


public struct LoadingOverlaySUI: View {
    
    @State private var animateStrokeStart = false
    @State private var animateStrokeEnd = true
    @State private var isRotating = false
    private let _blurStyle: UIBlurEffect.Style
    
    public init(blurStyle: UIBlurEffect.Style = .systemUltraThinMaterial) {
        _blurStyle = blurStyle
    }
    
    public var body: some View {
        ZStack {
            BlurView(style: _blurStyle)
                .edgesIgnoringSafeArea(.all)
        
            Circle()
                .trim(from: animateStrokeStart ? 1/3 : 1/9, to: animateStrokeEnd ? 2/9 : 1)
                .stroke(lineWidth: 6)
                .frame(width: 50, height: 50)
                .foregroundColor(Color(UIColor.systemIndigo))
                .rotationEffect(.degrees(isRotating ? 360 : 0))
                .onAppear {
                    withAnimation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false)) {
                        isRotating.toggle()
                    }
                    withAnimation(Animation.linear(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
                        animateStrokeStart.toggle()
                    }
                    withAnimation(Animation.linear(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
                        animateStrokeEnd.toggle()
                    }
                }
        }.transition(.opacity)
    }
}
