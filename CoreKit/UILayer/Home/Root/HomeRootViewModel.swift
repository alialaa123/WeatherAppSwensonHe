//
//  HomeRootViewModel.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation
import Combine

public final class HomeRootViewModel {
    
    // MARK: - Properties
    // State
    @Published public private(set) var isLoading = false
    @Published public private(set) var userLocation = ""
    
    // Subjects
    public let errorPresentation = PassthroughSubject<ErrorPresentation?, Never>()
    private let errorMessageSubject = PassthroughSubject<ErrorMessage, Never>()
    public var errorMessage: AnyPublisher<ErrorMessage, Never> {
        errorMessageSubject.eraseToAnyPublisher()
    }
    
    private let errorMessageSubjectss = PassthroughSubject<String, Never>()
    public var errorMessagess: AnyPublisher<String, Never> {
        errorMessageSubjectss.eraseToAnyPublisher()
    }
    
    private let forecastWeatherDataSubject = PassthroughSubject<WeatherModel, Never>()
    public var forecastWeatherData: AnyPublisher<WeatherModel, Never> {
        forecastWeatherDataSubject.eraseToAnyPublisher()
    }
    
    // State
    var subscriptions = Set<AnyCancellable>()
    var locationManager: LocationManager
    
    private let repository: WeatherRepository
    private let navigateToSearch: navigateToSearchCountry
    
    // MARK: - Life cycle
    public init(repository: WeatherRepository,
                locationManager: LocationManager,
                navigateToSearch: navigateToSearchCountry) {
        self.repository = repository
        self.locationManager = locationManager
        self.navigateToSearch = navigateToSearch
        
        getUserCurrentLocation()
        subscribeToUpdateCitySelectedNotification()
    }
    
    // MARK: - Methods
    private func getUserCurrentLocation() {
        locationManager.userCurrentCity
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                switch $0 {
                case .finished: break
                case .failure(let error):
                    print("DEBUG: error happened in get city name: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.userLocation = $0
                strongSelf.getForecastWeather(cityName: strongSelf.userLocation)
            })
            .store(in: &subscriptions)
    }
    
    
    private func getForecastWeather(cityName: String) {
        isLoading = true
        repository.getWeatherForecast(days: 3, cityName: cityName)
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                switch $0 {
                case .finished: break
                case .failure(let error):
                    print("DEBUG: error happen now with: \(error)")
                    strongSelf.errorMessageSubject.send(error)
                }
            } receiveValue: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.forecastWeatherDataSubject.send($0)
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Selectors
    @objc
    public func gotoSearchView() {
        navigateToSearch.goToSearchCountry()
    }
    
    // MARK: - Listening to city search
    private func subscribeToUpdateCitySelectedNotification() {
        NotificationCenter.default.publisher(
            for: Notification.Name(KeyConstants.shared.UPDATE_CITY),
            object: nil)
            .sink { [weak self] in
                guard let strongSelf = self, let city = $0.object as? String else { return }
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                    strongSelf.getForecastWeather(cityName: city)
                }
            }.store(in: &subscriptions)
    }
}
