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
                viewModel.routeFurther()
            } label: {
                Text("Add new Interval")
                    .padding()
            }
        }
    }
}

struct EmptyDataView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyDataView(viewModel: EmptyDataViewModel(router: Router()))
    }
}
