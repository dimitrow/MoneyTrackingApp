//
//  KeyboardDelegateTests.swift
//  ExpensesTests
//
//  Created by Gene Dimitrow on 30.06.2023.
//

import XCTest
@testable import Expenses

final class KeyboardDelegateTests: XCTestCase {

    var keyboardDelegate: MockKeyboardDelegate!

    override func setUpWithError() throws {
        keyboardDelegate = MockKeyboardDelegate(amount: "0")
    }

    func testKeyboardInputNumber() throws {

        keyboardDelegate.amount = "12"
        keyboardDelegate.updateAmount("1")

        XCTAssertEqual(keyboardDelegate.amount, "121")
    }

    func testKeyboardInputNumberFirst() throws {

        keyboardDelegate.amount = "0"
        keyboardDelegate.updateAmount("6")

        XCTAssertEqual(keyboardDelegate.amount, "6")
    }

    func testKeyboardInputDotFirst() throws {

        keyboardDelegate.amount = "0"
        keyboardDelegate.updateAmount(".")

        XCTAssertEqual(keyboardDelegate.amount, "0.")
    }

    func testKeyboardInputDot() throws {

        keyboardDelegate.amount = "34"
        keyboardDelegate.updateAmount(".")

        XCTAssertEqual(keyboardDelegate.amount, "34.")
    }

    func testKeyboardInputDotAgain() throws {

        keyboardDelegate.amount = "453.7"
        keyboardDelegate.updateAmount(".")

        XCTAssertEqual(keyboardDelegate.amount, "453.7")
    }

    func testKeyboardInputFirstDecimal() throws {

        keyboardDelegate.amount = "453."
        keyboardDelegate.updateAmount("9")

        XCTAssertEqual(keyboardDelegate.amount, "453.9")
    }

    func testKeyboardInputSecondDecimal() throws {

        keyboardDelegate.amount = "453.99"
        keyboardDelegate.updateAmount("5")

        XCTAssertEqual(keyboardDelegate.amount, "453.99")
    }

    func testKeyboardInputMaxValueWithoutDot() throws {

        keyboardDelegate.amount = "4539992"
        keyboardDelegate.updateAmount(".")

        XCTAssertEqual(keyboardDelegate.amount, "4539992")
    }

    func testKeyboardInputMaxValue() throws {

        keyboardDelegate.amount = "453999234"
        keyboardDelegate.updateAmount("6")

        XCTAssertEqual(keyboardDelegate.amount, "453999234")
    }

    func testKeyboardClearAll() throws {

        keyboardDelegate.amount = "149"
        keyboardDelegate.clearAmount()

        XCTAssertEqual(keyboardDelegate.amount, "0")
    }

    func testKeyboardRemoveLast() throws {

        keyboardDelegate.amount = "149"
        keyboardDelegate.removeLast()

        XCTAssertEqual(keyboardDelegate.amount, "14")
    }

    func testKeyboardRemoveLastEdge() throws {

        keyboardDelegate.amount = "8"
        keyboardDelegate.removeLast()

        XCTAssertEqual(keyboardDelegate.amount, "0")
    }
}
