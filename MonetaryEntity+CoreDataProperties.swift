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

    @NSManaged public var monetaryType: String?
    @NSManaged public var id: UUID?
    @NSManaged public var presentValue: Double
    @NSManaged public var futureValue: Double
    @NSManaged public var payment: Double
    @NSManaged public var numberOfPayment: Int16
    @NSManaged public var interestRate: Double

}

extension MonetaryEntity : Identifiable {

}
