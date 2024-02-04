//
//  EmptyDataViewModel.swift
//  Expenses
//
//  Created by Gene Dimitrow on 31.05.2023.
//

import Foundation

protocol EmptyDataViewModelInput {
    func createBrandNew()
    func useLast()
}

protocol EmptyDataViewModelOutput {
    var hasLastUsedInterval: Bool { get set }
}

protocol EmptyDataViewModelType: EmptyDataViewModelInput, EmptyDataViewModelOutput, ObservableObject {}

class EmptyDataViewModel: EmptyDataViewModelType {

    @Published var hasLastUsedInterval: Bool = false
    private var router: Router
    private let storageService: StorageServiceType

    init(router: Router,
         storageService: StorageServiceType) {
        self.router = router
        self.storageService = storageService
        checkIfThereIsData()
    }
    
    func createBrandNew() {
        router.setInitial(scene: .newInterval)
    }

    func useLast() {

        do {
            let lastUsedInterval = try storageService.fetchLastInterval()

            let timeStamp = Date()
            guard let startDate = timeStamp.adjust(for: .startOfDay),
                  let endDate = startDate.offset(.day, value: Int(lastUsedInterval.duration - 1))?.adjust(for: .endOfDay) else {
                fatalError()
            }
            let newInterval = Interval(id: UUID(),
                                       amount: lastUsedInterval.amount,
                                       duration: lastUsedInterval.duration,
                                       timeStamp: timeStamp,
                                       startDate: startDate,
                                       endDate: endDate,
                                       dailyLimit: lastUsedInterval.dailyLimit)
            createInterval(with: newInterval)

        } catch {

        }
    }

    private func checkIfThereIsData() {
        hasLastUsedInterval = storageService.isUserHasData()
    }

    private func createInterval(with interval: Interval) {

        storageService.createInterval(interval) { [weak self] in
            guard let self = self else { return }
            self.router.setInitial(scene: .main)
        }
    }
}
