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
        VStack(alignment: .center) {
            ZStack {
                HStack {
                    RemoteImage(type: .icon(iconId: viewModel.icon))
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                        .aspectRatio(contentMode: .fit)
                    
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width)
                
                .padding(.leading, 10)
                
                TempCardView(viewModel: viewModel.getTempViewModel())
                    .frame(height: 160)
            }
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 25) {
                    HStack(spacing: 10) {
                        GenericCard(viewModel: viewModel.getVisibilityCardViewModel())
                        
                        GenericCard(viewModel: viewModel.getWindCardViewModel())
                    }
                    
                    SunCardView(viewModel: viewModel.getSunCardViewModel())
                    
                    HStack(spacing: 10) {
                        GenericCard(viewModel: viewModel.getVisibilityCardViewModel())
                        
                        GenericCard(viewModel: viewModel.getWindCardViewModel())
                    }
                    
                    HStack(spacing: 10) {
                        PressureCardView(viewModel: viewModel.getPressureCardViewModel())
                        
                        GenericCard(viewModel: viewModel.getHumidityCardViewModel())
                    }
                    
                    MapCardView(viewModel: viewModel.getMapCardViewModel())
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }
}
