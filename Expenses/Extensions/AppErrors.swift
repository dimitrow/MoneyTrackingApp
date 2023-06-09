//
//  AppErrors.swift
//  Expenses
//
//  Created by Gene Dimitrow on 09.06.2023.
//

import Foundation

typealias AlertReadyError = (title: String, message: String)

enum AppErrors: Error {

    case missingIntervalData
    case zeroAmount
    case tooSmallAmount

    var errorDescription: AlertReadyError {
        switch self {
        case .missingIntervalData:
            return AlertReadyError(title: "Error",
                                   message: "Data needed for interval creation is missed")
        case .zeroAmount:
            return AlertReadyError(title: "Error",
                                   message: "Expected Amount should be more than zero")
        case .tooSmallAmount:
            return AlertReadyError(title: "Error",
                                   message: "Amount should be at least the same as interval duration")
        }
    }
}
