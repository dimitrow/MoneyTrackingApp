//
//  ExpenseListViewModel.swift
//  Expenses
//
//  Created by Gene Dimitrow on 21.11.2022.
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

struct Interval: Identifiable {

    var id: UUID
    var amount: Double
    var interval: Int16

    var startDate: Date
    var endDate: Date

    var expenses: [Expense]
}

protocol ExpenseListViewModelOutput {

    var fullExpensesAmount: String { get set }
    var currentInterval: Interval? { get }
}

protocol ExpenseListViewModelType: ExpenseListViewModelOutput, ObservableObject {}

class ExpenseListViewModel: ExpenseListViewModelType {

    @Published var fullExpensesAmount: String = ""
    @Published var currentInterval: Interval?

    private let storageService: StorageServiceType

    init(storageService: StorageServiceType) {
        self.storageService = storageService
        self.currentInterval = self.storageService.fetchCurrentInterval()
    }
}
