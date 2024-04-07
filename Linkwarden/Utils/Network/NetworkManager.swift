//
//  NetworkManager.swift
//  Linkwarden
//
//  Created by Abilash S on 10/03/24.
//

import Foundation
import APIManager


class NetworkManager {
    
    private static var session: Session? {
        get {
            Session.getSession()
        }
    }
    
    private static var baseURL: String? {
        get { session?.baseURL }
    }

    static var csrfToken: String? {
        get {
            session?.csrfToken
        }
    }
    
    static var csrfTokenCookie: String? {
        get {
            session?.csrfCookie
        }
    }
    
    static var sessionCookie: String? {
        get {
            session?.sessionCookie
        }
    }
    
    static var sessionExpiry: Date? {
        get {
            session?.sessionExpiry
        }
    }
    
    static var APIPath: String = "/api/v1"
    
}

extension NetworkManager {
    
    static func getBaseURL() -> String {
        guard let baseURL, !baseURL.isEmpty else {
            DispatchQueue.main.async {
                LinkwardenAppState.shared.didLoginFailed()
                LinkwardenAppState.shared.showToast(with: "Oops! Something unexpected occurred. You have been logged out. Please login again.")
            }
            LLogger.shared.critical("Base URL found to be empty or nil")
            return ""
        }
        return baseURL
    }
    
    static func setBaseURL(_ url: String) throws {
        session?.baseURL = url
        try DataManager.shared.context.save()
    }
    
}

extension NetworkManager {
   
    static func decode<T: Decodable>(_ type: T.Type, from data: Data, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> UsecaseResult<T, Error> {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy

            do {
                return .success(try decoder.decode(T.self, from: data))
            } catch DecodingError.keyNotFound(let key, let context) {
                return .failure(APINetworkError.processingError(status: APIErrorStatus.jsonDecoderFailed, message: "Failed to decode from data due to missing key '\(key.stringValue)' not found – \(context.debugDescription)", info: nil))
            } catch DecodingError.typeMismatch(_, let context) {
                return .failure(APINetworkError.processingError(status: APIErrorStatus.jsonDecoderFailed, message: "Failed to decode from data due to type mismatch – \(context.debugDescription)", info: nil))
            } catch DecodingError.valueNotFound(let type, let context) {
                return .failure(APINetworkError.processingError(status: APIErrorStatus.jsonDecoderFailed, message: "Failed to decode from data due to missing \(type) value – \(context.debugDescription)", info: nil))
            } catch DecodingError.dataCorrupted(_) {
                return .failure(APINetworkError.processingError(status: APIErrorStatus.jsonDecoderFailed, message: "Failed to decode from data because it appears to be invalid JSON", info: nil))
            } catch {
                return .failure(APINetworkError.processingError(status: APIErrorStatus.jsonDecoderFailed, message: "Failed to decode from data: \(error.localizedDescription)", info: nil))
            }
        }
    
}

