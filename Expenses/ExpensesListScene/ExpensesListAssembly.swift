//
//  ExpensesListAssembly.swift
//  Expenses
//
//  Created by Gene Dimitrow on 01.06.2023.
//

import SwiftUI

class ExpensesListAssembly {

    @ViewBuilder
    func getScene() -> some View {
        let storageService = StorageService(storageManager: StorageManager.shared,
                                             storageMapper: StorageMapper())
        ExpensesListView(viewModel: ExpensesListViewModel(storageService: storageService,
                                                          router: Router()))
    }
}
