//
//  CalculationParameterView.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-27.
//

import SwiftUI

struct CalculationParameterView: View {
    @Binding var calculationParameter: CalculationParameter
    @Binding var monetaryType: MonetaryType
    @Binding var monetary: Monetary
    @Binding var isPaymentAvailable: Bool
    
    @ViewBuilder
    var body: some View {
        Section{
            LabeledValueField(fieldTitle: "\(CalculationParameter.numberOfPayment.rawValue)", value: $monetary.numberOfPayment, isDecimalPadEnabled: false, calculationParameter: $calculationParameter, fieldUnit:  monetaryType != MonetaryType.Mortgage ? "(months)" : "(years)" )
            
            LabeledValueField(fieldTitle: "\(CalculationParameter.interestRate.rawValue)", value: $monetary.interestRate, isDecimalPadEnabled: true, calculationParameter: $calculationParameter, fieldUnit: "(%)")
            
            LabeledValueField(fieldTitle: "\(CalculationParameter.presentValue.rawValue)", value: $monetary.presentValue, isDecimalPadEnabled: true, calculationParameter: $calculationParameter, fieldUnit: "(LKR)")
            
            LabeledValueField(fieldTitle: "\(CalculationParameter.futureValue.rawValue)", value: $monetary.futureValue, isDecimalPadEnabled: true, calculationParameter:
                                $calculationParameter, fieldUnit: "(LKR)")
            
            if(isPaymentAvailable){
                LabeledValueField(fieldTitle: "\(CalculationParameter.payment.rawValue)", value: $monetary.payment, isDecimalPadEnabled: true, calculationParameter: $calculationParameter, fieldUnit: "(LKR)")
            }
            
        }
    }
}
