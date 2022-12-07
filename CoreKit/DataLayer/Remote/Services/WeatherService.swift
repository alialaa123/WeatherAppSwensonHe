//
//  WeatherService.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation
import Alamofire

public enum WeatherService {
    case getWeatherForecast(days: Int, cityName: String)
}

extension WeatherService: MainService {
    public var mainRoute: String { return "forecast.json?" }
    
    public var requestConfiguration: RequestConfiguration {
        switch self {
        case let .getWeatherForecast(day, cityName):
            let parameter: Parameters = [
                "key": KeyConstants.shared.WEATHER_KEY,
                "q": cityName,
                "days": day,
                "aqi": false,
                "alerts": false
            ]
            return RequestConfiguration(method: .get,
                                        path: mainRoute,
                                        version: 1,
                                        parameters: parameter,
                                        encoding: URLEncoding.default)
        }
    }
}
