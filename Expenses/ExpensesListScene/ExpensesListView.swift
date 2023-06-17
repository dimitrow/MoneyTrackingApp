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
        VStack(spacing: 0.0) {
            ZStack{
                Color.eaBackground
                    .edgesIgnoringSafeArea(.bottom)
                    .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                VStack(spacing: 0.0) {
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
                Color.eaBackground
                    .cornerRadius(8, corners: [.topLeft, .topRight])
                    .padding(.top, 2)
                VStack {
                    Button {
                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7)) {
                            isInputMinimized.toggle()
                            bottomHeight = isInputMinimized ? 88 : 320
                        }
                    } label: {
                        Text("Add new")
                            .padding()
                    }
                    .padding(.top, 4)
                    Spacer()
                }
            }
            .frame(height: bottomHeight)
        }
        .navigationTitle("Current Expenses")
        .background(.black)
        .ignoresSafeArea(.all, edges: .all)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 0) {
                    editButton
                    settingsButton
                }
            }
        }
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
