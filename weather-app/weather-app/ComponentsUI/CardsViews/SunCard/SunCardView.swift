//
//  SunCardView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

struct SunCardView: View {
    
    @ObservedObject private var viewModel: SunCardViewModel
    
    init(viewModel: SunCardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            BlurView(style: .light)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 180)
                .cornerRadius(10)
            
            VStack {
                HStack {
                    Text("Current time")
                        .padding(.top, 5)
                        .padding(.bottom, 1)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                    
                    Image(systemName: viewModel.isNight ? "moon.fill" : "sun.min")
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
                
                SunRotationView(percent: $viewModel.percent, icon: viewModel.isNight ? "moon.fill" : "sun.min.fill")
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(Animation.linear(duration: 1)) {
                                viewModel.percent = 100 + viewModel.currentPercent
                            }
                        }
                    }
                HStack {
                    Text(viewModel.sunsetText)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text(viewModel.sunriseText)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.trailing)
                }.padding([.leading, .trailing], 10)
                Spacer()
            }.frame(width: UIScreen.main.bounds.width * 0.9)
        }.frame(width: UIScreen.main.bounds.width, height: 180)
    }
}

struct SunCardView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = SunCardViewModel(currentPercent: 80, isNight: true, sunsetText: "Sunset: 22 Hs", sunriseText: "Sunrise: 22 Hs")
        SunCardView(viewModel: vm)
            .preferredColorScheme(.dark)
    }
}
