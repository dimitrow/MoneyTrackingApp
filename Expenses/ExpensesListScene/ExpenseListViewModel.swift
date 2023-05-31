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
    var timeStamp: Date

    var expenses: [Expense]?
}

protocol ExpenseListViewModelInput {

    func createNewInterval()
    func fetchIntervals()
}

protocol ExpenseListViewModelOutput {

    var fullExpensesAmount: String { get set }
    var currentInterval: Interval? { get }
}

protocol ExpenseListViewModelType: ExpenseListViewModelInput,
                                   ExpenseListViewModelOutput,
                                   ObservableObject {}

class ExpenseListViewModel: ExpenseListViewModelType {

    @Published var fullExpensesAmount: String = ""
    @Published var currentInterval: Interval?

    private let storageService: StorageServiceType

    init(storageService: StorageServiceType) {
        self.storageService = storageService
        self.currentInterval = self.storageService.fetchCurrentInterval()
    }

    func createNewInterval() {

        let interval = Interval(id: UUID(),
                                amount: 30000.0,
                                interval: 30,
                                timeStamp: Date())
        storageService.createInterval(interval)
    }

    func fetchIntervals() {
        _ = storageService.fetchAllIntervals()
    }
}
