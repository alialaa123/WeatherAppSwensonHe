//
//  Country.swift
//  CoreKit
//
//  Created by Ali Alaa on 08/12/2022.
//

import Foundation

public struct Country: Codable, Hashable {
    public let id: Int?
    public let name: String?
    public let region: String?
    
    public var longName: String? {
        return "\(name ?? "")" + " - " + "\(region ?? "")"
    }
}
