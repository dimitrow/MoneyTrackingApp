//
//  Expense.swift
//  Expenses
//
//  Created by Gene Dimitrow on 05.06.2023.
//

import Foundation

struct Expense: Identifiable {

    var id: UUID
    var amount: String
    var isIncome: Bool
    var description: String?

    var timeStamp: Date

    var interval: Interval
}
