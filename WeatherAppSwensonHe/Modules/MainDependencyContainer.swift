//
//  MainDependencyContainer.swift
//  WeatherAppSwensonHe
//
//  Created by Ali Alaa on 07/12/2022.
//

import UIKit
import CoreKit

class MainDependencyContainer {
    
    // MARK: - Properties
    private let sharedHomeViewModel: HomeViewModel
    private let sharedLocationManager: LocationManager
    
    
    // MARK: - Life cycle
    public init() {
        func makeHomeViewModel() -> HomeViewModel {
            return HomeViewModel()
        }
        
        func makeLocationManager() -> LocationManager {
            return LocationManager()
        }
        
        self.sharedHomeViewModel = makeHomeViewModel()
        self.sharedLocationManager = makeLocationManager()
        
    }
    
    // MARK: - Methods
    public func makeHomeViewController() -> HomeViewController {
        
        let searchViewControllerFactory = { () -> SearchViewController in
            return self.makeSearchViewController()
        }
        
        return HomeViewController(viewModel: sharedHomeViewModel,
                                  rootViewController: makeHomeRootViewController(),
                                  searchViewControllerFactory: searchViewControllerFactory)
    }
    
    // MARK: - Home Root view controller
    private func makeHomeRootViewController() -> HomeRootViewController {
        return HomeRootViewController(customView: HomeRootView(),
                                      viewModel: makeHomeRootViewModel())
    }
    
    private func makeHomeRootViewModel() -> HomeRootViewModel {
        return HomeRootViewModel(repository: makeWeatherRepository(),
                                 locationManager: sharedLocationManager,
                                 navigateToSearch: sharedHomeViewModel)
    }
    
    private func makeWeatherRepository() -> WeatherRepository {
        return ImplWeatherRepository(weatherAPI: ImplWeatherAPI())
    }
    
    // MARK: - Search view controller
    private func makeSearchViewController() -> SearchViewController {
        return SearchViewController(customView: SearchView(), viewModel: makeSearchViewModel())
    }
    
    private func makeSearchViewModel() -> SearchViewModel {
        return SearchViewModel(repository: makeWeatherRepository())
    }
    
    
}
