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
    var routerScenes: [Scenes] { get set }
    var routerScenesBinding: Binding<[Scenes]> { get }
    func navigateToInitialScene()
    func navigate(to scene: Scenes)
}

protocol RouterViewModelType: RouterViewModelInput, RouterViewModelOutput, ObservableObject {}

class RouterViewModel: RouterViewModelType {

    private let storageService: StorageServiceType
    @ObservedObject var router: Router

//    var router: Router

    @Published var routerScenes: [Scenes] = []

    var routerScenesBinding: Binding<[Scenes]> {
        Binding {
            self.routerScenes
        } set: { scenes in
            self.routerScenes = scenes
        }
    }

    init(storageService: StorageServiceType,
         router: Router) {
        self.storageService = storageService
        self.router = router
        self.routerScenes = self.router.scenes

    }

    func navigate(to scene: Scenes) {
        router.getScene(scene)
    }
}

