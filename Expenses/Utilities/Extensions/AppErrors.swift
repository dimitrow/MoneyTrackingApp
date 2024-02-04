//
//  AppErrors.swift
//  Expenses
//
//  Created by Gene Dimitrow on 09.06.2023.
//

import Foundation

typealias AlertErrorDescription = (title: String, message: String)

enum AppError: Error {

    case missingIntervalData
    case zeroAmount
    case tooSmallAmount

    var errorDescription: AlertErrorDescription {
        switch self {
        case .missingIntervalData:
            return AlertErrorDescription(title: "Error",
                                   message: "Data needed for interval creation is missed")
        case .zeroAmount:
            return AlertErrorDescription(title: "Error",
                                   message: "Expected Amount should be more than zero")
        case .tooSmallAmount:
            return AlertErrorDescription(title: "Error",
                                   message: "Amount should be at least the same as interval duration")
        }
    }
}

enum DatabaseServiceError: Error {
    case intervalFetchError
    case entitySaveError
}
