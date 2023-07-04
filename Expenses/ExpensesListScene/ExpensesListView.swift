//
//  ExpensesListView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 20.11.2022.
//

import SwiftUI

private let bottomHeightMin: CGFloat = 48.0
private let bottomHeightMax: CGFloat = 360.0

struct ExpensesListView<Model: ExpensesListViewModelType>: View {

    @ObservedObject var viewModel: Model

    @State var bottomHeight: CGFloat = bottomHeightMin

    var settingsButton: some View {
        Button(action: {

        }) {
            Image(systemName: "gearshape")
        }
    }

    var editButton: some View {
        Button(action: {

        }) {
            Image(systemName: "pencil.circle")
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                VStack(spacing: 2.0) {
                    ZStack{
                        Color.eaBackground
                        VStack(spacing: 0.0) {
                            HStack {
                                VStack(spacing: 0.0) {
                                    Spacer()
                                    ZStack {
                                        ProgressView(progress: viewModel.spendingProgressBinding)
                                        VStack {
                                            Text(viewModel.spentInTotal)
                                                .font(.system(size: 16, weight: .semibold))
                                            Text("of")
                                                .font(.system(size: 11, weight: .regular))
                                            Text(viewModel.intervalAmount)
                                                .font(.system(size: 14, weight: .medium))
                                        }
                                    }
                                    Color.eaMainBlue
                                        .frame(width: 4.0, height: 8)
                                }
                                .frame(width: 128)
                                .padding(.leading, 48) //104
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("bis \(viewModel.interval.endDate.toString(format: .custom("MMM d, yyyy")) ?? "")")
                                        .font(.system(size: 24, weight: .bold))
                                    if viewModel.isUserSaving {
                                        Text("saved: \(viewModel.saved)")
                                            .foregroundColor(.green)
                                    } else {
                                        Text("spent over: \(viewModel.saved)")
                                            .foregroundColor(.red)
                                    }
                                    Text("spent today: \(viewModel.spentToday)")
                                    Text("of: \(viewModel.dailyLimit)")
                                }
                                .padding(.trailing, 16)
                            }
                            .frame(height: 160)
                            Divider()
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack(spacing: 2.0) {
                                    ForEach(viewModel.pastExpenses, id: \.id) { expense in
                                        dailyExpensesView(expense)
                                        .onTapGesture {
                                            viewModel.navigateToExpenseDetails(expense)
                                        }
                                    }
                                    footerView(viewModel.interval)
                                }
                            }
                        }
                    }
                    .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                    .frame(height: geometry.size.height - bottomHeight)
                    ZStack{
                        Color.eaBackground
                        VStack(spacing: 0.0) {
                            Button {
                                withAnimation(.interactiveSpring(response: 0.3,
                                                                 dampingFraction: 0.7)) {
                                    bottomHeight = bottomHeight == bottomHeightMax ? bottomHeightMin : bottomHeightMax
                                }
                            } label: {
                                Text(bottomHeight == bottomHeightMax ? "Hide" : "Add new")
                            }
                            .padding(.top, 10)
                            Spacer()
                            VStack(spacing: 0.0) {
                                HStack(spacing: 0.0) {
                                    Spacer()
                                    Text("\(viewModel.amount)")
                                        .frame(height: 60)
                                        .font(.system(size: 64,
                                                      weight: .medium))
                                        .foregroundColor(.eaKeyFontColor)
                                        .background(Color.red)
                                        .padding(.trailing, 32)
                                        .padding(.bottom, 12)
                                }
                                KeyboardView(delegate: viewModel)
                                    .padding(.bottom, 19)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .background(Color.eaBackground)
        }
    }

    @ViewBuilder
    func dailyExpensesView(_ expense: DailyExpenses) -> some View {
        ZStack {
            Color.eaBackground
            HStack(spacing: 4.0) {
                Text("\(expense.timeStamp.toString(format: .custom("MMM d, yyyy")) ?? "")")
                    .font(.system(size: 12,
                                  weight: .medium))
                    .frame(maxWidth: 84.0)
                ZStack {
                    Color.eaMainBlue
                        .frame(width: 4.0)
                    Circle()
                        .frame(width: 16)
                        .foregroundColor(.eaMainBlue)
                    Circle()
                        .frame(width: 8)
                        .foregroundColor(expense.dailyAmount > viewModel.interval.dailyLimit ? Color.red : Color.green)
                }

                Text(String(format: "%.2f", expense.dailyAmount))
                    .foregroundColor(expense.dailyAmount > viewModel.interval.dailyLimit ? Color.red : Color.green)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .frame(height: 48.0)
            .padding(.horizontal, 16.0)
        }
    }

    @ViewBuilder
    func footerView(_ interval: Interval) -> some View {
        HStack(spacing: 4.0) {
            Text("\(interval.startDate.toString(format: .custom("MMM d, yyyy")) ?? "")")
                .font(.system(size: 12,
                              weight: .medium))
                .frame(maxWidth: 84)
            ZStack {
                VStack {
                    Color.eaMainBlue
                        .frame(width: 4.0, height: 22)
                    Spacer()
                }
                Circle().frame(width: 16).foregroundColor(.eaMainBlue)
                Circle().frame(width: 8).foregroundColor(.white)
            }
            Text("Anfang des Zeitraums")
                .font(.system(size: 12,
                              weight: .medium))
            Spacer()
        }
        .frame(height: 44.0)
        .padding(.horizontal, 16.0)
    }
}

struct ExpensesListView_Previews: PreviewProvider {

    static let storageService = StorageService(storageManager: StorageManager.shared,
                                        storageMapper: StorageMapper())
    static let viewModel = ExpensesListViewModel(storageService: storageService,
                                                 router: Router())
    static var previews: some View {
        NavigationStack {
            ExpensesListView(viewModel: viewModel)
        }
    }
}
