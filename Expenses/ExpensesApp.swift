//
//  ExpensesApp.swift
//  Expenses
//
//  Created by Gene Dimitrow on 20.11.2022.
//

import SwiftUI

@main
struct ExpensesApp: App {

    var body: some Scene {
        WindowGroup {
            RouterAssembly().getScene()
//            ExpensesListAssembly().getScene()
//            ExpensesListView(viewModel: ExpensesListViewModel(storageService: storageService))
        }
    }
}
