//
//  StorageMapper.swift
//  Expenses
//
//  Created by Gene Dimitrow on 31.05.2023.
//

import Foundation

protocol StorageMapperType {
    func mapIntervalEntityToModel(_ entity: IntervalEntity) throws -> Interval
    func mapIntervalModelToEntity(_ interval: Interval) -> IntervalEntity
}

final class StorageMapper: StorageMapperType {

    func mapIntervalEntityToModel(_ entity: IntervalEntity) throws -> Interval {

        guard let intervalID = entity.intervalID,
              let startDate = entity.startDate,
              let endDate = entity.endDate else {

            throw DatabaseServiceError.intervalFetchError
        }
        let interval = Interval(id: intervalID,
                                amount: entity.amount,
                                duration: entity.duration,
                                timeStamp: entity.timeStamp,
                                startDate: startDate,
                                endDate: endDate)

        return interval
    }

    func mapIntervalModelToEntity(_ interval: Interval) -> IntervalEntity {

        let intervalEntity = IntervalEntity(context: IntervalEntity.context)
        intervalEntity.intervalID = interval.id
        intervalEntity.duration = interval.duration
        intervalEntity.amount = interval.amount
        intervalEntity.timeStamp = interval.timeStamp
        intervalEntity.startDate = interval.startDate
        intervalEntity.endDate = interval.endDate
        return intervalEntity
    }
}
