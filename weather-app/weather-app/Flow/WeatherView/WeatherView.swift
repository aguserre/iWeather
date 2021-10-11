//
//  HomeView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 05/10/2021.
//

import SwiftUI
import SpriteKit

struct WeatherView: View {
    
    @ObservedObject private var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color(viewModel.pageViewModels[viewModel.getIndex()].backgroundColor)
                .animation(.easeInOut, value: viewModel.getIndex())
                .edgesIgnoringSafeArea(.all)

            SceneSelectorView(condition: viewModel.pageViewModels[viewModel.getIndex()].weatherMainStatus)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            GeometryReader { proxy in
                VStack {
                    OffsetPageTabView(offset: $viewModel.offset) {
                        HStack(spacing: 0) {
                            ForEach(viewModel.pageViewModels, id: \.id) { viewModel in
                                WeatherPageView(viewModel: viewModel)
                                    .frame(width: proxy.size.width, height: proxy.size.height - 30)
                            }
                        }
                    }
                    HStack(alignment: .center, spacing: 11) {
                        ForEach(viewModel.pageViewModels.indices, id: \.self) { index in
                            if viewModel.pageViewModels[index].isCurrentWeather {
                                Image(systemName: "location")
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(viewModel.isSelected(index: index) ? Color(UIColor.systemIndigo) : .white)
                                    .frame(width: viewModel.isSelected(index: index) ? 15 : 10, height: viewModel.getIndex() == index ? 15 : 10)
                            } else {
                                Circle()
                                    .foregroundColor(viewModel.isSelected(index: index) ? Color(UIColor.systemIndigo) : .white)
                                    .frame(width: viewModel.getIndex() == index ? 15 : 7, height: viewModel.getIndex() == index ? 15 : 7)
                            }
                        }
                    }
                    .frame(height: 15)
                    .animation(.default)
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .frame(height: proxy.size.height)
            }
        }
    }
}