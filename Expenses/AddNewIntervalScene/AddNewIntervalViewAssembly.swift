//
//  AddNewIntervalViewAssembly.swift
//  Expenses
//
//  Created by Gene Dimitrow on 04.06.2023.
//

import SwiftUI

class AddNewIntervalViewAssembly: SceneAssembly {

    @ViewBuilder
    func getScene(_ router: Router) -> some View {
        let storageService = StorageService(storageManager: StorageManager.shared,
                                             storageMapper: StorageMapper())
        AddNewIntervalView(viewModel: AddNewIntervalViewModel(storageService: storageService,
                                                          router: router))
    }
}
