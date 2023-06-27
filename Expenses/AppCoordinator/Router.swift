//
//  SceneRouter.swift
//  Expenses
//
//  Created by Gene Dimitrow on 01.06.2023.
//

import SwiftUI

final class Router: ObservableObject {

    @Published var scenes = [Scenes]()
    @Published var defaultScene: Scenes = .main

    func push(to scene: Scenes) {
        scenes.append(scene)
    }

    func goBack() {
        _ = scenes.popLast()
    }

    func reset() {
        scenes = []
    }

    func setInitial(scene: Scenes) {
        self.defaultScene = scene
    }

    @ViewBuilder
    func getScene(_ scene: Scenes) -> some View {
        switch scene {
        case .main:
            ExpensesListSceneAssembly().getScene(self)
        case .empty:
            EmptyDataSceneAssembly().getScene(self)
        case .newInterval:
            AddNewIntervalViewAssembly().getScene(self)
        case .intervalDetails(let interval):
            EmptyView()
        case .expenseDetails(let expense):
            EmptyView()
        }
    }
}
