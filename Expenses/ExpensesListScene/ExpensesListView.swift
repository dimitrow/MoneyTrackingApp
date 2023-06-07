//
//  ExpensesListView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 20.11.2022.
//

import SwiftUI

struct ExpensesListView<Model: ExpensesListViewModelType>: View {

    @ObservedObject var viewModel: Model

    @State var bottomHeight: CGFloat = 88.0
    @State var isInputMinimized: Bool = true

    var body: some View {
        VStack(spacing: 0.0) {
            ZStack{
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.bottom)
                    .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                VStack(spacing: 0.0) {
                    Color.white
                        .frame(height: 160)
                    Text("Present data")
                    Button {
                        viewModel.fetchIntervals()
                    } label: {
                        Text("fetch")
                            .padding()
                    }
                }
            }
            ZStack{
                Color.white
                    .cornerRadius(8, corners: [.topLeft, .topRight])
                    .padding(.top, 2)
                Button {
                    withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7)) {
                        isInputMinimized.toggle()
                        bottomHeight = isInputMinimized ? 88 : 320
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
