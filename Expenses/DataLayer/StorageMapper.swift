//
//  StorageMapper.swift
//  Expenses
//
//  Created by Gene Dimitrow on 31.05.2023.
//

import Foundation
import CoreData
import DateHelper

protocol StorageMapperType {
    func mapIntervalEntityToModel(_ entity: IntervalEntity) -> Interval
    func mapExpenseEntityToModel(_ entity: ExpenseEntity) -> Expense
    func mapIntervalModelToEntity(_ interval: Interval) -> IntervalEntity?
    func mapExpenseModelToEntity(_ expense: Expense) -> ExpenseEntity
}

final class StorageMapper: StorageMapperType {

    func mapIntervalEntityToModel(_ entity: IntervalEntity) -> Interval {

        guard let intervalID = entity.intervalID,
              let startDate = entity.startDate,
              let endDate = entity.endDate else {

            fatalError()
        }
        let expenses = entity.expensesArray.map({mapExpenseEntityToModel($0)})
        let currentExpenses = expenses.filter({$0.timeStamp.compare(.isToday)})
        let pastExpenses = mapExpensesToDaily(expenses: expenses.filter({!$0.timeStamp.compare(.isToday)}))

        let interval = Interval(id: intervalID,
                                amount: entity.amount,
                                duration: entity.duration,
                                timeStamp: entity.timeStamp,
                                startDate: startDate,
                                endDate: endDate,
                                dailyLimit: entity.dailyLimit,
                                currentExpenses: currentExpenses,
                                pastExpenses: pastExpenses)

        return interval
    }

    private func mapExpensesToDaily(expenses: [Expense]) -> [DailyExpenses] {

        var pastExpenses: [DailyExpenses] = []

        var dateMap = [String : [Expense]]()

        for expense in expenses {

            print("> +++ EXPENSE: \(expense.amount) DATE: \(expense.timeStamp.toString(dateStyle: .medium, timeStyle: .none) ?? "no date")")
            guard let expenseDate = expense.timeStamp.toString(dateStyle: .medium, timeStyle: .none) else {
                continue
            }
            if dateMap[expenseDate] == nil {
                dateMap[expenseDate] = []
            }
            dateMap[expenseDate]?.append(expense)
        }
        for key in dateMap.keys {
            guard let timestamp = Date(detectFromString: key),
                  let expenses = dateMap[key] else {
                continue
            }

            let dailyAmount = expenses.reduce(0.0, { (result, expense) -> Double in
                result + expense.amount
            })

            let dailyExpenses = DailyExpenses(id: UUID(),
                                              timeStamp: timestamp,
                                              dailyAmount: dailyAmount,
                                              expenses: expenses)
            pastExpenses.append(dailyExpenses)
            print("> +++ EXP FOR \(timestamp) - \(dailyAmount)")
        }

        return pastExpenses.sorted(by: {$0.timeStamp > $1.timeStamp})
    }

    func mapIntervalModelToEntity(_ interval: Interval) -> IntervalEntity? {

        let fetchRequest: NSFetchRequest<IntervalEntity> = IntervalEntity.fetchRequest()
        let predicate = NSPredicate(format: "intervalID == %@", interval.id as CVarArg)
        fetchRequest.predicate = predicate
        let intervalEntity = try? IntervalEntity.context.fetch(fetchRequest).first ?? IntervalEntity(context: IntervalEntity.context)

        intervalEntity?.intervalID = interval.id
        intervalEntity?.duration = interval.duration
        intervalEntity?.amount = interval.amount
        intervalEntity?.timeStamp = interval.timeStamp
        intervalEntity?.startDate = interval.startDate
        intervalEntity?.endDate = interval.endDate
        intervalEntity?.dailyLimit = interval.dailyLimit
        interval.currentExpenses.forEach { expense in
            let expenseEntity = mapExpenseModelToEntity(expense)
            intervalEntity?.addToExpenses(expenseEntity)
        }
        return intervalEntity
    }

    func mapExpenseEntityToModel(_ entity: ExpenseEntity) -> Expense {
        guard let intervalID = entity.interval?.intervalID else {
            fatalError()
        }
        let expense = Expense(id: entity.recordID,
                              amount: entity.amount,
                              timeStamp: entity.timeStamp,
                              intervalID: intervalID)
        return expense
    }

    func mapExpenseModelToEntity(_ expense: Expense) -> ExpenseEntity {

        let fetchRequest: NSFetchRequest<IntervalEntity> = IntervalEntity.fetchRequest()
        let predicate = NSPredicate(format: "intervalID == %@", expense.intervalID as CVarArg)
        fetchRequest.predicate = predicate
        guard let intervalEntity = try? IntervalEntity.context.fetch(fetchRequest).first else {
            fatalError()
        }

        let expenseEntity = ExpenseEntity(context: ExpenseEntity.context)
        expenseEntity.amount = expense.amount
        expenseEntity.recordID = expense.id
        expenseEntity.isIncome = expense.isIncome
        expenseEntity.recordDescription = expense.description
        expenseEntity.timeStamp = expense.timeStamp
        intervalEntity.addToExpenses(expenseEntity)
        return expenseEntity
    }
}
