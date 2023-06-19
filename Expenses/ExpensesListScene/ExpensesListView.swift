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
                            .edgesIgnoringSafeArea(.bottom)
                            .cornerRadius(8, corners: [.bottomLeft, .bottomRight])

                        //                    VStack(spacing: 0.0) {
                        //                        Text("Present data")
                        //                        Text("spent today: \(viewModel.amount)")
                        //                        Button {
                        //                            viewModel.fetchIntervals()
                        //                        } label: {
                        //                            Text("fetch")
                        //                                .padding()
                        //                        }
                        //                    }

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
                                    print(geometry.size.height - bottomHeight, geometry.size.height)
                                }
                            } label: {
                                Text(bottomHeight == bottomHeightMax ? "Hide" : "Add new")
                            }
                            .padding(.top, 10)
                            VStack(spacing: 0.0) {
                                HStack(spacing: 0.0) {
//                                    Spacer()
                                    Text("\(viewModel.amount)")
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .font(.system(size: 54.0,
                                                      weight: .medium))
                                        .foregroundColor(.eaKeyFontColor)
                                        .padding(.trailing, 32)
                                }
//                                KeyboardView(delegate: viewModel)
//                                    .padding(.bottom, 19)
//                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Current Expenses")
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(.all, edges: [.bottom, .top])
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
