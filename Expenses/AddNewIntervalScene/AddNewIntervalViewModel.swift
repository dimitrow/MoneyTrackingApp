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
}

protocol AddNewIntervalViewModelOutput {
    var intervalDuration: String { get set }
    var isIntervalDataValid: Bool { get set }
    var amount: String { get set }
    var durationBinding: Binding<Double> { get }
}

protocol AddNewIntervalViewModelType: AddNewIntervalViewModelInput, AddNewIntervalViewModelOutput, KeyboardDelegate, ObservableObject {}

class AddNewIntervalViewModel: AddNewIntervalViewModelType {

    private let storageService: StorageServiceType
    private var router: Router

    private var interval: Interval?

    @Published var intervalDuration: String = ""
    @Published var isIntervalDataValid: Bool = false
    @Published var amount: String = "0"

    @Published private var duration: Double = defaultIntervalDuration
    var durationBinding: Binding<Double> {
        Binding {
            self.duration
        } set: { duration in
            self.duration = duration
        }
    }

    private var durationPublisher: AnyPublisher<String, Never> {
        $duration
            .map { duration in
                return String(format: "%.0f", duration)
            }
            .eraseToAnyPublisher()
    }

    init(storageService: StorageServiceType, router: Router) {
        self.storageService = storageService
        self.router = router

        durationPublisher
            .receive(on: RunLoop.main)
            .assign(to: &$intervalDuration)
    }

    private func createNewInterval() {

        guard let newIntervalAmount = Double(amount), let newIntervalDuration = Int16(intervalDuration) else {
//            router.showErrorAlert()
            router.showAlert(with: .missingIntervalData)
            return
        }

        router.showAlert(with: .missingIntervalData)

//        let interval = Interval(id: UUID(),
//                                amount: newIntervalAmount,
//                                duration: newIntervalDuration,
//                                timeStamp: Date())
//        storageService.createInterval(interval)
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
