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
                .padding(.bottom, 10)
            Text("Or \(viewModel.dailyLimit) per day")
                .padding(.bottom, 10)
            Text("IntervalAmount: \(viewModel.amount)")
            Spacer()
            DurationInputView(duration: viewModel.durationBinding,
                              formattedDuration: viewModel.intervalDuration)
            KeyboardView(delegate: viewModel)
                .padding(.bottom, 32)
        }
        .background(Color.eaBackground)
        .background(ignoresSafeAreaEdges: .bottom)
        .navigationTitle("Set an Interval")
        .alert(viewModel.alertTitle,
               isPresented: viewModel.showErrorAlertBinding) {
            Button("OK") {}
        } message: {
            Text(viewModel.alertMessage)
        }
        .alert("Set an Interval",
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
        Task {
            await viewModel.confirmIntervalCreation()
        }
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
