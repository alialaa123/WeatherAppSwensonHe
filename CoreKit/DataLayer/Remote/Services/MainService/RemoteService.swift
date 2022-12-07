//
//  RemoteService.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation
import Alamofire

public protocol RemoteService: URLRequestConvertible {
    var baseURL: String { get }
    var requestConfiguration: RequestConfiguration { get }
}

extension RemoteService {
    public func asURLRequest() throws -> URLRequest {
        let url = try ("https://" + baseURL).asURL()
            .appendingPathComponent("v\(requestConfiguration.version)/")
            .appendingPathComponent(requestConfiguration.path)
            .asURL()
        var request = URLRequest(url: url)
        request.httpMethod = requestConfiguration.method.rawValue
        request.setValue("Content-Type", forHTTPHeaderField: "application/json")
        if let parameters = requestConfiguration.parameters {
            request = try requestConfiguration.encoding.encode(request, with: parameters)
        }
        return request
    }
}
