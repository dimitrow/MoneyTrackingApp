//
//  ExpensesListView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 20.11.2022.
//

import SwiftUI

struct ExpensesListView<Model: ExpenseListViewModelType>: View {

    @ObservedObject var viewModel: Model

    var body: some View {
        VStack(spacing: 0.0) {
            ZStack{
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.bottom)
                    .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                VStack(spacing: 0.0) {
                    Color.white
                        .frame(height: 160)
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(viewModel.expenses, id: \.id) { expense in
                            ExpenseView(amount: expense.amount)
                        }
                    }
                }
            }
            ZStack{
                Color.white
                    .cornerRadius(8, corners: [.topLeft, .topRight])
                    .padding(.top, 2)
                Button {

                } label: {
                    Text("Add new")
                        .padding()
                }
            }
            .frame(height: 78)
        }
        .navigationTitle("Expenses")
        .background(.black)
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct ExpensesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ExpensesListView(viewModel: ExpenseListViewModel())
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
