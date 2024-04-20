//
//  LError.swift
//  Linkwarden
//
//  Created by Abilash S on 10/03/24.
//

import Foundation
import APIManager


enum LError: Error {
    // Usecase
    case UnImplementedUsecase
    
    // Datamanager
    case NoLocalDataManager
}

extension LError {
    
    var description: String {
        switch self {
            // Usecase
        case .UnImplementedUsecase:
            "Usecase is called without implementing any logic. Rather than using the Usecase Object subclass it and override run()"
            
            // Datamanager
        case .NoLocalDataManager:
            "Local Datamanager is not available"
            
        }
    }
    
}

// TODO: ZVZV Create a Error Message class in APIManager
struct LErrorMessage {
    public static let No_Network_Error_Message =  "No internet"
    public static let Invalid_URL_String = "Conversion from string to URL failed"
    public static let Invalid_JSON_Key = "Tried to retrive a JSON value with invalid JSON key"
    public static let Invalid_JSON_Process = "Couldn't covert the received response data to JSON"
    public static let Invalid_Response_Code = "Received response code other than 200"
    public static let Invalid_Image_Data = "Couldn't convert data to UIImage"
    public static let UnknownError = "Somthing went wrong"
}

extension APIErrorStatus {
    static let invalidURLString = "INVALID_URL_STRING"
    static let invalidJSONResponse = "INVALID_JSON_PROCESS"
    static let invalidJSONKey = "INVALID_JSON_KEY"
    static let invalidResponseCode = "INVALID_RESPONSE_CODE"
    static let jsonDecoderFailed = "JSON_DECODER_FAILED"
    static let invalidImageData = "INVALID_IMAGE_DATA"
}

public let No_Network_API_Error = APINetworkError.apiManagerError(status: APIErrorStatus.noInternetConnection, message: LErrorMessage.No_Network_Error_Message, info: nil)
