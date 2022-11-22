//
//  ExpensesListView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 20.11.2022.
//

import SwiftUI

struct ExpensesListView: View {

    @StateObject var viewModel: ExpenseListViewModel = ExpenseListViewModel()
    @FocusState var isInputActive: Bool

    var body: some View {
        VStack {
            Color.blue
                .frame(height: 80)
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.expenses, id: \.id) { expense in
                    ExpenseView(amount: expense.amount)
                }
            }
            ZStack{
                Color.blue
                Color.red
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.red,
                                    lineWidth: 4.0)
                    )
                    .cornerRadius(10)
                    .padding(.top, 4)
                VStack{
                    Button {

                    } label: {
                        Text("Add new")
                            .padding()
                    }
                }
            }
            .frame(height: 78)
        }
        .ignoresSafeArea(.all,
                         edges: .bottom)
    }
}

struct ExpensesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListView(viewModel: ExpenseListViewModel())
    }
}

struct ExpenseView: View {

    var amount: String
    var body: some View {
        Text(amount)
            .padding(12.0)
    }
}
