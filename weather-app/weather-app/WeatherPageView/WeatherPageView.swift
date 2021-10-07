//
//  WeatherPageView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

struct WeatherPageView: View {
    
    private var viewModel: WeatherPageViewModel
    
    init(weather: WeatherModel) {
        viewModel = WeatherPageViewModel(weather: weather)
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center) {
                TempCardView(viewModel: viewModel.getTempViewModel())
                    .frame(height: 160)
                
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
                        }
                    }
                }
            }.frame(width: proxy.size.width)

        }
    }

}

struct WeatherPageView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherPageView(weather: weatherFakes[0])
            .preferredColorScheme(.dark)
    }
}
