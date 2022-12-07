//
//  MainService.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation

public protocol MainService: RemoteService {
    var mainRoute: String { get }
}

extension MainService {
    public var baseURL: String {
        return "api.weatherapi.com/"
    }
}
