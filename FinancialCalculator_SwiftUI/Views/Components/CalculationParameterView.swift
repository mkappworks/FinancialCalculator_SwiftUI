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
    
//    @Binding var numberOfPayment: Int
//    @Binding var interestRate: Double
//    @Binding var presentValue: Double
//    @Binding var payment: Double
//    @Binding var futureValue: Double
    
    @ViewBuilder
    var body: some View {
        Section{
            LabeledValueField(fieldTitle: "\(CalculationParameter.numberOfPayment.rawValue)", value: $monetary.numberOfPayment, isDecimalPadEnabled: false, calculationParameter: $calculationParameter)
            
            LabeledValueField(fieldTitle: "\(CalculationParameter.interestRate.rawValue)", value: $monetary.interestRate, isDecimalPadEnabled: true, calculationParameter: $calculationParameter)
            
            LabeledValueField(fieldTitle: "\(CalculationParameter.presentValue.rawValue)", value: $monetary.presentValue, isDecimalPadEnabled: true, calculationParameter: $calculationParameter)
            
            LabeledValueField(fieldTitle: "\(CalculationParameter.futureValue.rawValue)", value: $monetary.futureValue, isDecimalPadEnabled: true, calculationParameter:
                $calculationParameter)
            
            if(monetaryType != MonetaryType.CompoundSaving){
                LabeledValueField(fieldTitle: "\(CalculationParameter.payment.rawValue)", value: $monetary.payment, isDecimalPadEnabled: true, calculationParameter: $calculationParameter)
            }
            
        }
    }
}
