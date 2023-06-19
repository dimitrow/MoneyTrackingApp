//
//  AddNewIntervalViewModel.swift
//  Expenses
//
//  Created by Gene Dimitrow on 04.06.2023.
//

import SwiftUI
import Combine

let defaultIntervalDuration: Double = 30

protocol AddNewIntervalViewModelInput {
    func confirmIntervalCreation()
    func routeToExpensesList()
}

protocol AddNewIntervalViewModelOutput {

    var interval: Interval? { get set }
    var alertTitle: String { get set }
    var alertMessage: String { get set }

    var intervalDuration: String { get set }
    var isIntervalDataValid: Bool { get set }
    var durationBinding: Binding<Double> { get }
    var dailyExpense: String { get set }
    var showErrorAlert: Bool { get set }
    var showErrorAlertBinding: Binding<Bool> { get }
    var showConfirmationAlert: Bool { get set }
    var showConfirmationAlertBinding: Binding<Bool> { get }
}

protocol AddNewIntervalViewModelType: AddNewIntervalViewModelInput, AddNewIntervalViewModelOutput, KeyboardDelegate,  ObservableObject {}

class AddNewIntervalViewModel: AddNewIntervalViewModelType {

    private let storageService: StorageServiceType
    private var router: Router

    var interval: Interval?

    @Published var amount: String = "0"

    var alertTitle: String = ""
    var alertMessage: String = ""

    @Published var intervalDuration: String = ""
    @Published var isIntervalDataValid: Bool = false
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

    @Published var showConfirmationAlert: Bool = false
    var showConfirmationAlertBinding: Binding<Bool> {
        Binding {
            self.showConfirmationAlert
        } set: { value in
            self.showConfirmationAlert = value
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

                guard let durationDouble = Double(duration), let amountDouble = Double(amount) else {
                    return "0"
                }
                let daylyExpense = amountDouble / durationDouble

                return String(format: "%.2f", daylyExpense)
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

    //MARK: - Private

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

        let calendar = Calendar.current
        let timeStamp = Date()
        let startDate = calendar.startOfDay(for: timeStamp)
        let endDate = startDate.addingTimeInterval(3600 * 24 * Double(newIntervalDuration + 1))

        interval = Interval(id: UUID(),
                            amount: newIntervalAmount,
                            duration: newIntervalDuration,
                            timeStamp: Date(),
                            startDate: startDate,
                            endDate: endDate)

        showConfirmationAlert = true
    }


    private func showAlert(with error: AppError) {
        alertTitle = error.errorDescription.title
        alertMessage = error.errorDescription.message
        showErrorAlert = true
    }

    //MARK: - ViewModel Input

    func confirmIntervalCreation() {
        guard let interval = interval else {
            showAlert(with: .missingIntervalData)
            return
        }
        storageService.createInterval(interval) { [weak self] in
            self?.routeToExpensesList()
        }
    }

    func routeToExpensesList() {
        router.setInitial(scene: .main)
    }

    //MARK: - Keyboard Delegate:

    func submit() {
        createNewInterval()
    }
}

