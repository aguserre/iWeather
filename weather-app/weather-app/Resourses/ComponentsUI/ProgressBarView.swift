//
//  ProgressBarView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

struct ProgressBarView: View {
    private let lineWidth: CGFloat = 4
    
    @Binding var value: Float
    var width: CGFloat
    var height: CGFloat = 10
    
    private let colors: [Color] = [
        Color.green,
        Color.green,
        Color.green,
        Color.green,
        Color.green,
        Color.yellow,
        Color.yellow,
        Color.yellow,
        Color.orange,
        Color.orange,
        Color.red
    ]
    
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack {
                Capsule()
                    .strokeBorder(Color.white, lineWidth: 1, antialiased: true)
                    .frame(width: width+1 , height: height+1)
                
                Capsule()
                    .fill(LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing))
                    .frame(width: width , height: height)
                    .opacity(0.5)
                }
            
            HStack(spacing: -lineWidth - 1) {
                Capsule()
                    .frame(width: CGFloat(value), height: height)
                    .foregroundColor(Color(UIColor.systemIndigo))
                
                StrokeCircleView(lineWidth: lineWidth, height: 17)
            }
        }
    }
}
