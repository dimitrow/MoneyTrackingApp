//
//  Interval.swift
//  Expenses
//
//  Created by Gene Dimitrow on 05.06.2023.
//

import Foundation

struct Interval: Identifiable {

    var id: UUID
    var amount: Double
    var interval: Int16
    var timeStamp: Date

    var expenses: [Expense]?
}
