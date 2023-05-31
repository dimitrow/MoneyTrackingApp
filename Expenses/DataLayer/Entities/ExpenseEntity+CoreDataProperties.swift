//
//  ExpenseEntity+CoreDataProperties.swift
//  Expenses
//
//  Created by Gene Dimitrow on 31.05.2023.
//
//

import Foundation
import CoreData


extension ExpenseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseEntity> {
        return NSFetchRequest<ExpenseEntity>(entityName: "ExpenseEntity")
    }

    @NSManaged public var timeStamp: Date
    @NSManaged public var amount: Double
    @NSManaged public var isIncome: Bool
    @NSManaged public var recordID: UUID
    @NSManaged public var recordDescription: String?
    @NSManaged public var interval: IntervalEntity?

}

extension ExpenseEntity : Identifiable {

}
