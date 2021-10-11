//
//  WeatherPageView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

struct WeatherPageView: View {
    
    private var viewModel: WeatherPageViewModel
    
    init(viewModel: WeatherPageViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center) {
                ZStack {
                    HStack {
                        RemoteImage(type: .icon(iconId: viewModel.icon))
                            .frame(width: proxy.size.width / 3, height: proxy.size.width / 3)
                            .aspectRatio(contentMode: .fit)
                        
                        Spacer()
                    }.frame(width: proxy.size.width)
                    
                    .padding(.leading, 10)
                    
                    TempCardView(viewModel: viewModel.getTempViewModel())
                        .frame(height: 160)
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 25) {
                        HStack(spacing: 10) {
                            SmallCardView(viewModel: viewModel.getVisibilityCardViewModel())
                            
                            SmallCardView(viewModel: viewModel.getWindCardViewModel())
                        }
                        
                        SunCardView(viewModel: viewModel.getSunCardViewModel())
                        
                        HStack(spacing: 10) {
                            SmallCardView(viewModel: viewModel.getVisibilityCardViewModel())
                            
                            SmallCardView(viewModel: viewModel.getWindCardViewModel())
                        }
                        
                        HStack(spacing: 10) {
                            PressureCardView(viewModel: viewModel.getPressureCardViewModel())
                            
                            SmallCardView(viewModel: viewModel.getHumidityCardViewModel())
                        }
                        
                        MapCardView(viewModel: viewModel.getMapCardViewModel())
                    }
                }
            }.frame(width: proxy.size.width)
        }
    }
}
