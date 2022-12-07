//
//  ErrorMessage.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation
import Combine

public struct ErrorMessage: Error {
    
    var subsriptions = Set<AnyCancellable>()
    
    // MARK: - Properties
    public let id: UUID
    public var message: String
    public let errorCode: Int?
    
    // MARK: - Methods
    public init(message: String, errorCode: Int? = nil) {
        self.id = UUID()
        if errorCode == 1002 {
            self.message = "Please check your token."
        } else if errorCode == 1003 {
            self.message = "Please provide us with city name."
        } else if errorCode == 1005 {
            self.message = "Ops, something went wrong."
        } else if errorCode == 1006 {
            self.message = "No location found match your search"
        }  else {
            self.message = message
        }
        self.errorCode = errorCode
    }
    
    public init(error: Error) {
        self.id = UUID()
        self.message = error.localizedDescription
        self.errorCode = nil
    }
}

extension ErrorMessage: LocalizedError {
    public var errorDescription: String? {
        return message
    }
}
