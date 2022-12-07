//
//  HomeViewModel.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation
import Combine

public typealias HomeNavigationAction = NavigationAction<HomeView>

public final class HomeViewModel: navigateToSearchCountry {
    
    // MARK: - Properties
    @Published public private(set) var navigationAction: HomeNavigationAction = .present(view: .root)
    
    // MARK: - life cycle
    public init() { }
    
    // MARK: - Methods
    public func uiPresented(view: HomeView) {
        navigationAction = .presented(view: view)
    }
    
    public func goToSearchCountry() {
        navigationAction = .present(view: .searchForCountry)
    }
}

// MARK: - Protocols that will called for Home View Controller
public protocol navigateToSearchCountry {
    func goToSearchCountry()
}
