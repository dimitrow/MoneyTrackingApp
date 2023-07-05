//
//  StorageService.swift
//  Expenses
//
//  Created by Gene Dimitrow on 30.05.2023.
//

import Foundation
import CoreData
import Combine

typealias SaveCompletion = () -> Void

protocol StorageServiceType {

    var intervalUpdated: PassthroughSubject<Bool, Never> { get }
    func isUserHasData() -> Bool
    func fetchAllIntervals() -> [Interval]
    func fetchCurrentInterval() -> Interval
    func createRecord(_ expense: Expense)
    func updateRecord()
    func deleteRecord()
    func createInterval(_ interval: Interval, completion: SaveCompletion)
    func updateInterval(_ interval: Interval, completion: SaveCompletion)
    func deleteInterval(_ interval: Interval, completion: SaveCompletion)

    func mockIntervals()
}

class StorageService: StorageServiceType {

    private let storageManager: StorageManager
    private let context: NSManagedObjectContext
    private let storageMapper: StorageMapperType

    var intervalUpdated = PassthroughSubject<Bool, Never>()

    init(storageManager: StorageManager,
         storageMapper: StorageMapperType) {
        self.storageManager = storageManager
        self.context = storageManager.persistentContainer.viewContext
        self.storageMapper = storageMapper
    }

    func isUserHasData() -> Bool {

        return !(IntervalEntity.all() as [IntervalEntity]).isEmpty
    }

    func fetchAllIntervals() -> [Interval] {

//        guard let intervals: [IntervalEntity] = IntervalEntity.all() else {
//
//            return []
//        }
        return []

//        let userIntervals: [IntervalEntity] = IntervalEntity.all()
//        guard let intervals = userIntervals.map({storageMapper.mapIntervalEntityToModel($0)})
//            .sorted(by: {$0.timeStamp > $1.timeStamp}) else {
//            return []
//        }
//        return intervals
    }

    func fetchCurrentInterval() -> Interval {
        let userIntervals: [IntervalEntity] = IntervalEntity.all()
        guard let interval = userIntervals
            .map({storageMapper.mapIntervalEntityToModel($0)})
            .sorted(by: {$0.timeStamp > $1.timeStamp})
            .first else {
            fatalError()
        }
        return interval
    }

    func createRecord(_ expense: Expense) {
        _ = storageMapper.mapExpenseModelToEntity(expense)
        try? storageManager.save()
        intervalUpdated.send(true)
    }

    func updateRecord() {

    }

    func deleteRecord() {

    }

    func createInterval(_ interval: Interval, completion: SaveCompletion) {
        _ = storageMapper.mapIntervalModelToEntity(interval)
        try? storageManager.save()
        completion()
    }

    func updateInterval(_ interval: Interval, completion: SaveCompletion) {

    }

    func deleteInterval(_ interval: Interval, completion: SaveCompletion) {

    }

    func mockIntervals() {

        let calendar = Calendar.current

        let durationOne: Int16 = 25
        let timeStampOne = dateStringToDate(dateString: "2023-05-01")!
        let startDateOne = calendar.startOfDay(for: timeStampOne)
        let endDateOne = startDateOne.addingTimeInterval(3600 * 24 * Double(durationOne) - 1)

        let intervalOne = Interval(id: UUID(),
                                   amount: 3000.56,
                                   duration: durationOne,
                                   timeStamp: timeStampOne,
                                   startDate: startDateOne,
                                   endDate: endDateOne,
                                   dailyLimit: 150.0)
        _ = storageMapper.mapIntervalModelToEntity(intervalOne)

        let durationTwo: Int16 = 16
        let timeStampTwo = dateStringToDate(dateString: "2023-05-26")!
        let startDateTwo = calendar.startOfDay(for: timeStampTwo)
        let endDateTwo = startDateTwo.addingTimeInterval(3600 * 24 * Double(durationTwo) - 1)

        let intervalTwo = Interval(id: UUID(),
                                   amount: 28000.96,
                                   duration: durationTwo,
                                   timeStamp: timeStampTwo,
                                   startDate: startDateTwo,
                                   endDate: endDateTwo,
                                   dailyLimit: 1200.0)
        _ = storageMapper.mapIntervalModelToEntity(intervalTwo)

        try? storageManager.save()
    }

    func dateStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.timeZone = TimeZone(identifier: "ru-RU")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
}


