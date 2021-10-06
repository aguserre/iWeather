//
//  SunCardView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

struct SunCardView: View {
    
    var currentPercent: CGFloat
    @State var percent: CGFloat = 0
    
    init(currentPercent: CGFloat) {
        self.currentPercent = currentPercent
    }
    
    var body: some View {
        ZStack {
            BlurView(style: .light)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 180)
                .cornerRadius(10)
            
            VStack {
                VStack {
                    HStack {
                        Text("Current time")
                            .padding(.top, 5)
                            .padding(.bottom, 1)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                        
                        Image(systemName: "sun.min")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                    }
                    
                    Divider()
                        .frame(width: (UIScreen.main.bounds.width * 0.8) - 30, height: 1)
                        .background(Color.white)
                    
                    Spacer()
                    
                    SunRotationView(percent: $percent)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(Animation.linear(duration: 1)) {
                                    percent = 100 + currentPercent
                                }
                            }
                        }
                    
                    Spacer()
                }
            }
        }.frame(width: UIScreen.main.bounds.width, height: 180)
    }
}

struct SunCardView_Previews: PreviewProvider {
    static var previews: some View {
        SunCardView(currentPercent: 80)
            .preferredColorScheme(.dark)
    }
}


struct SunRotationView: View {
    
    @Binding var percent: CGFloat
    
    var colors: [Color] = [
        Color("clearNight"),
        Color("clearNight"),
        Color("clear"),
        Color("clear"),
        Color("clear"),
        Color("clear"),
        Color("clearNight"),
        Color("clearNight")
    ]
    
    let circleHeight: CGFloat = 100
     
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
                Image(systemName: "sun.max.fill")
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
