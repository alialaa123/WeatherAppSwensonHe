//
//  CurrentWeatherCondition.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation

public struct CurrentWeatherCondition: Codable {
    
    public struct Condition: Codable {
        public let condition: String?
        public let icon: String?
        
        enum CodingKeys: String, CodingKey {
            case condition = "text"
            case icon
        }
    }
    
    public let tempC: Double?
    public let tempF: Double?
    public let condition: Condition?
    public let windInMph: Double?
    public let windInKph: Double?
    public let humidity: Double?
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
        case windInMph = "wind_mph"
        case windInKph = "wind_kph"
        case condition, humidity
    }
}
