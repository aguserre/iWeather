//
//  MainViewModel.swift
//  weather-app
//
//  Created by Agustin Errecalde on 09/10/2021.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    private let service = WeatherService()
    private let savedIds = ["2643743", "3441575", "3433955"]
    private var retrysCount = 0
    private let maxIntents = 3
    
    @Published private var cancellable = Set<AnyCancellable>()
    @Published var resultStatus: ResultStatus = .none
    @Published var pageViewModels: [WeatherPageViewModel] = []
    @Published var errorMessage: String = ""
    @Published var error: Error?
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = true
    @Published var alertButtonTitle: String = "Retry"

    enum ResultStatus {
        case finished, none
    }
    
    func fetch() {
        getWeathers()
    }
    
    func alertButtonTapped() {
        retryIfNeeded()
    }
    
    private func retryIfNeeded() {
        isLoading = true
        retrysCount += 1
        resultStatus = .none
        alertButtonTitle = maxIntents == retrysCount ? "Ok" : "Retry"
        if retrysCount <= maxIntents {
            fetch()
        } else {
            showAlert = false
            isLoading = false
            resultStatus = .none
        }
    }
    
    private func getWeathers() {
        let publishers = savedIds.map { id in
            self.service.getWeathersInfo(byId: id, metrics: .celcius)
        }
        Publishers.Sequence(sequence: publishers)
            .flatMap { $0 }
            .map { WeatherPageViewModel(weather: $0) }
            .collect()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.showAlert.toggle()
                    self.resultStatus = .none
                    self.isLoading = false
                case .finished:
                    self.resultStatus = .finished
                    self.isLoading = false
                }
            }, receiveValue: { val in
                self.pageViewModels = val
                self.resultStatus = .finished
                self.isLoading = false
            })
            .store(in: &cancellable)
    }
}
