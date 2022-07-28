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
    var fieldUnit: String
    
    let decimalFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
        HStack{
            Text(fieldTitle)
                .frame(width: 120, alignment: .leading)
            Text(fieldUnit)
                .frame(width: 80, alignment: .leading)
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
