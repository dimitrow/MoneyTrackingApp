//
//  RouterView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 01.06.2023.
//

import SwiftUI

struct RouterView<Model: RouterViewModelType>: View {

    @ObservedObject var viewModel: Model
//    @ObservedObject var router: Router

    var body: some View {
        NavigationStack(path: viewModel.routerScenesBinding) {
            router.getScene(router.defaultScene)
                .navigationDestination(for: Scenes.self) { scene in
                    router.getScene(scene)
                    viewModel.navigate(to: scene)
                }
        }
    }
}

//struct SceneRouterView_Previews: PreviewProvider {
//    static var previews: some View {
//        SceneRouterView()
//    }
//}
