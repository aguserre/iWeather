//
//  MainViewModel.swift
//  weather-app
//
//  Created by Agustin Errecalde on 09/10/2021.
//

import SwiftUI
import CoreLocation
import Combine

final class MainViewModel: NSObject, ObservableObject {
    private let service = WeatherService()
    private let savedIds = WeatherModel.citySavedIds
    private var retrysCount = 0
    private let maxIntents = 3
    private var locationManager: CLLocationManager?
    private var publishers = [AnyPublisher<WeatherModel, Error>]()
    
    @Published private var coordinates: CLLocationCoordinate2D?
    @Published private var cancellable = Set<AnyCancellable>()
    @Published var resultStatus: ResultStatus = .none
    @Published var pageViewModels: [WeatherPageViewModel] = []
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = true
    @Published var alertButtonTitle: String = "Retry"

    override init() {
        super.init()
        setupLocationManager()
    }
    
    enum ResultStatus {
        case finished, none
    }
    
    func fetch() {
        getWeathers()
    }
    
    func alertButtonTapped() {
        isLoading = true
        retryIfNeeded()
    }
    
    private func retryIfNeeded() {
        resultStatus = .none
        retrysCount += 1
        setupButtonTitle()
        if retrysCount <= maxIntents {
            fetch()
        } else {
            setupErrorModelView()
        }
    }
    
    private func setupErrorModelView() {
        showAlert = false
        resultStatus = .none
        isLoading = false
    }
    
    private func setupButtonTitle() {
        alertButtonTitle = maxIntents == retrysCount ? "Ok" : "Retry"
    }
    
    private func setupWithError(description: String) {
        self.errorMessage = description
        self.showAlert = true
        self.resultStatus = .none
        self.isLoading = false
    }
    
}

extension MainViewModel {
    private func getWeathers() {
        fillPublishers {
            Publishers.Sequence(sequence: self.publishers)
                .compactMap { $0 }
                .flatMap { $0 }
                .map { WeatherPageViewModel(weather: $0) }
                .collect()
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.setupWithError(description: error.localizedDescription)
                    case .finished:
                        self.resultStatus = .finished
                        self.isLoading = false
                    }
                }, receiveValue: { pageViewModels in
                    self.pageViewModels = pageViewModels.sorted(by: { $0.isCurrentWeather && !$1.isCurrentWeather })
                    debugPrint(pageViewModels)
                })
                .store(in: &self.cancellable)
        }
    }
    
    private func fillPublishers(completion: @escaping ()->(Void)) {
        savedIds.forEach { id in
            publishers.append(service.getWeathersInfo(fetchType: .byId(id: id), metrics: .celcius))
        }
        
        if let location = coordinates {
            publishers.append(service.getWeathersInfo(fetchType: .coordinates(lon: location.longitude,
                                                                              lat: location.latitude),
                                                      metrics: .celcius))
        }
        completion()
    }
}

extension MainViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkPermissions()
    }
    
    private func setupLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            errorMessage = "Permiss not granted"
        }
    }
    
    private func checkPermissions() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            errorMessage = "Your locations is restricted"
            showAlert = true
        case .denied:
            errorMessage = "You have denied this app location permission. Go into settings to change it"
            showAlert = true
        case .authorizedAlways, .authorizedWhenInUse:
            guard let coordinates = locationManager.location?.coordinate else { return }
            self.coordinates = coordinates
        @unknown default:
            break
        }
    }
}
