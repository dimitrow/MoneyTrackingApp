//
//  DailyExpenses.swift
//  Expenses
//
//  Created by Gene Dimitrow on 22.06.2023.
//

import Foundation

struct DailyExpenses: Identifiable {
    var id: UUID
    let timeStamp: Date
    var dailyAmount: Double
    var expenses: [Expense] = []
}
