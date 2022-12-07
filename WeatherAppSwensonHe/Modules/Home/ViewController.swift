//
//  ViewController.swift
//  WeatherAppSwensonHe
//
//  Created by Ali Alaa on 07/12/2022.
//

import UIKit
import CoreKit
import Combine

class ViewController: UIViewController {

    // MARK: - Properties
    let repo = ImplWeatherRepository(weatherAPI: ImplWeatherAPI())
    
    // Subscriptions
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        repo.getWeatherForecast(days: 3, cityName: "Egypt")
            .sink {
                switch $0 {
                case .finished: break
                case .failure(let error):
                    print("DEBUG: error happen now with: \(error)")
                }
            } receiveValue: {
                print("DEBUG: weather forecast back with data: \($0.current?.tempC)")
            }
            .store(in: &subscriptions)

    }


}

