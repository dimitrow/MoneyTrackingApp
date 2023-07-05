//
//  DurationInputView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 17.06.2023.
//

import SwiftUI

private let inputViewFontSize: CGFloat = 28.0

private let labelHorizontalPadding: CGFloat = 18.0
private let titleHorizontalPadding: CGFloat = 8.0
private let titleTopPadding: CGFloat = 12.0

private let sliderRange: ClosedRange = 10.0...30.0
private let sliderHorizontalPadding: CGFloat = 24.0
private let sliderBottomPadding: CGFloat = 10.0

private let controlCornerRadius: CGFloat = 16.0
private let controlBorderWidth: CGFloat = 2.0
private let controlHeight: CGFloat = 108.0
private let controlHorizontalPadding: CGFloat = 20.0

struct DurationInputView: View {

    @Binding var duration: Double
    var formattedDuration: String

    var body: some View {
        ZStack {
            Color.eaDataField
            VStack {
                HStack(alignment: .center) {
                    Text("Duration:")
                        .font(.system(size: inputViewFontSize,
                                      weight: .medium))
                        .foregroundColor(.eaKeyFontColor)
                        .padding(.leading, labelHorizontalPadding)
                    Spacer()
                    Text(" \(formattedDuration) days")
                        .font(.system(size: inputViewFontSize,
                                      weight: .bold))
                        .foregroundColor(.eaKeyFontColor)
                        .padding(.trailing, labelHorizontalPadding)
                }
                .padding(.top, titleTopPadding)
                .padding(.horizontal, titleHorizontalPadding)
                Slider(value: $duration,
                       in: sliderRange,
                       step: 1)
                .tint(.eaKeyOutline)
                .padding(.horizontal, sliderHorizontalPadding)
                .padding(.bottom, sliderBottomPadding)
            }
        }
        .overlay(content: {
            RoundedRectangle(cornerRadius: controlCornerRadius)
                .inset(by: controlBorderWidth / 2)
                .stroke(Color.eaKeyOutline,
                        lineWidth: controlBorderWidth)
        })
        .clipShape(
            RoundedRectangle(cornerRadius: controlCornerRadius)
        )
        .frame(height: controlHeight)
        .padding(.horizontal, controlHorizontalPadding)
    }
}

struct DurationInputView_Previews: PreviewProvider {

    static let storageService = StorageService(storageManager: StorageManager.shared,
                                        storageMapper: StorageMapper())
    static let viewModel = AddNewIntervalViewModel(storageService: storageService,
                                                   router: Router())

    static var previews: some View {

        Group {
            DurationInputView(duration: viewModel.durationBinding, formattedDuration: viewModel.intervalDuration)
            .previewLayout(.sizeThatFits)
            DurationInputView(duration: viewModel.durationBinding, formattedDuration: viewModel.intervalDuration)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        }
    }
}
