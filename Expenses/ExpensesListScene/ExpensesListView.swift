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

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                VStack(spacing: 2.0) {
                    ZStack{
                        Color.eaBackground
                            .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                        VStack(spacing: 10.0) {
                            HStack {
                                VStack {
                                    Text("Full amount: \(viewModel.currentIntervalAmount)")
                                    Text("Spent already: \(viewModel.fullExpenses)")
                                    if viewModel.isUserSaving {
                                        Text("saved: \(viewModel.saved)")
                                            .foregroundColor(.green)
                                    } else {
                                        Text("spent over: \(viewModel.saved)")
                                            .foregroundColor(.red)
                                    }
                                }
                                VStack {
                                    Text("spent today: \(viewModel.todayExpensesAmount)")
                                    Text("of: \(viewModel.dailyLimit)")
                                }
//                                ZStack {
//                                    VStack {
//                                        Color.blue
//                                            .frame(width: 4.0, height: 22)
//                                        Spacer()
//                                    }
//                                    Circle().frame(width: 16).foregroundColor(.blue)
//                                    Circle().frame(width: 8).foregroundColor(.white)
//                                }
                            }
                            .frame(height: 160)
                            ScrollView(.vertical,
                                       showsIndicators: false) {
                                VStack(spacing: 2.0) {
                                    ForEach(viewModel.pastExpenses, id: \.id) { expense in
                                        ZStack {
                                            Color.white
                                            HStack {
                                                Text("\(expense.timeStamp.toString(format: .custom("MMM d, yyyy")) ?? "")")
                                                    .frame(width: geometry.size.width / 3)
                                                    .multilineTextAlignment(.trailing)
                                                ZStack {
                                                    Color.blue.frame(width: 4.0)
                                                    Circle().frame(width: 16).foregroundColor(.blue)
                                                    Circle().frame(width: 8).foregroundColor(.white)
                                                }

                                                Text(String(format: "%.2f", expense.dailyAmount))
                                                    .multilineTextAlignment(.leading)
                                                    .foregroundColor(expense.dailyAmount > viewModel.currentInterval.dailyLimit ? Color.red : Color.green)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                            }
                                            .frame(height: 48.0)
                                            .padding(.horizontal, 16.0)
                                        }
                                        .onTapGesture {
                                            viewModel.navigateToExpenseDetails(expense)
                                        }
                                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                            Text("DELETE")
                                        }
                                    }
                                    HStack {
                                        Text("Anfang des Zeitraums")
                                            .frame(width: geometry.size.width / 3)
                                            .multilineTextAlignment(.trailing)
                                        ZStack {
                                            VStack {
                                                Color.blue
                                                    .frame(width: 4.0, height: 22)
                                                Spacer()
                                            }
                                            Circle().frame(width: 16).foregroundColor(.blue)
                                            Circle().frame(width: 8).foregroundColor(.white)
                                        }
                                        Spacer()
                                    }
                                    .frame(height: 44.0)
                                    .padding(.horizontal, 16.0)
                                }
                            }
                        }
                    }
                    .frame(height: geometry.size.height - bottomHeight)
                    ZStack{
                        Color.eaBackground
                            .cornerRadius(8, corners: [.topLeft, .topRight])
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
                                    Text("\(viewModel.amount)")
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .font(.system(size: 24,
                                                      weight: .medium))
                                        .foregroundColor(.eaKeyFontColor)
                                        .padding(.trailing, 32)
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
//        .navigationTitle("Current Expenses")
//        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(.all, edges: .bottom)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                HStack(spacing: 0) {
//                    editButton
//                    settingsButton
//                }
//            }
//        }
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
