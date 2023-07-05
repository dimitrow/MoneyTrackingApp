//
//  Expense.swift
//  Expenses
//
//  Created by Gene Dimitrow on 05.06.2023.
//

import Foundation

struct Expense: Identifiable {

    var id: UUID
    var amount: Double
    var isIncome: Bool = false
    var description: String?
    var timeStamp: Date
    var intervalID: UUID
}
