//
//  Monetary.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-23.
//

import Foundation

struct Monetary: Identifiable {
    var id = UUID()
    var numberOfPayment: Int
    var interestRate: Double
    var presentValue: Double
    var payment: Double?
    var futureValue: Double
}


enum CalculationParameter: String, CaseIterable{
    case numberOfPayment = "Number Of Payment"
    case interestRate = "Interest Rate"
    case presentValue = "Present Value"
    case futureValue = "Future Value"
    case payment = "Payment"
}


enum MonetaryType: String, CaseIterable{
    case Loan = "Loan"
    case Mortgage = "Mortgage"
    case Saving = "Saving"
    case CompoundSaving = "Compound Saving"
}

enum DepositType: String, CaseIterable{
    case Beginning
    case End
}
