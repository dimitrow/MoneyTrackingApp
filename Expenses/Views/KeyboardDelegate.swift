//
//  KeyboardDelegate.swift
//  Expenses
//
//  Created by Gene Dimitrow on 11.06.2023.
//

import Foundation

protocol KeyboardDelegate: AnyObject {

    var amount: String { get set }
    
    func updateAmount(_ value: String)
    func removeLast()
    func clearAmount()
    func submit()
}

extension KeyboardDelegate {

    func updateAmount(_ value: String) {

        let chars = Array(amount)

        if value == "." && chars.count > 6 {
            return
        }

        if let dotIndex = chars.firstIndex(of: ".") {
            if value == "." { return }
            if dotIndex == chars.count - 3 { return }
        }

        if chars.count == 9 {
            return
        }

        if amount == "0" && value == "." {
            amount = amount + value
        } else {
            amount = amount == "0" ? value : amount + value
        }

    }

    func removeLast() {
        if amount.count == 1 {
            amount = "0"
            return
        }
        _ = amount.removeLast()
    }

    func clearAmount() {
        amount = "0"
    }
}
