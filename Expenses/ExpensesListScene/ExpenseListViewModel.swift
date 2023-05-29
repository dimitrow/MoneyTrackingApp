//
//  ExpenseListViewModel.swift
//  Expenses
//
//  Created by Gene Dimitrow on 21.11.2022.
//

import Foundation

struct ExpenseModel: Identifiable {

    var id: UUID = UUID()
    var amount: String
    var numberAmount: Double

    init() {
        self.numberAmount = Double.random(in: 0.5 ..< 20.0)
        self.amount = String(format: "%.2f", self.numberAmount)
    }
}

class ExpenseListViewModel: ObservableObject {

    @Published var fullExpensesAmount: String = ""
    @Published var expenses: [ExpenseModel]

    init() {

        var exp: [ExpenseModel] = []

        for _ in 0...20 {
            exp.append(ExpenseModel())
        }
        expenses = exp
    }
}
