//
//  ExpensesListView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 20.11.2022.
//

import SwiftUI

struct ExpensesListView<Model: ExpenseListViewModelType>: View {

    @ObservedObject var viewModel: Model

    @State var bottomHeight: CGFloat = 88.0

    var body: some View {
        VStack(spacing: 0.0) {
            ZStack{
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.bottom)
                    .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                VStack(spacing: 0.0) {
                    Color.white
                        .frame(height: 160)

                    if let _ = viewModel.currentInterval {
                        Text("Present some data")
//                        ScrollView(.vertical, showsIndicators: false) {
//                            ForEach(viewModel.expenses, id: \.id) { expense in
//                                ExpenseView(amount: expense.amount)
//                            }
//                        }
                    } else {
                        EmptyDataView()
//                        Text("Ask to create interval")
                    }
                }
            }
            ZStack{
                Color.white
                    .cornerRadius(8, corners: [.topLeft, .topRight])
                    .padding(.top, 2)
                Button {
                    withAnimation {
                        bottomHeight = 320
                    }
                } label: {
                    Text("Add new")
                        .padding()
                }
                Spacer()
            }
            .frame(height: bottomHeight)
        }
        .navigationTitle("Current Expenses")
        .background(.black)
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct ExpensesListView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationStack {
            ExpensesListView(viewModel: ExpenseListViewModel(storageService: StorageService()))
        }
    }
}

struct ExpenseView: View {

    var amount: String
    var body: some View {
        Text(amount)
            .padding(12.0)
    }
}
