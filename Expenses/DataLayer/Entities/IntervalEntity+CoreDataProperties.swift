//
//  IntervalEntity+CoreDataProperties.swift
//  Expenses
//
//  Created by Gene Dimitrow on 31.05.2023.
//
//

import Foundation
import CoreData


extension IntervalEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IntervalEntity> {
        return NSFetchRequest<IntervalEntity>(entityName: "IntervalEntity")
    }

    @NSManaged public var intervalID: UUID?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var interval: Int16
    @NSManaged public var amount: Double
    @NSManaged public var timeStamp: Date
    @NSManaged public var expenses: NSSet?

}

// MARK: Generated accessors for expenses
extension IntervalEntity {

    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: ExpenseEntity)

    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: ExpenseEntity)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)

}

extension IntervalEntity : Identifiable {

}
