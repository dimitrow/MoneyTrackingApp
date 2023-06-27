//
//  ExpensesListViewModel.swift
//  Expenses
//
//  Created by Gene Dimitrow on 21.11.2022.
//

import Foundation
import SwiftUI
import Combine

protocol ExpensesListViewModelInput {

    func addRecord()
    func navigateToExpenseDetails(_ expense: DailyExpenses)
    func removeRecord(_ expense: Expense)
}

protocol ExpensesListViewModelOutput {

    var todayExpensesAmount: String { get set }
    var pastExpenses: [DailyExpenses] { get }

    var currentIntervalAmount: String { get set }
    var fullExpenses: String { get set }
    var dailyLimit: String { get }
    var saved: String { get }
    var isUserSaving: Bool { get }
    var currentInterval: Interval { get }
}

protocol ExpensesListViewModelType: ExpensesListViewModelInput, ExpensesListViewModelOutput, KeyboardDelegate, ObservableObject {}

class ExpensesListViewModel: ExpensesListViewModelType {

    @Published var amount: String = "0"
    @Published var todayExpensesAmount: String = "0.00"
    @Published var currentIntervalAmount: String = ""
    @Published var fullExpenses: String = ""

    var isUserSaving: Bool = false
    var saved: String = "0.00"
    var dailyLimit: String = ""
    var pastExpenses: [DailyExpenses] = []

    private var pastExpensesAmount = 0.0
    var currentInterval: Interval

    private let storageService: StorageServiceType
    private let router: Router
    private var disposables = Set<AnyCancellable>()

    init(storageService: StorageServiceType,
         router: Router) {
        self.storageService = storageService
        self.router = router
        self.currentInterval = self.storageService.fetchCurrentInterval()

        updateData(for: self.currentInterval)
        observeInterval()
    }

    private func observeInterval() {
        storageService
            .intervalUpdated
            .sink { [weak self] _ in
                if let interval = self?.storageService.fetchCurrentInterval() {
                    self?.currentInterval = interval
                    self?.updateData(for: interval)
                }
            }
            .store(in: &disposables)
    }

    private func updateData(for interval: Interval) {
        self.pastExpenses = interval.pastExpenses
        self.pastExpensesAmount = calculateExpenses(interval.pastExpenses.flatMap({$0.expenses}))
        let todayExpenses = calculateExpenses(interval.currentExpenses)
        self.todayExpensesAmount = String(format: "%.2f", todayExpenses)
        self.currentIntervalAmount = String(format: "%.2f", currentInterval.amount)
        self.fullExpenses = String(format: "%.2f", todayExpenses + self.pastExpensesAmount)
        self.dailyLimit = String(format: "%.2f", currentInterval.dailyLimit)
        determineSavings()
    }

    private func calculateExpenses(_ expenses: [Expense]) -> Double {
        let fullExpenses = expenses.reduce(0.0, { (result, expense) -> Double in
            result + expense.amount
        })
        return fullExpenses
    }

    private func determineSavings() {
        let daysPassed = Double(pastExpenses.count)
        let grantedAmount = currentInterval.dailyLimit * daysPassed
        let savings = grantedAmount - pastExpensesAmount
        self.saved = String(format: "%.2f", savings)
        self.isUserSaving = savings > 0 ? true : false
    }

    func addRecord() {

//        guard let timeStamp = Date().offset(.day, value: -4) else {
//            fatalError()
//        }

        let expense = Expense(id: UUID(),
                              amount: Double(amount) ?? 0.0,
                              timeStamp: Date(),
                              intervalID: currentInterval.id)
        storageService.createRecord(expense)
    }

    func submit() {
        addRecord()
        clearAmount()
    }
    
    func navigateToExpenseDetails(_ expense: DailyExpenses) {
        router.push(to: .expenseDetails(item: expense))
    }

    func removeRecord(_ expense: Expense) {
        
    }
}
