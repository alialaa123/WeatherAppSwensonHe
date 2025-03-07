//
//  WeatherModel.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation

public struct WeatherModel: Codable {
    
    public let location: Location?
    public let current: CurrentWeatherCondition?
    public let forecast: Forecast?
    
    enum CodingKeys: String, CodingKey {
        case location, current, forecast
    }
}
