//
//  RouterView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 01.06.2023.
//

import SwiftUI

struct RouterView<Model: RouterViewModelType>: View {

    @ObservedObject var viewModel: Model
    @ObservedObject var router: Router

    var body: some View {
        NavigationStack(path: $router.scenes) {
            router.getScene(router.defaultScene)
                .navigationDestination(for: Scenes.self) { scene in
                    router.getScene(scene)
                }
        }
    }
}

struct SceneRouterView_Previews: PreviewProvider {

    static var router = Router()
    static var storageService = StorageService(storageManager: StorageManager.shared,
                                        storageMapper: StorageMapper())
    static var viewModel = RouterViewModel(storageService: storageService,
                                           router: router)
    static var previews: some View {
        RouterView(viewModel: viewModel, router: router)
    }
}
