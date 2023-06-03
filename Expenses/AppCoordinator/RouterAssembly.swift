//
//  RouterAssembly.swift
//  Expenses
//
//  Created by Gene Dimitrow on 02.06.2023.
//

import SwiftUI

class RouterAssembly: SceneAssembly {

    @ViewBuilder
    func getScene() -> some View {
        let storageService = StorageService(storageManager: StorageManager.shared,
                                             storageMapper: StorageMapper())

        let viewModel = RouterViewModel(storageService: storageService, router: Router())
        RouterView(viewModel: viewModel)
    }
}
