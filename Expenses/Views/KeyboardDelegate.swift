//
//  KeyboardDelegate.swift
//  Expenses
//
//  Created by Gene Dimitrow on 11.06.2023.
//

import Foundation

enum KeyboardOperation {
    case submit
    case removeLast
    case clearAll
}

protocol KeyboardDelegate: AnyObject {

    var amount: String { get set }
    
    func updateAmount(_ value: String)
    func removeLast()
    func clearAll()
    func submit()
}

extension KeyboardDelegate {

    func updateAmount(_ value: String) {

        let chars = Array(amount)

        if let dotIndex = chars.firstIndex(of: ".") {
            if value == "." {
                return
            }
            if dotIndex == chars.count - 3 {
                return
            }
        }
        amount = amount == "0" ? value : amount + value
    }

    func removeLast() {
        if amount.count == 1 {
            amount = "0"
            return
        }
        _ = amount.removeLast()
    }

    func clearAll() {
        amount = "0"
    }
}
