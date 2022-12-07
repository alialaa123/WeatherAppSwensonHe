//
//  RequestConfiguration.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation
import Alamofire

public struct RequestConfiguration {
    
    // MARK: - Properties
    let path: String
    let method: HTTPMethod
    let headers: [HTTPHeader]?
    let parameters: Parameters?
    let encoding: ParameterEncoding
    let version: Int
    
    // MARK: - Methods
    internal init(method: HTTPMethod = .get,
                  path: String,
                  version: Int = 1,
                  headers: [HTTPHeader]? = nil,
                  parameters: Parameters? = nil,
                  encoding: ParameterEncoding = URLEncoding.default) {
        self.path = path
        self.version = version
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
    }
}
