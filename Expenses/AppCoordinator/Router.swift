//
//  SceneRouter.swift
//  Expenses
//
//  Created by Gene Dimitrow on 01.06.2023.
//

import SwiftUI
//import Combine

final class Router: ObservableObject {

    @Published var scenes = [Scenes]()
    @Published var defaultScene: Scenes = .main

//    var scenesPath = CurrentValueSubject<[Scenes], Never>([Scenes]())

    init() {
        self.defaultScene = self.determineDefaultScene()
    }

    func push(to scene: Scenes) {
        scenes.append(scene)
//        scenesPath.send(scenes)
    }

    func goBack() {
        _ = scenes.popLast()
//        scenesPath.send(scenes)
    }

    func reset() {
        scenes = []
//        scenesPath.send(scenes)
    }

    func setInitial() {
        self.defaultScene = .main
//        scenesPath.send(scenes)
    }

    func determineDefaultScene() -> Scenes {
        return .empty
    }

    @ViewBuilder
    func getScene(_ scene: Scenes) -> some View {
        switch scene {
        case .main:
            ExpensesListAssembly().getScene()
        case .empty:
            EmptyDataView(viewModel: EmptyDataViewModel(router: self))
        case .newInterval:
            EmptyView().foregroundColor(.blue)
        case .intervalDetails(let interval):
            EmptyView().foregroundColor(.green)
        }
    }
}
