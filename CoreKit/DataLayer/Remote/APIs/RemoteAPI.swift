//
//  RemoteAPI.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation
import Alamofire
import Combine

public protocol RemoteAPI {
    func request<T: Codable>(_ request: RemoteService) -> Future<T, ErrorMessage>
}

extension RemoteAPI {
    private var session: Alamofire.Session {
        return Session.default
    }
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        return decoder
    }
    
    public func request<T: Codable>(_ request: RemoteService) -> Future<T, ErrorMessage> {
        return Future { promise in
            session.request(request)
                .response(completionHandler: { response in
                    print("DEBUG: request response is:\(request.urlRequest) --> \(String(data: response.data ?? Data(), encoding: .utf8))")
                    if response.response?.statusCode == 401 {
                        print("DEBUG: API KEY not provided")
                    }
                })
                .responseDecodable(of: T.self, decoder: JSONDecoder()) { response in
                    switch response.result {
                    case .success(let resultObject):
                        promise(.success(resultObject))
                    case .failure(let error):
                        print("DEBUG: error happened now is: \(String(describing: error))")
                        promise(.failure(ErrorMessage(error: error)))
                        print(error)
                    }
                }
        }
    }
}
