//
//  CircleWithBorderView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 11/10/2021.
//

import SwiftUI

struct StrokeCircleView: View {
    
    private let widthLineBorder: CGFloat = 1.5
    var lineWidth: CGFloat
    var height: CGFloat

    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.white, lineWidth: widthLineBorder, antialiased: true)
                .frame(width: height, height: height)
            
            Circle()
                .strokeBorder(Color(UIColor.systemIndigo), lineWidth: lineWidth, antialiased: true)
                .frame(width: height - widthLineBorder, height: height - widthLineBorder)
        }.frame(width: height, height: height)
    }
}

struct StrokeCircleView_Previews: PreviewProvider {
    static var previews: some View {
        StrokeCircleView(lineWidth: 4, height: 17)
            .preferredColorScheme(.dark)
    }
}
