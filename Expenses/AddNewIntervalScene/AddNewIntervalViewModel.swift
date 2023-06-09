//
//  AddNewIntervalViewModel.swift
//  Expenses
//
//  Created by Gene Dimitrow on 04.06.2023.
//

import SwiftUI
import Combine

let defaultIntervalDuration: Double = 30

protocol AddNewIntervalViewModelInput {}

protocol AddNewIntervalViewModelOutput {

    var alertTitle: String { get set }
    var alertMessage: String { get set }

    var intervalDuration: String { get set }
    var isIntervalDataValid: Bool { get set }
    var amount: String { get set }
    var durationBinding: Binding<Double> { get }
    var dailyExpense: String { get set }
    var showErrorAlert: Bool { get set }
    var showErrorAlertBinding: Binding<Bool> { get }
}

protocol AddNewIntervalViewModelType: AddNewIntervalViewModelInput, AddNewIntervalViewModelOutput, KeyboardDelegate, ObservableObject {}

class AddNewIntervalViewModel: AddNewIntervalViewModelType {

    private let storageService: StorageServiceType
    private var router: Router

    var alertTitle: String = ""
    var alertMessage: String = ""

    @Published var intervalDuration: String = ""
    @Published var isIntervalDataValid: Bool = false
    @Published var amount: String = "0"
    @Published var dailyExpense: String = "0"

    @Published private var duration: Double = defaultIntervalDuration
    var durationBinding: Binding<Double> {
        Binding {
            self.duration
        } set: { duration in
            self.duration = duration
        }
    }

    @Published var showErrorAlert: Bool = false
    var showErrorAlertBinding: Binding<Bool> {
        Binding {
            self.showErrorAlert
        } set: { value in
            self.showErrorAlert = value
        }
    }

    private var durationPublisher: AnyPublisher<String, Never> {
        $duration
            .map { duration in
                return String(format: "%.0f", duration)
            }
            .eraseToAnyPublisher()
    }

    private var dailyExpensePublisher: AnyPublisher<String, Never> {
        Publishers.CombineLatest($intervalDuration, $amount)
            .map{ duration, amount in

                guard let durationInt = Int(duration), let amountInt = Int(amount) else {
                    return "0"
                }
                let daylyExpense = amountInt / durationInt

                return "\(daylyExpense)"
            }
            .eraseToAnyPublisher()
    }

    init(storageService: StorageServiceType, router: Router) {
        self.storageService = storageService
        self.router = router

        durationPublisher
            .receive(on: RunLoop.main)
            .assign(to: &$intervalDuration)
        dailyExpensePublisher
            .receive(on: RunLoop.main)
            .assign(to: &$dailyExpense)
    }

    private func createNewInterval() {

        guard let newIntervalAmount = Double(amount),
                let newIntervalDuration = Int16(intervalDuration) else {
            showAlert(with: .missingIntervalData)
            return
        }

        if newIntervalAmount == 0 {
            showAlert(with: .zeroAmount)
            return
        }

        if newIntervalAmount < Double(newIntervalDuration) {
            showAlert(with: .tooSmallAmount)
            return
        }

//        let interval = Interval(id: UUID(),
//                                amount: newIntervalAmount,
//                                duration: newIntervalDuration,
//                                timeStamp: Date())
//        storageService.createInterval(interval)
    }

    private func showAlert(with error: AppErrors) {
        alertTitle = error.errorDescription.title
        alertMessage = error.errorDescription.message
        showErrorAlert = true
    }

    //MARK: - Keyboard Delegate:

    func updateAmount(_ value: String) {
        if amount == "0" {
            amount = ""
        }
        amount += value
    }

    func removeLast() {
        if amount.count == 1 {
            amount = "0"
            return
        }
        _ = amount.removeLast()
    }

    func clearAll() {
        amount = ""
    }

    func submit() {
        createNewInterval()
    }
}
