//
//  LError.swift
//  Linkwarden
//
//  Created by Abilash S on 10/03/24.
//

import Foundation


enum LError: Error {
    case UnImplementedUsecase
}

extension LError {
    
    var description: String {
        switch self {
        case .UnImplementedUsecase:
            "Usecase is called without implementing any logic. Rather than using the Usecase Object subclass it and override run()"
        }
    }
    
}
