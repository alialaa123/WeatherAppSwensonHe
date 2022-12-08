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
    case getSearchedCountries(query: String)
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
            
        case let .getSearchedCountries(query):
            let parameter: Parameters = [
                "key": KeyConstants.shared.WEATHER_KEY,
                "q": query,
            ]
            return RequestConfiguration(method: .get,
                                        path: "search.json?",
                                        version: 1,
                                        parameters: parameter,
                                        encoding: URLEncoding.default)
        }
    }
}
