//
//  ExpensesListView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 20.11.2022.
//

import SwiftUI

private let bottomHeightMin: CGFloat = 64.0
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

    var sceneBackground: some View {
        Color.black
    }

    var inputView: some View {
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
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                sceneBackground
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
                                                .font(.system(size: 12, weight: .regular))
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
                                    Text("You have:")
                                        .font(.system(size: 14, weight: .regular))
                                    Text("\(viewModel.leftover)")
                                        .font(.system(size: 30, weight: .bold))
                                    Text("bis \(viewModel.interval.endDate.toString(format: .custom("MMM d, yyyy")) ?? "")")
                                        .font(.system(size: 14, weight: .regular))
                                    if viewModel.isUserSaving {
                                        Text("saved: \(viewModel.saved)")
                                            .foregroundColor(.green)
                                            .font(.system(size: 18, weight: .medium))
                                    } else {
                                        Text("spent over: \(viewModel.saved)")
                                            .foregroundColor(.red)
                                            .font(.system(size: 18, weight: .medium))
                                    }
                                    Divider()
                                    Text("spent today: \(viewModel.spentToday)")
                                    Text("of: \(viewModel.dailyLimit)")
                                }
                                .padding(.trailing, 22)
                            }
                            .frame(height: 160)
                            Divider()
                            expensesList(viewModel.pastExpenses)
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
                                inputView
                                KeyboardView(delegate: viewModel)
                                    .padding(.bottom, 19)
                            }
                            Spacer()
                        }
                    }
                    .cornerRadius(8, corners: [.topLeft, .topRight])
                }
            }
            .background(Color.eaBackground)
        }
        .navigationTitle("Current Expenses")
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .ignoresSafeArea(.all, edges: .bottom)
    }

    @ViewBuilder
    func expensesList(_ expenses: [DailyExpenses]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 2.0) {
                ForEach(expenses, id: \.id) { expense in
                    dailyExpensesView(expense)
                    .onTapGesture {
                        viewModel.navigateToExpenseDetails(expense)
                    }
                }
                footerView(viewModel.interval)
            }
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
