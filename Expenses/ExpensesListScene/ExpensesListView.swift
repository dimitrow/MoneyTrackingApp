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
    @State var isHandleActive: Bool = false
    @State var keyboardOpacity: Double = 0.0

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
        isHandleActive ? Image.keyboardHandleActive : Image.keyboardHandle
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
//                                SummaryInfoView(viewModel: viewModel)
                                summaryView()
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
                                                handleDragGestureChange(value.translation.height)
                                            }
                                            .onEnded { _ in
                                                handleDragGestureEnd()
                                            }
                                    )
                                    .onTapGesture {
                                        handleExpandOnTap()
//                                        withAnimation{
//                                            bottomHeight = bottomHeightMax
//                                            bottomSheetOpacity = 1.0
//                                        }
                                    }
                                Spacer()
                                VStack(spacing: basicVSpacing) {
                                    inputView
                                    KeyboardView(delegate: viewModel)
                                        .padding(.bottom, 20)
                                }
                                .opacity(keyboardOpacity)
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
            isHandleActive = true
        }
        if bottomHeight > bottomHeightMin * 1.3 {
            keyboardOpacity = (bottomHeight - bottomHeightMin * 1.3) / bottomHeightMax
            print(keyboardOpacity)
        } else {
            keyboardOpacity = 0.0
        }
        if bottomHeight > bottomHeightMax * 1.05 {
            bottomHeight = bottomHeightMax * 1.05
        }
    }

    private func handleDragGestureEnd() {
        withAnimation(.spring(response: 0.15, dampingFraction: 0.99)) {
            isHandleActive = false
            bottomHeight = bottomHeight > bottomHeightMax * 0.6 ? bottomHeightMax : bottomHeightMin
            keyboardOpacity = bottomHeight > bottomHeightMax * 0.6 ? 1.0 : 0.0
        }
    }

    private func handleExpandOnTap() {
        isHandleActive = true
        withAnimation(.spring(response: 0.15, dampingFraction: 0.99)) {
            bottomHeight = bottomHeight == bottomHeightMax ? bottomHeightMin : bottomHeightMax
            keyboardOpacity = bottomHeight > bottomHeightMax * 0.75 ? 1.0 : 0.0
            isHandleActive = false
        }
    }

    //MARK: - view builders

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
                Text("\(expense.timeStamp.toString(format: .custom(dateFormat)) ?? "")")
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
            Text("\(interval.startDate.toString(format: .custom(dateFormat)) ?? "")")
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
