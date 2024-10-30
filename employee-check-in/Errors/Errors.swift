//
//  Errors.swift
//  employee-check-in
//
//  Created by Jerald Allen Abille on 10/31/24.
//

import Foundation

enum CheckInError: Error, LocalizedError {
    case dateCannotBeFutureDate
    case unableToCheckIn
    case somethingWentWrong
    
    var errorDescription: String? {
        switch self {
        case .dateCannotBeFutureDate:
            "Check-in date cannot be in the future."
        case .unableToCheckIn:
            "Unable to check-in. Please try again."
        case .somethingWentWrong:
            "Something went wrong. Please try again."
        }
    }
}
