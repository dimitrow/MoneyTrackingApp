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

    var spentToday: String { get set }
    var leftover: String { get set }
    var pastExpenses: [DailyExpenses] { get }
    var spendingProgressBinding: Binding<Double> { get }
    var intervalAmount: String { get set }
    var spentInTotal: String { get set }
    var dailyLimit: String { get }
    var saved: String { get }
    var isUserSaving: Bool { get }
    var interval: Interval { get }
}

protocol ExpensesListViewModelType: ExpensesListViewModelInput, ExpensesListViewModelOutput, KeyboardDelegate, ObservableObject {}

class ExpensesListViewModel: ExpensesListViewModelType {

    @Published var amount: String = "0"
    @Published var spentToday: String = "0.00"
    @Published var intervalAmount: String = ""
    @Published var spentInTotal: String = ""
    @Published var leftover: String = ""

    @Published var spendingProgress: Double = 0.0
    var spendingProgressBinding: Binding<Double> {
        Binding {
            self.spendingProgress
        } set: { duration in
            self.spendingProgress = duration
        }
    }

    var isUserSaving: Bool = true
    var saved: String = "0.00"
    var dailyLimit: String = ""
    var pastExpenses: [DailyExpenses] = []

    private var previousExpenses = 0.0
    var interval: Interval

    private let storageService: StorageServiceType
    private let router: Router
    private var disposables = Set<AnyCancellable>()

    init(storageService: StorageServiceType,
         router: Router) {
        self.storageService = storageService
        self.router = router
        self.interval = self.storageService.fetchCurrentInterval()

        updateData(for: self.interval)
        observeInterval()
    }

    private func observeInterval() {
        storageService
            .intervalUpdated
            .sink { [weak self] _ in
                guard let self = self else { return }
                let interval = self.storageService.fetchCurrentInterval()
                self.updateData(for: interval)
            }
            .store(in: &disposables)
    }

    private func updateData(for updatedInterval: Interval) {
        interval = updatedInterval
        pastExpenses = interval.pastExpenses
        previousExpenses = calculateExpenses(interval.pastExpenses.flatMap({$0.expenses}))

        let todayExpenses = calculateExpenses(interval.currentExpenses)
        spentToday = String(format: "%.2f", todayExpenses)
        intervalAmount = String(format: "%.2f", interval.amount)
        spentInTotal = String(format: "%.2f", todayExpenses + previousExpenses)
        dailyLimit = String(format: "%.2f", interval.dailyLimit)
        spendingProgress = (todayExpenses + previousExpenses) / interval.amount
        leftover = String(format: "%.2f", interval.amount - todayExpenses - previousExpenses)
        determineSavings(for: interval)
    }

    private func calculateExpenses(_ expenses: [Expense]) -> Double {
        let fullExpenses = expenses.reduce(0.0, { (result, expense) -> Double in
            result + expense.amount
        })
        return fullExpenses
    }

    private func determineSavings(for interval: Interval) {
        guard let daysPassed = Date().since(interval.timeStamp, in: .day) else {
            return
        }
        let grantedAmount = interval.dailyLimit * Double(daysPassed)
        let savings = grantedAmount - previousExpenses
        saved = String(format: "%.2f", abs(savings))
        isUserSaving = savings > 0 ? true : false
    }

    func addRecord() {
//        to mock previous expense:
//        guard let timeStamp = Date().offset(.day, value: -4) else {
//            fatalError()
//        }

        let expense = Expense(id: UUID(),
                              amount: Double(amount) ?? 0.0,
                              timeStamp: Date(),
                              intervalID: interval.id)
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
