//
//  KeyboardView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 08.06.2023.
//

import SwiftUI

private let keyboardSpacing: CGFloat = 8.0
private let keyboardHorizontalPadding: CGFloat = 32.0
private let keyboardBottomPadding: CGFloat = 32.0
private let keyboardTopPadding: CGFloat = 16.0
private let keyboardHeight: CGFloat = 180.0

struct KeyboardView<Delegate: KeyboardDelegate>: View {

    var delegate: Delegate

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            
            VStack(spacing: keyboardSpacing) {
                HStack(spacing: keyboardSpacing) {
                    KeyView(keyType: .numeric(.value("1")),
                            delegate: delegate)
                        .frame(width: width / 4)
                    KeyView(keyType: .numeric(.value("2")),
                            delegate: delegate)
                        .frame(width: width / 4)
                    KeyView(keyType: .numeric(.value("3")),
                            delegate: delegate)
                        .frame(width: width / 4)
                    KeyView(keyType: .functional(.removeLast),
                            delegate: delegate)
                        .frame(width: width / 4)
                }
                .frame(height: geometry.size.height / 4)
                HStack(spacing: keyboardSpacing) {
                    KeyView(keyType: .numeric(.value("4")),
                            delegate: delegate)
                        .frame(width: width / 4)
                    KeyView(keyType: .numeric(.value("5")),
                            delegate: delegate)
                        .frame(width: width / 4)
                    KeyView(keyType: .numeric(.value("6")),
                            delegate: delegate)
                        .frame(width: width / 4)
                    KeyView(keyType: .functional(.clearAll),
                            delegate: delegate)
                        .frame(width: width / 4)
                }
                .frame(height: geometry.size.height / 4)
                HStack(spacing: keyboardSpacing) {
                    VStack(spacing: keyboardSpacing) {
                        KeyView(keyType: .numeric(.value("7")),
                                delegate: delegate)
                            .frame(width: width / 4)
                        KeyView(keyType: .numeric(.value(".")),
                                delegate: delegate)
                            .frame(width: width / 4)
                    }
                    VStack(spacing: keyboardSpacing) {
                        HStack(spacing: keyboardSpacing) {
                            KeyView(keyType: .numeric(.value("8")),
                                    delegate: delegate)
                                .frame(width: width / 4)
                            KeyView(keyType: .numeric(.value("9")),
                                    delegate: delegate)
                                .frame(width: width / 4)
                        }
                        KeyView(keyType: .numeric(.value("0")),
                                delegate: delegate)
                            .frame(width: width / 2 + keyboardSpacing)
                    }
                    VStack {
                        KeyView(keyType: .functional(.submit),
                                delegate: delegate)
                            .frame(width: width / 4)
                    }
                }
                .frame(height: geometry.size.height / 2 + keyboardSpacing)
            }
            .frame(maxWidth: geometry.size.width,
                   maxHeight: geometry.size.height)
        }
        .frame(height: keyboardHeight)
        .padding(.horizontal, keyboardHorizontalPadding)
        .padding(.top, keyboardTopPadding)
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
            KeyboardView(delegate: viewModel)
                .preferredColorScheme(.dark)
        }
        .frame(width: 480, height: 480)
        .previewLayout(.sizeThatFits)
    }
}
