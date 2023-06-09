//
//  StorageMapper.swift
//  Expenses
//
//  Created by Gene Dimitrow on 31.05.2023.
//

import Foundation

protocol StorageMapperType {
    func mapIntervalEntityToModel()
    func mapIntervalModelToEntity(_ interval: Interval) -> IntervalEntity
}

final class StorageMapper: StorageMapperType {

    func mapIntervalEntityToModel() {}

    func mapIntervalModelToEntity(_ interval: Interval) -> IntervalEntity {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: interval.timeStamp)
        let endDate = startDate.addingTimeInterval(3600 * 24 * Double(interval.duration + 1))

        let intervalEntity = IntervalEntity(context: IntervalEntity.context)
        intervalEntity.intervalID = interval.id
        intervalEntity.duration = interval.duration
        intervalEntity.amount = interval.amount
        intervalEntity.timeStamp = interval.timeStamp
        intervalEntity.startDate = startDate
        intervalEntity.endDate = endDate
        return intervalEntity
    }
}
