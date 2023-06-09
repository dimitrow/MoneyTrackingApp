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

    var errorDescription: AlertReadyError {
        switch self {
        case .missingIntervalData:
            return AlertReadyError(title:"Error", message: "Missing data needed for interval creation")
        }
    }
}
