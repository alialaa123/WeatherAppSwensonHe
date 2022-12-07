//
//  WeatherRepository.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation
import Combine

public protocol WeatherRepository {
    func getWeatherForecast(days: Int, cityName: String) -> Future<WeatherModel, ErrorMessage>
}
