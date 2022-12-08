//
//  HomeView.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation

public enum HomeView: Equatable {
    
    // MARK: - Views type
    case root
    case searchForCountry
    
    // MARK: - for Navigation bar
    public func hidesNavigationBar() -> Bool {
        switch self {
        case .root: return true
        case .searchForCountry: return true
        }
    }
}
