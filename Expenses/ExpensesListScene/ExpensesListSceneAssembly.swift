//
//  ExpensesListSceneAssembly.swift
//  Expenses
//
//  Created by Gene Dimitrow on 01.06.2023.
//

import SwiftUI

class ExpensesListSceneAssembly: SceneAssembly {

    @ViewBuilder
    func getScene(_ router: Router) -> some View {
        let storageService = StorageService(storageManager: StorageManager.shared,
                                             storageMapper: StorageMapper())
        ExpensesListView(viewModel: ExpensesListViewModel(storageService: storageService,
                                                          router: router))
    }
}
