//
//  Response.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import Foundation

public struct Response<T: Codable>: Codable {
    
    // MARK: - Properties
    let data: T?
    let message: String?
    let errorCode: Int?
    let success: Bool
    
    private enum CodingKeys: String, CodingKey {
        case data, message, success
        case errorCode = "error"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            data = try container.decode(T.self, forKey: .data)
        } catch {
            data = nil
            switch error {
            case DecodingError.keyNotFound, DecodingError.valueNotFound: break
            default: throw error
            }
        }
        do {
            message = try container.decode(String.self, forKey: .message)
        } catch {
            message = nil
        }
        do {
            errorCode = try container.decode(Int.self, forKey: .errorCode)
        } catch {
            errorCode = nil
        }
        success = ((try? container.decode(Bool.self, forKey: .success)) ?? true)
    }
}
