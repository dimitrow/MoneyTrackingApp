//
//  ExpensesApp.swift
//  Expenses
//
//  Created by Gene Dimitrow on 20.11.2022.
//

import SwiftUI

@main
struct ExpensesApp: App {

    private let router = Router()

    var body: some Scene {
        WindowGroup {
            RouterAssembly().getScene(router)
//            ExpensesListAssembly().getScene()
//            ExpensesListView(viewModel: ExpensesListViewModel(storageService: storageService))
        }
    }
}
