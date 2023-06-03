//
//  EmptyDataViewModel.swift
//  Expenses
//
//  Created by Gene Dimitrow on 31.05.2023.
//

import Foundation

protocol EmptyDataViewModelInput {
    func routeFurther()
}

protocol EmptyDataViewModelOutput {

}

protocol EmptyDataViewModelType: EmptyDataViewModelInput, EmptyDataViewModelOutput, ObservableObject {}

class EmptyDataViewModel: EmptyDataViewModelType {

    private var router: Router

    init(router: Router) {
        self.router = router
    }
    
    func routeFurther() {
        router.setInitial()
    }
}
