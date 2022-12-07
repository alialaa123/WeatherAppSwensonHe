//
//  ImplWeatherAPI.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation
import Combine

public class ImplWeatherAPI: WeatherAPI {
    
    // MARK: - Life cycle
    public init() { }
    
    // MARK: - Methods
    public func getWeather(days: Int, cityName: String) -> Future<WeatherModel, ErrorMessage> {
        request(WeatherService.getWeatherForecast(days: days, cityName: cityName))
    }
    
}
