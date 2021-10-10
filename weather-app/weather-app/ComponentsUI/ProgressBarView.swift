//
//  ProgressBarView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

struct ProgressBarView: View {
    
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
            Capsule()
                .fill(LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing))
                .frame(width: width , height: height)
                .opacity(0.5)
            
            HStack(spacing: -10) {
                Capsule()
                    .frame(width: CGFloat(value), height: height)
                    .foregroundColor(Color(UIColor.systemIndigo))
                
                Circle()
                    .strokeBorder(Color(UIColor.systemIndigo), lineWidth: 5, antialiased: true)
                    .frame(width: 17, height: 17)
            }
        }
    }
}
