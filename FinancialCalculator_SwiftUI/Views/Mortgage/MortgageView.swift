//
//  MortgageView.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-22.
//

import SwiftUI


struct MortgageView: View {
    @State private var numberOfPayment: Int = 1
    @State private var interestRate: Double = 0.0
    @State private var presentValue: Double = 0.0
    @State private var payment: Double = 0.0
    @State private var futureValue: Double = 0.0
    @State private var monetaryType: LoanMonetaryType = LoanMonetaryType.Mortgage
    
    @State private var isMortgage: Bool = true
    @State private var calculationParameter: CalculationParameter = CalculationParameter.numberOfPayment
    
    // @State private var monetary: Monetary
    
    var body: some View {
        NavigationView{
            Form{
                Section("Select Mortgage/Loan") {
                    
                    HStack {
                        Toggle("\(monetaryType.rawValue)", isOn: $isMortgage)
                            .toggleStyle(SwitchToggleStyle(tint: .red))
                            .onChange(of: isMortgage) { value in
                                monetaryType =  value == true ? LoanMonetaryType.Mortgage : LoanMonetaryType.Loan
                            }
                    }
                    .frame(height: 40)
                }
                
                Section("Select Calculation Parameter"){
                        Picker("Calculation Parameter", selection: $calculationParameter) {ForEach(CalculationParameter.allCases, id: \.self) {
                            Text($0.rawValue)
                                .font(.system(size: 20))
                            
                        }
                            
                        }
                        .frame(height: 50)
                        .pickerStyle(.wheel)

                }

                Section{
                    LabeledValueField(fieldTitle: "\(CalculationParameter.numberOfPayment.rawValue)", value: $numberOfPayment, isDecimalPadEnabled: false, calulationParameter: $calculationParameter)
                    
                    LabeledValueField(fieldTitle: "\(CalculationParameter.interestRate.rawValue)", value: $interestRate, isDecimalPadEnabled: true, calulationParameter: $calculationParameter)
                    
                    LabeledValueField(fieldTitle: "\(CalculationParameter.presentValue.rawValue)", value: $presentValue, isDecimalPadEnabled: true, calulationParameter: $calculationParameter)
                    
                    LabeledValueField(fieldTitle: "\(CalculationParameter.payment.rawValue)", value: $payment, isDecimalPadEnabled: true,
                        calulationParameter:
                        $calculationParameter)
                    
                    LabeledValueField(fieldTitle: "\(CalculationParameter.futureValue.rawValue)", value: $futureValue, isDecimalPadEnabled: true,
                        calulationParameter:
                        $calculationParameter)
                    
                }
                
            }
            .navigationTitle("Mortgage")
            .onTapGesture{hideKeyboard()}
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button{
                        print("Save Tapped")
                    }label: {
                        Label("Save", systemImage: "square.and.arrow.down")
                    }
                    
                    Button{
                        print("Clear Tapped")
                    }label: {
                        Text("Clear")
                    }
                }
            }
            .accentColor(.red)
        }
    }
}


#if canImport(UIKit)
extension View{
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct MortgageView_Previews: PreviewProvider {
    static var previews: some View {
        MortgageView()
    }
}

struct LabeledValueField<T: Numeric>: View {
    var fieldTitle: String
    @Binding var value: T
    var isDecimalPadEnabled: Bool
//    var isDisabled: Bool
    @Binding var calulationParameter: CalculationParameter
    
    var body: some View {
        HStack(spacing: 20){
        Text(fieldTitle)
            .frame(width: 175, alignment: .leading)
            TextField(fieldTitle,value: $value, formatter:
                        NumberFormatter())
            .keyboardType(
                isDecimalPadEnabled == true ?
                .decimalPad : .numberPad)
            .disabled(calulationParameter.rawValue == fieldTitle ? true : false)
            .foregroundColor(calulationParameter.rawValue == fieldTitle ? .gray : .black)
        }
        
    }
}
