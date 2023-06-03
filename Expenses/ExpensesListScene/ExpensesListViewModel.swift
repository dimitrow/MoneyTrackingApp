//
//  ExpensesListViewModel.swift
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

protocol ExpensesListViewModelInput {

    func createNewInterval()
    func fetchIntervals()
}

protocol ExpensesListViewModelOutput {

    var fullExpensesAmount: String { get set }
    var currentInterval: Interval? { get }
}

protocol ExpensesListViewModelType: ExpensesListViewModelInput, ExpensesListViewModelOutput, ObservableObject {}

class ExpensesListViewModel: ExpensesListViewModelType {

    @Published var fullExpensesAmount: String = ""
    @Published var currentInterval: Interval?

    private let storageService: StorageServiceType
    private let router: Router

    init(storageService: StorageServiceType,
         router: Router) {
        self.storageService = storageService
        self.router = router
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
        _ = storageService.isUserHasData()
//        _ = storageService.fetchAllIntervals()
    }
}
