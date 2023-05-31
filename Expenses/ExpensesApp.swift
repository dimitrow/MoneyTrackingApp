//
//  ExpensesApp.swift
//  Expenses
//
//  Created by Gene Dimitrow on 20.11.2022.
//

import SwiftUI

@main
struct ExpensesApp: App {

    private let storageService: StorageService

    var body: some Scene {
        WindowGroup {
            ExpensesListView(viewModel: ExpenseListViewModel(storageService: storageService))
        }
    }

    init() {
        self.storageService = StorageService(storageManager: StorageManager.shared,
                                             storageMapper: StorageMapper())
    }
}
