//
//  Forecast.swift
//  CoreKit
//
//  Created by Ali Alaa on 08/12/2022.
//

import Foundation

public struct Forecast: Codable {
    public let forecastday: [Forecastday]?
}

public struct Forecastday: Codable {
    public let day: CurrentWeatherCondition?
}
