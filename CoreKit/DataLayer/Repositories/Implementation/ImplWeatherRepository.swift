//
//  ImplWeatherRepository.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation
import Combine

public class ImplWeatherRepository: WeatherRepository {
    
    // MARK: - Properties
    let weatherAPI: WeatherAPI
    
    // Subscriptions
    var subscription = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    public init(weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
    }
    
    // MARK: - Methods
    public func getWeatherForecast(days: Int, cityName: String) -> Future<WeatherModel, ErrorMessage> {
        return self.weatherAPI.getWeather(days: days, cityName: cityName)
            .compactMap { return $0 }
            .asFuture()
    }
}
