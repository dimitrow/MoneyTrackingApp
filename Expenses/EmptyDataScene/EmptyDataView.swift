//
//  EmptyDataView.swift
//  Expenses
//
//  Created by Gene Dimitrow on 30.05.2023.
//

import SwiftUI

struct EmptyDataView<Model: EmptyDataViewModelType>: View {

    @ObservedObject var viewModel: Model
    
    var body: some View {
        VStack {
            Text("NO DATA")
            Button {
                viewModel.createBrandNew()
            } label: {
                Text("Add new Interval")
                    .padding()
            }
            if viewModel.hasLastUsedInterval {
                Button {
                    viewModel.useLast()
                } label: {
                    Text("Use Last")
                        .padding()
                }
            }
        }
    }
}

//struct EmptyDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            EmptyDataView(viewModel: EmptyDataViewModel(router: Router()))
//        }
//    }
//}
