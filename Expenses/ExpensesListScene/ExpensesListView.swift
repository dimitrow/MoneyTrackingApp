//
//  ExpensesListView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 20.11.2022.
//

import SwiftUI

private let bottomHeightMin: CGFloat = 64.0
private let bottomHeightMax: CGFloat = 360.0
private let basicVSpacing: CGFloat = 0.0

private let mainTilesCornerRadius: CGFloat = 12.0
private let mainTilesVSpacing: CGFloat = 2.0

private let summaryInfoCornerRadius: CGFloat = 16.0
private let summaryInfoFrameHeight: CGFloat = 160.0

//private let controlBorderWidth: CGFloat = 2.0

struct ExpensesListView<ViewModel: ExpensesListViewModelType>: View {

    @ObservedObject var viewModel: ViewModel

    @State var bottomHeight: CGFloat = bottomHeightMin
    @State var isKeyboardDragging: Bool = false
    @State var bottomSheetOpacity: Double = 0.0

//    var settingsButton: some View {
//        Button(action: {
//
//        }) {
//            Image(systemName: "gearshape")
//        }
//    }
//
//    var editButton: some View {
//        Button(action: {
//
//        }) {
//            Image(systemName: "pencil.circle")
//        }
//    }

    var sceneBackground: some View {
        Color.black
    }

    var keybordHandle: some View {
        isKeyboardDragging ? Image.keyboardHandleActive : Image.keyboardHandle
    }

    var inputView: some View {
        HStack(spacing: 0.0) {
            Spacer()
            Text("\(viewModel.amount)")
                .frame(height: 60)
                .font(.system(size: 64,
                              weight: .medium))
                .foregroundColor(.eaPrimaryText)
                .padding(.trailing, 32)
                .padding(.bottom, 12)
        }
    }

    var body: some View {
        GeometryReader { geometry in
            let sceneHeight = geometry.size.height
            if sceneHeight > 0 {
                ZStack {
                    sceneBackground
                    VStack(spacing: mainTilesVSpacing) {
                        ZStack{
                            Color.eaBackground
                            VStack(spacing: basicVSpacing) {
                                SummaryInfoView(viewModel: viewModel)
//                                summaryInfoView(for: viewModel)
                                expensesList(for: viewModel)
                            }
                        }
                        .cornerRadius(mainTilesCornerRadius, corners: [.bottomLeft, .bottomRight])
                        .frame(height: sceneHeight - bottomHeight)
                        ZStack{
                            Color.eaBackground
                            VStack(spacing: basicVSpacing) {
                                keybordHandle
                                    .padding(.top, 10)
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                print(abs(value.velocity.height))
                                                handleDragGestureChange(value.translation.height)
                                            }
                                            .onEnded { _ in
                                                handleDragGestureEnd()
                                            }
                                    )
                                    .onTapGesture {
                                        bottomHeight = bottomHeightMax
                                        bottomSheetOpacity = 1.0
                                    }
                                Spacer()
                                VStack(spacing: basicVSpacing) {
                                    inputView
                                    KeyboardView(delegate: viewModel)
                                        .padding(.bottom, 20)
                                }
                                .opacity(bottomSheetOpacity)
                                Spacer()
                            }
                        }
                        .cornerRadius(mainTilesCornerRadius, corners: [.topLeft, .topRight])
                    }
                }
                .background(Color.eaBackground)
            }
        }
        .onAppear {
            viewModel.updateData()
        }
        .navigationTitle("Current Expenses")
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(.all, edges: .bottom)
    }

    private func handleDragGestureChange(_ translation: CGFloat) {
        bottomHeight = bottomHeight - translation
        withAnimation{
            isKeyboardDragging = true
        }
        if bottomHeight > bottomHeightMin * 1.5 {
            bottomSheetOpacity = bottomHeight / bottomHeightMax
        } else {
            bottomSheetOpacity = 0.0
        }
        if bottomHeight > bottomHeightMax * 1.1 {
            bottomHeight = bottomHeightMax * 1.1
        }
    }

    private func handleDragGestureEnd() {
        withAnimation(.spring(response: 0.15, dampingFraction: 0.99)) {
            isKeyboardDragging = false
            if bottomHeight > bottomHeightMax * 0.75 {
                bottomHeight = bottomHeightMax
                bottomSheetOpacity = 1.0
            } else {
                bottomHeight = bottomHeightMin
                bottomSheetOpacity = 0.0
            }
        }
    }

    //MARK: - view builders

//    @ViewBuilder
//    func summaryInfoView(for model: Model) -> some View {
//        ZStack {
//            Color.eaMainBlue.opacity(0.1)
//            HStack(alignment: .center, spacing: 8.0) {
//                VStack(spacing: 0.0) {
//                    Spacer()
//                    ZStack {
//                        ProgressView(progress: model.spendingProgressBinding)
//                        VStack {
//                            Text(model.spentInTotal)
//                                .font(.system(size: 16, weight: .semibold))
//                            Text("of")
//                                .font(.system(size: 12, weight: .regular))
//                            Text(model.intervalAmount)
//                                .font(.system(size: 14, weight: .medium))
//                        }
//                    }
//                    Color.eaMainBlue
//                        .frame(width: 4.0, height: 8)
//                }
//                .frame(width: 128)
//                .padding(.leading, 32)
//                VStack(alignment: .trailing) {
//                    HStack {
//                        Text("You have:")
//                            .foregroundColor(.eaPrimaryText)
//                            .font(.system(size: 16, weight: .semibold))
//                        Spacer()
//                    }
//                    Text("\(model.leftover)")
//                        .foregroundColor(.eaPrimaryText)
//                        .font(.system(size: 30, weight: .bold))
//                        .minimumScaleFactor(0.4)
//                    Text("bis \(model.interval.endDate.toString(format: .custom("MMM d, yyyy")) ?? "")")
//                        .font(.system(size: 14, weight: .regular))
//                    if model.isUserSaving {
//                        Text("saved: \(model.saved)")
//                            .foregroundColor(.green)
//                            .font(.system(size: 18, weight: .medium))
//                            .minimumScaleFactor(0.4)
//                    } else {
//                        Text("spent over: \(model.saved)")
//                            .foregroundColor(.red)
//                            .font(.system(size: 16, weight: .medium))
//                            .minimumScaleFactor(0.4)
//                    }
//                    Text("spent today: \(model.spentToday)")
//                        .foregroundColor(.eaPrimaryText)
//                        .font(.system(size: 16, weight: .semibold))
//                        .minimumScaleFactor(0.4)
//                    Text("of: \(model.dailyLimit)")
//                        .foregroundColor(.eaPrimaryText)
//                        .font(.system(size: 12, weight: .regular))
//                }
//                .padding(.trailing, 16)
//            }
//        }
//        .clipShape(
//            RoundedRectangle(cornerRadius: summaryInfoCornerRadius)
//        )
//        .frame(height: summaryInfoFrameHeight)
//        .padding(.horizontal, 16)
//    }

    @ViewBuilder
    func expensesList(for model: ViewModel) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 2.0) {
                ForEach(model.pastExpenses, id: \.id) { expense in
                    dailyExpensesView(expense, of: model.interval)
                    .onTapGesture {
                        model.navigateToExpenseDetails(expense)
                    }
                }
                footerView(model.interval)
            }
        }
    }

    @ViewBuilder
    func dailyExpensesView(_ expense: DailyExpenses, of interval: Interval) -> some View {
        ZStack {
            Color.eaBackground
            HStack(spacing: 4.0) {
                Text("\(expense.timeStamp.toString(format: .custom("MMM d, yyyy")) ?? "")")
                    .foregroundColor(.eaPrimaryText)
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
                        .foregroundColor(expense.dailyAmount > interval.dailyLimit ? Color.red : Color.green)
                }
                Text(String(format: "%.2f", expense.dailyAmount))
                    .foregroundColor(expense.dailyAmount > interval.dailyLimit ? Color.red : Color.green)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.eaPrimaryText)
            }
            .frame(height: 48.0)
            .padding(.horizontal, 16.0)
        }
    }

    @ViewBuilder
    func footerView(_ interval: Interval) -> some View {
        HStack(spacing: 4.0) {
            Text("\(interval.startDate.toString(format: .custom("MMM d, yyyy")) ?? "")")
                .foregroundColor(.eaPrimaryText)
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
                .foregroundColor(.eaPrimaryText)
                .font(.system(size: 12,
                              weight: .medium))
            Spacer()
        }
        .frame(height: 44.0)
        .padding(.horizontal, 16.0)
    }
}

//struct ExpensesListView_Previews: PreviewProvider {
//
//    static let storageService = StorageService(storageManager: StorageManager.shared,
//                                        storageMapper: StorageMapper())
//    static let viewModel = ExpensesListViewModel(storageService: storageService,
//                                                 router: Router())
//    static var previews: some View {
//        NavigationStack {
//            ExpensesListView(viewModel: viewModel)
//        }
//    }
//}
