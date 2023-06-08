//
//  AddNewIntervalViewModel.swift
//  Expenses
//
//  Created by Gene Dimitrow on 04.06.2023.
//

import Foundation
import SwiftUI

protocol AddNewIntervalViewModelInput {
    func createNewInterval()
}

protocol AddNewIntervalViewModelOutput {
    var duration: Double { get set }
    var durationBinding: Binding<Double> { get }

    var amount: String { get set }
    var amountBinding: Binding<String> { get }
}

protocol AddNewIntervalViewModelType: AddNewIntervalViewModelInput, AddNewIntervalViewModelOutput, ObservableObject {}

class AddNewIntervalViewModel: AddNewIntervalViewModelType {

    private let storageService: StorageServiceType
    private var router: Router

    @Published var duration: Double = 30.0

    var durationBinding: Binding<Double> {
        Binding {
            self.duration
        } set: { duration in
            self.duration = duration
        }
    }

    @Published var amount: String = ""
    var amountBinding: Binding<String> {
        Binding {
            self.amount
        } set: { amount in
            self.amount = amount
        }
    }

    init(storageService: StorageServiceType, router: Router) {
        self.storageService = storageService
        self.router = router
    }

    func createNewInterval() {

        let interval = Interval(id: UUID(),
                                amount: 30000.0,
                                interval: 30,
                                timeStamp: Date())
        storageService.createInterval(interval)
    }
}
