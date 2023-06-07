//
//  ExpensesListViewModel.swift
//  Expenses
//
//  Created by Gene Dimitrow on 21.11.2022.
//

import Foundation

protocol ExpensesListViewModelInput {

    func addRecord()
}

protocol ExpensesListViewModelOutput {

    var fullExpensesAmount: String { get set }
    var currentInterval: Interval? { get }

    func fetchIntervals()
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

    func fetchIntervals() {

    }

    func addRecord() {

    }
}
