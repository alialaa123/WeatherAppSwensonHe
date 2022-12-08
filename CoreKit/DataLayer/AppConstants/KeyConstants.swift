//
//  KeyConstants.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation

final class KeyConstants {
    
    // MARK: - Shared instance
    static let shared = KeyConstants()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Properties
    private(set) var WEATHER_KEY = "a27e6d308e564456abd221722220612"
    private(set) var UPDATE_CITY = "updateCity"
    
}
