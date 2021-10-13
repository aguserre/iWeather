//
//  MainView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 09/10/2021.
//

import SwiftUI

struct MainView: View {

    @ObservedObject private var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            if viewModel.resultStatus == .finished {
                WeatherView(viewModel: viewModel.weatherViewModel)
            } else {
                WeatherView(viewModel: WeatherModel.placeHolder)
            }
            
            if viewModel.isLoading {
                LoadingOverlaySUI()
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text(viewModel.alertButtonTitle), action: {
                    viewModel.alertButtonTapped()
                })
            )
        }
    }
}
