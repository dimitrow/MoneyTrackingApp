//
//  Scenes.swift
//  Expenses
//
//  Created by Gene Dimitrow on 01.06.2023.
//

import SwiftUI

protocol SceneAssembly {
    associatedtype V: View
    func getScene(_ router: Router) -> V
}

enum Scenes {
    case main
    case intervalDetails(item: Interval)
    case expenseDetails(item: DailyExpenses)
    case empty
    case newInterval
}

extension Scenes: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }

    static func == (lhs: Scenes, rhs: Scenes) -> Bool {
        switch (lhs, rhs) {
        case (.main, .main):
            return true
        case (.empty, .empty):
            return true
        case (.newInterval, .newInterval):
            return true
        case (.expenseDetails(let lhsItem), .expenseDetails(let rhsItem)):
            return lhsItem.id == rhsItem.id
        case (.intervalDetails(let lhsItem), .intervalDetails(let rhsItem)):
            return lhsItem.id == rhsItem.id
        default:
            return false
        }
    }
}
