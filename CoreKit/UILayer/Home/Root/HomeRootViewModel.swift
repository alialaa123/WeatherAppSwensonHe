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
    private let erroMessageSubject = PassthroughSubject<ErrorMessage, Never>()
    public var errorMessage: AnyPublisher<ErrorMessage, Never> {
        erroMessageSubject.eraseToAnyPublisher()
    }
    
    private let forecastWeatherDataSubject = PassthroughSubject<WeatherModel, Never>()
    public var forecastWeatherData: AnyPublisher<WeatherModel, Never> {
        forecastWeatherDataSubject.eraseToAnyPublisher()
    }
    
    // State
    var subscriptions = Set<AnyCancellable>()
    var locationManager: LocationManager
    
    private let repository: WeatherRepository
    
    // MARK: - Life cycle
    public init(repository: WeatherRepository, locationManager: LocationManager) {
        self.repository = repository
        self.locationManager = locationManager
        getUserCurrentLocation()
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
                    strongSelf.erroMessageSubject.send(error)
                }
            } receiveValue: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.forecastWeatherDataSubject.send($0)
                print("DEBUG: weather forecast back with data: \($0.current?.tempC)")
            }
            .store(in: &subscriptions)
    }

}
