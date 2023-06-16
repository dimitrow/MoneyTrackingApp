//
//  AddNewIntervalView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 04.06.2023.
//

import SwiftUI

struct AddNewIntervalView<Model: AddNewIntervalViewModelType>: View {

    @ObservedObject var viewModel: Model

    var body: some View {
        VStack {
            Text("You are going to spend: \(viewModel.amount) in \(viewModel.intervalDuration) days")
//                .padding(.bottom, 10)
            Text("Or \(viewModel.dailyExpense) per day")
//                .padding(.bottom, 90)
            Text("IntervalAmount: \(viewModel.amount)")
            Text("Duration \(viewModel.intervalDuration) days")
//                .padding(.bottom, 28)
            Slider(value: viewModel.durationBinding,
                   in: 10...30,
                   step: 1)
//            .padding(.bottom, 34)
            .padding(.horizontal, 64)
            Spacer()
            KeyboardView(delegate: viewModel)
                .frame(height: 280)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
        .background(Color.eaBackground)
        .background(ignoresSafeAreaEdges: .bottom)
        .navigationTitle("Create an Interval")
        .alert(viewModel.alertTitle,
               isPresented: viewModel.showErrorAlertBinding) {
            Button("OK") {}
        } message: {
            Text(viewModel.alertMessage)
        }
        .alert("Create a new Interval",
               isPresented: viewModel.showConfirmationAlertBinding) {
            Button("OK") {
                confirmCreation()
            }
            Button("Cancel") {}
        } message: {
            Text("Is everything correct?")
        }
    }

    private func confirmCreation() {
        viewModel.confirmIntervalCreation()
    }
}

#if DEBUG
struct AddNewIntervalView_Previews: PreviewProvider {

    static let storageService = StorageService(storageManager: StorageManager.shared,
                                        storageMapper: StorageMapper())
    static let viewModel = AddNewIntervalViewModel(storageService: storageService,
                                                   router: Router())

    static var previews: some View {
        NavigationStack {
            AddNewIntervalView(viewModel: viewModel)
        }
    }
}
#endif
