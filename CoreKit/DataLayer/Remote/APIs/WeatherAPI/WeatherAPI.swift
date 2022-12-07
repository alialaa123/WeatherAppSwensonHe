//
//  WeatherAPI.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation
import Combine

public protocol WeatherAPI: RemoteAPI {
    func getWeather(days: Int, cityName: String) ->Future<WeatherModel, ErrorMessage>
}
