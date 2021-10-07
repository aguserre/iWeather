//
//  SunCardView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

struct SunCardView: View {
    
    @ObservedObject private var viewModel: SunCardViewModel
    @ObservedObject private var imageLoader: ImageLoader
    
    init(viewModel: SunCardViewModel) {
        self.viewModel = viewModel
        self.imageLoader = ImageLoader(urlString: viewModel.icon)
    }
    
    var body: some View {
        ZStack {
            BlurView(style: .light)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 180)
                .cornerRadius(10)
            
            VStack {
                HStack {
                    Text(viewModel.title)
                        .padding(.top, 5)
                        .padding(.bottom, 1)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                    
                    Image(uiImage: viewModel.imageWeather)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
                
                Divider()
                    .frame(width: (UIScreen.main.bounds.width * 0.8) - 30, height: 1)
                    .background(Color.white)
                
                Spacer()
                
                SunRotationView(percent: $viewModel.percent, iconImage: $viewModel.imageWeather)
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
        }
        .frame(width: UIScreen.main.bounds.width, height: 180)
        .onReceive(imageLoader.didChange) { data in
            viewModel.imageWeather = UIImage(data: data) ?? UIImage()
        }
    }
}

struct SunCardView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = SunCardViewModel(currentPercent: 80, isNight: true, sunsetText: "Sunset: 22 Hs", sunriseText: "Sunrise: 22 Hs", icon: "11n.png")
        SunCardView(viewModel: vm)
            .preferredColorScheme(.dark)
    }
}
