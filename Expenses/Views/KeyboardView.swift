//
//  KeyboardView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 08.06.2023.
//

import SwiftUI

let keyboardSpacing: CGFloat = 8.0

struct KeyboardView<Delegate: KeyboardDelegate>: View {

    var delegate: Delegate

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: keyboardSpacing){
                HStack(spacing: keyboardSpacing) {
                    VStack(spacing: keyboardSpacing) {
                        numberButton("1")
                        numberButton("4")
                        numberButton("7")
                    }
                    VStack(spacing: keyboardSpacing) {
                        numberButton("2")
                        numberButton("5")
                        numberButton("8")
                    }
                    VStack(spacing: keyboardSpacing) {
                        numberButton("3")
                        numberButton("6")
                        numberButton("9")
                    }
                    VStack(spacing: keyboardSpacing) {
                        funcButton(.removeLast)
                        funcButton(.clearAll)
                    }
                }
                .frame(height: geometry.size.height * 0.75)
                HStack(spacing: keyboardSpacing) {
                    numberButton("0")
                    numberButton(".")
                    funcButton(.submit)
                }
                .frame(height: geometry.size.height * 0.25)
            }
            .padding(.horizontal, 16)
        }
        .padding(.bottom, 32)
        .padding(.top, 16)
    }

    @ViewBuilder
    func numberButton(_ value: String) -> some View {
        ZStack {
            Color.eaBackground
            Text(value)
                .font(.system(size: 20, weight: .light))
                .foregroundColor(.eaButtonOutline)
        }
        .overlay(content: {
            let borderWidth = 1.0
            RoundedRectangle(cornerRadius: 20)
                .inset(by: borderWidth / 2)
                .stroke(Color.eaButtonOutline,
                        lineWidth: borderWidth)
//                .shadow(color: .white, radius: 5)
        })
        .clipShape(
            RoundedRectangle(cornerRadius: 20.0)
        )
        .shadow(color: .white, radius: 1)
        .onTapGesture {
            updateAmount(value)
        }
    }

    @ViewBuilder
    func funcButton(_ operation: KeyboardOperation) -> some View {
        ZStack {
            Color.eaButtonOps
            operationIcon(for: operation)
                .font(.system(size: 20, weight: .light))
                .foregroundColor(.eaButtonOutline)
        }
        .overlay(content: {
            let borderWidth = 1.0
            RoundedRectangle(cornerRadius: 20)
                .inset(by: borderWidth / 2)
                .stroke(Color.eaButtonOutline,
                    lineWidth: borderWidth)
//                .shadow(color: .white, radius: 5)
        })
        .clipShape(
            RoundedRectangle(cornerRadius: 20.0)
        )
        .shadow(color: .white, radius: 1)
        .onTapGesture {
            executeOperation(operation)
        }
    }

    func updateAmount(_ value: String) {
//        keyboardViewModel.updateAmount(value)
        delegate.updateAmount(value)
    }

    private func executeOperation(_ operation: KeyboardOperation) {
        switch operation {
        case .clearAll:
            delegate.clearAll()
//            keyboardViewModel.clearAll()
        case .removeLast:
            delegate.removeLast()
//            keyboardViewModel.removeLast()
        case .submit:
            delegate.submit()
        }
    }

    private func operationIcon(for operation: KeyboardOperation) -> Image {
        switch operation {
        case .clearAll:
            return Image(systemName: "clear")
        case .removeLast:
            return Image(systemName: "delete.backward")
        case .submit:
            return Image(systemName: "return")
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {

    static let storageService = StorageService(storageManager: StorageManager.shared,
                                        storageMapper: StorageMapper())
    static let viewModel = AddNewIntervalViewModel(storageService: storageService,
                                                   router: Router())

    static var previews: some View {
        Group {
            KeyboardView(delegate: viewModel)
                .frame(width: 480, height: 480)
            KeyboardView(delegate: viewModel)
                .frame(width: 480, height: 480)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }

}
