//
//  MainView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 09/10/2021.
//

import SwiftUI
import Combine

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

enum CustomError: String {
    case unexpected = "Unexpected Error"
    case restricted = "Your locations is restricted"
    case denied = "You have denied this app location permission. Go into settings to change it"
    case serviceError = "Connection Error"
}
