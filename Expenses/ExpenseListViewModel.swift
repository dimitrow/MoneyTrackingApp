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

    init() {
        self.amount = String(format: "%.2f", Double.random(in: 0.5 ..< 20.0))
    }
}

class ExpenseListViewModel: ObservableObject {

    @Published var expense: String = ""
    @Published var expenses: [ExpenseModel]

    init() {

        var exp: [ExpenseModel] = []

        for _ in 0...20 {
            exp.append(ExpenseModel())
        }
        expenses = exp
    }
}
