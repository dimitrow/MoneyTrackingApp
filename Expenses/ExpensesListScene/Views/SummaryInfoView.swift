//
//  SummaryInfoView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 10.07.2023.
//

import SwiftUI

private let summaryInfoCornerRadius: CGFloat = 16.0
private let summaryInfoFrameHeight: CGFloat = 160.0

private let summaryInfoBackgroundOpacity: Double = 0.1

struct SummaryInfoView<ViewModel: ExpensesListViewModelType>: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Color.eaMainBlue
                .opacity(summaryInfoBackgroundOpacity)
            HStack(alignment: .center, spacing: 8.0) {
                VStack(spacing: 0.0) {
                    Spacer()
                    ZStack {
                        ProgressView(progress: viewModel.spendingProgressBinding)
                        VStack {
                            Text(viewModel.spentInTotal)
                                .font(.system(size: 16, weight: .semibold))
                            Text("of")
                                .font(.system(size: 12, weight: .regular))
                            Text(viewModel.intervalAmount)
                                .font(.system(size: 14, weight: .medium))
                        }
                    }
                    Color.eaMainBlue
                        .frame(width: 4.0, height: 8)
                }
                .frame(width: 128)
                .padding(.leading, 32)
                VStack(alignment: .trailing) {
                    HStack {
                        Text("You have:")
                            .foregroundColor(.eaPrimaryText)
                            .font(.system(size: 16, weight: .semibold))
                        Spacer()
                    }
                    Text("\(viewModel.leftover)")
                        .foregroundColor(.eaPrimaryText)
                        .font(.system(size: 30, weight: .bold))
                        .minimumScaleFactor(0.4)
                    Text("bis \(viewModel.interval.endDate.toString(format: .custom("MMM d, yyyy")) ?? "")")
                        .font(.system(size: 14, weight: .regular))
                    if viewModel.isUserSaving {
                        Text("saved: \(viewModel.saved)")
                            .foregroundColor(.green)
                            .font(.system(size: 18, weight: .medium))
                            .minimumScaleFactor(0.4)
                    } else {
                        Text("spent over: \(viewModel.saved)")
                            .foregroundColor(.red)
                            .font(.system(size: 16, weight: .medium))
                            .minimumScaleFactor(0.4)
                    }
                    Text("spent today: \(viewModel.spentToday)")
                        .foregroundColor(.eaPrimaryText)
                        .font(.system(size: 16, weight: .semibold))
                        .minimumScaleFactor(0.4)
                    Text("of: \(viewModel.dailyLimit)")
                        .foregroundColor(.eaPrimaryText)
                        .font(.system(size: 12, weight: .regular))
                }
                .padding(.trailing, 16)
            }
        }
        .clipShape(
            RoundedRectangle(cornerRadius: summaryInfoCornerRadius)
        )
        .frame(height: summaryInfoFrameHeight)
        .padding(.horizontal, 16)
    }
}

//#Preview {
//    SummaryInfoView()
//}
