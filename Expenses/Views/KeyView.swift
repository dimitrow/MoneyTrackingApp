//
//  KeyView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 15.06.2023.
//

import SwiftUI

enum FunctionalKey {
    case submit
    case removeLast
    case clearAll
}

enum NumericKey {
    case value(String)
}

enum KeyType {
    case functional(FunctionalKey)
    case numeric(NumericKey)
}

struct AnimatedParams {
    var strokeColor: Color
    var strokeWidth: CGFloat
    var backgroundColor: Color
    var fontColor: Color
}

typealias AnimationCompletion = () -> Void

private let tapDuration: Double = 0.4
private let keyTitleFontSize: CGFloat = 28.0
private let keyboardCornerRadius: CGFloat = 16.0
private let keyboardBorderWidth: CGFloat = 2.0

struct KeyView<Delegate: KeyboardDelegate>: View {

    var keyType: KeyType
    var delegate: Delegate
    @State var isKeyTapped: Bool = false

    var body: some View {
        ZStack {
            keyBackground(keyType)
            keyTitle(keyType)
                .font(.system(size: keyTitleFontSize,
                              weight: .regular))
                .foregroundColor(.eaKeyFontColor)
        }
        .overlay(content: {
            RoundedRectangle(cornerRadius: keyboardCornerRadius)
                .inset(by: keyboardBorderWidth / 2)
                .stroke(Color.eaKeyOutline,
                        lineWidth: keyboardBorderWidth)
        })
        .clipShape(
            RoundedRectangle(cornerRadius: keyboardCornerRadius)
        )
        .onTapGesture {
            buttonTapAnimation(duration: tapDuration) {
                executeOperation(for: keyType)
            }
        }
    }

    func updateAmount(_ value: String) {
        delegate.updateAmount(value)
    }

    @ViewBuilder
    private func keyBackground(_ key: KeyType) -> some View {
        switch key {
        case .functional(let function):
            switch function {
            default:
                isKeyTapped ? Color.eaKeyTapped : Color.eaKeyFunctional
            }
        case .numeric:
            isKeyTapped ? Color.eaKeyTapped : Color.eaKeyNumeric
        }
    }

    @ViewBuilder
    private func keyTitle(_ key: KeyType) -> some View {
        switch key {
        case .functional(let function):
            switch function {
            case .clearAll:
                Image(systemName: "clear")
            case .removeLast:
                Image(systemName: "delete.backward")
            case .submit:
                Image(systemName: "return")
            }
        case .numeric(.value(let value)):
            Text(value)
        }
    }

    private func buttonTapAnimation(duration: Double,
                                    completion: @escaping AnimationCompletion) {
        withAnimation(.easeIn(duration: duration / 2)) {
            isKeyTapped = true
        }
        withAnimation(.easeOut(duration: duration / 2).delay(duration / 2)) {
            isKeyTapped = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            completion()
        }
    }

    private func executeOperation(for key: KeyType) {
        switch key {
        case .functional(let function):
            switch function {
            case .clearAll:
                delegate.clearAmount()
            case .removeLast:
                delegate.removeLast()
            case .submit:
                delegate.submit()
            }
        case .numeric(.value(let value)):
            delegate.updateAmount(value)
        }
    }
}

struct KeyView_Previews: PreviewProvider {

    static let storageService = StorageService(storageManager: StorageManager.shared,
                                        storageMapper: StorageMapper())
    static let viewModel = AddNewIntervalViewModel(storageService: storageService,
                                                   router: Router())

    static var previews: some View {

        Group {
            KeyView(keyType: KeyType.functional(.submit),
                    delegate: viewModel)
            .frame(width: 480, height: 480)
            .previewLayout(.sizeThatFits)
            KeyView(keyType: KeyType.numeric(.value("2")),
                    delegate: viewModel)
            .preferredColorScheme(.dark)
            .frame(width: 480, height: 480)
            .previewLayout(.sizeThatFits)
        }
    }
}
