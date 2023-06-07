//
//  EmptyDataSceneAssembly.swift
//  Expenses
//
//  Created by Gene Dimitrow on 04.06.2023.
//

import SwiftUI

class EmptyDataSceneAssembly: SceneAssembly {

    @ViewBuilder
    func getScene(_ router: Router) -> some View {
        EmptyDataView(viewModel: EmptyDataViewModel(router: router))
    }
}
