//
//  MockKeyboardDelegate.swift
//  ExpensesTests
//
//  Created by Gene Dimitrow on 30.06.2023.
//

@testable import Expenses

final class MockKeyboardDelegate: KeyboardDelegate {

    var amount: String

    init(amount: String) {
        self.amount = amount
    }

    func submit() {

    }
}
