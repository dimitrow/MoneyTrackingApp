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

    @Published private var showInfoAlert: Bool = false
    var showInfoAlertBinding: Binding<Bool> {
        Binding {
            self.showInfoAlert
        } set: { value in
            self.showInfoAlert = value
        }
    }

    @Published private var showErrorAlert: Bool = false
    var showErrorAlertBinding: Binding<Bool> {
        Binding {
            self.showErrorAlert
        } set: { value in
            self.showErrorAlert = value
        }
    }

    var alertTitle: String = ""
    var alertMessage: String = ""

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

    func showAlert(with error: AppErrors) {
        alertTitle = error.errorDescription.title
        alertMessage = error.errorDescription.message
        showErrorAlert = true
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
            EmptyView().foregroundColor(.green)
        }
    }
}
