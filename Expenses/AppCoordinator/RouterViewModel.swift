//
//  RouterViewModel.swift
//  Expenses
//
//  Created by Gene Dimitrow on 02.06.2023.
//

import SwiftUI

protocol RouterViewModelInput {
    var router: Router { get set }
}

protocol RouterViewModelOutput {
    func determineInitialScene()
}

protocol RouterViewModelType: RouterViewModelInput, RouterViewModelOutput, ObservableObject {}

class RouterViewModel: RouterViewModelType {

    private let storageService: StorageServiceType
    var router: Router

    init(storageService: StorageServiceType,
         router: Router) {
        self.storageService = storageService
        self.router = router
        determineInitialScene()
    }

    func determineInitialScene() {
        if storageService.isUserHasData() {
            router.setInitial(scene: .main)
//            router.defaultScene = .main
        } else {
            router.setInitial(scene: .empty)
//            router.defaultScene = .empty
        }
    }
}

