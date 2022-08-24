//
//  MonetaryEntity+CoreDataProperties.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-28.
//
//

import Foundation
import CoreData


extension MonetaryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MonetaryEntity> {
        return NSFetchRequest<MonetaryEntity>(entityName: "MonetaryEntity")
    }

    @NSManaged public var futureValue: Double
    @NSManaged public var id: UUID
    @NSManaged public var interestRate: Double
    @NSManaged public var monetaryType: String
    @NSManaged public var numberOfPayment: Int64
    @NSManaged public var payment: Double
    @NSManaged public var presentValue: Double

}

extension MonetaryEntity : Identifiable {

}
