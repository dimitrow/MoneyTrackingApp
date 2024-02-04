//
//  ExpensesListView+SummaryInfoView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 10.07.2023.
//

import SwiftUI

private let summaryInfoCornerRadius: CGFloat = 16.0
private let summaryInfoFrameHeight: CGFloat = 160.0
private let summaryInfoHSpacing: CGFloat = 8.0
private let summaryInfoHorizontalPadding: CGFloat = 16.0

private let summaryInfoBackgroundOpacity: Double = 0.1

private let intervalSpendingsFrameWidth: CGFloat = 128.0
private let intervalSpendingsLeadingPadding: CGFloat = 32.0

private let cumulativeInfoTrailingPadding: CGFloat = 16.0

extension ExpensesListView {

    @ViewBuilder
    func summaryView() -> some View {
        ZStack {
            Color.eaMainBlue
                .opacity(summaryInfoBackgroundOpacity)
            HStack(alignment: .center, spacing: summaryInfoHSpacing) {
                VStack(spacing: 0.0) {
                    Spacer()
                    ZStack {
                        ProgressView(progress: viewModel.spendingProgressBinding)
                        intervalSpendings()
                    }
                    Color.eaMainBlue
                        .frame(width: 4.0, height: 8)
                }
                .frame(width: intervalSpendingsFrameWidth)
                .padding(.leading, intervalSpendingsLeadingPadding)
                VStack(alignment: .trailing) {
                    Text("spent today: \(viewModel.spentToday)")
                        .foregroundColor(.eaPrimaryText)
                        .font(.system(size: 16, weight: .semibold))
                        .minimumScaleFactor(0.2)
                        .lineLimit(1)
                    Text("of: \(viewModel.dailyLimit)")
                        .foregroundColor(.eaPrimaryText)
                        .font(.system(size: 14, weight: .regular))
                        .minimumScaleFactor(0.2)
                        .lineLimit(1)
                    Divider()
                    HStack {
                        Spacer()
                        Text("You have:")
                            .foregroundColor(.eaPrimaryText)
                            .font(.system(size: 16, weight: .semibold))
                    }
                    Text("\(viewModel.leftover)")
                        .foregroundColor(.eaPrimaryText)
                        .font(.system(size: 26, weight: .bold))
                        .minimumScaleFactor(0.4)
                        .lineLimit(1)
                    Text("bis \(viewModel.interval.endDate.toString(format: .custom(dateFormat)) ?? "")")
                        .font(.system(size: 14, weight: .regular))
                    if viewModel.isUserSaving {
                        Text("saved: \(viewModel.saved)")
                            .foregroundColor(.green)
                            .font(.system(size: 16, weight: .medium))
                            .minimumScaleFactor(0.4)
                            .lineLimit(1)
                    } else {
                        Text("spent over: \(viewModel.saved)")
                            .foregroundColor(.red)
                            .font(.system(size: 16, weight: .medium))
                            .minimumScaleFactor(0.4)
                            .lineLimit(1)
                    }
                }
                .padding(.trailing, cumulativeInfoTrailingPadding)
            }
        }
        .clipShape(
            RoundedRectangle(cornerRadius: summaryInfoCornerRadius)
        )
        .frame(height: summaryInfoFrameHeight)
        .padding(.horizontal, summaryInfoHorizontalPadding)
    }

    @ViewBuilder
    func intervalSpendings() -> some View {
        VStack {
            Text(viewModel.spentInTotal)
                .font(.system(size: 16, weight: .semibold))
            Text("of")
                .font(.system(size: 12, weight: .regular))
            Text(viewModel.intervalAmount)
                .font(.system(size: 14, weight: .medium))
        }
    }
}

//#Preview {
//    SummaryInfoView()
//}
