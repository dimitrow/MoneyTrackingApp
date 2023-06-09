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
            Text("IntervalAmount: \(viewModel.amount)")
                .padding(.bottom, 128)
            Text("Duration \(viewModel.intervalDuration) days")
                .padding(.bottom, 28)
            Slider(value: viewModel.durationBinding,
                   in: 10...30,
                   step: 1)
            .padding(.bottom, 64)
            .padding(.horizontal, 64)
            KeyboardView(delegate: viewModel)
        }
        .background(Color.eaBackground)
        .navigationTitle("Create an Interval")
    }
}

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
