//
//  Monetary.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-23.
//

import Foundation

struct Monetary: Identifiable {
    var id = UUID()
    let numberOfPayment: Int
    let interestRate: Double
    let presentValue: Double
    let payment: Double
    let futureValue: Double
}

//protocol MonetaryType {}

enum CalculationParameter: String, CaseIterable{
    case numberOfPayment = "Number Of Payment"
    case interestRate = "Interest Rate"
    case presentValue = "Present Value"
    case payment = "Payment"
    case futureValue = "Future Value"
}

enum LoanMonetaryType: String, CaseIterable{
    case Loan = "Loan"
    case Mortgage = "Mortgage"
}

enum SavingMonetaryType: String, CaseIterable{
    case Saving = "Saving"
    case CompoundInterestSaving = "Compound Interest Saving"
}
