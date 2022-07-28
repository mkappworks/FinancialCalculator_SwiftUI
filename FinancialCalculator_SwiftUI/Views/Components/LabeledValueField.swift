//
//  LabeledValueFieldView.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-27.
//

import SwiftUI

struct LabeledValueField<T>: View {
    var fieldTitle: String
    @Binding var value: T
    var isDecimalPadEnabled: Bool
    @Binding var calculationParameter: CalculationParameter
    
    let decimalFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
        HStack(spacing: 20){
            Text(fieldTitle)
                .frame(width: 175, alignment: .leading)
            TextField(fieldTitle,value: $value,
                      formatter: isDecimalPadEnabled ?
                decimalFormatter : NumberFormatter())
            .keyboardType(
                isDecimalPadEnabled == true ?
                    .decimalPad : .numberPad)
            .disabled(calculationParameter.rawValue == fieldTitle ? true : false)
            .foregroundColor(calculationParameter.rawValue == fieldTitle ? .gray : .black)
        }
        
    }
}
