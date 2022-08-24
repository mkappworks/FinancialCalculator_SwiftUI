//
//  HomeView.swift
//  FinancialCalculator_SwiftUI
//
//  Created by Malith Kuruppu on 2022-07-19.
//

import SwiftUI


struct HomeView: View {

    @StateObject private var calculationViewModel = CalculationViewModel()
    @StateObject private var coreDataViewModel = CoreDataViewModel()
    
    var body: some View {
        ZStack {
            NavigationView{
                    Form{

                        Section("Select Monetary Type"){
                            Picker("Monetary Type", selection: $calculationViewModel.monetaryType) {
                                ForEach(MonetaryType.allCases, id: \.self) {
                                    Text($0.rawValue)
                                    .font(.system(size: 20))

                                }

                            }
                            .onChange(of: calculationViewModel.monetaryType, perform: { value in
                                calculationViewModel.checkIfPaymentAvailable()
                                if (value == MonetaryType.CompoundSaving && calculationViewModel.calculationParameter == CalculationParameter.payment){
                                    calculationViewModel.calculationParameter = CalculationParameter.futureValue
                                }
                            })
                            .frame(height: 50)
                            .pickerStyle(.wheel)
                            
                        }
                        
                        Section("Select Calculation Parameter"){
                            Picker("Calculation Parameter", selection: $calculationViewModel.calculationParameter) {ForEach(CalculationParameter.allCases, id: \.self) {
                                if(calculationViewModel.monetaryType != MonetaryType.CompoundSaving || $0 != CalculationParameter.payment){
                                    Text($0.rawValue)
                                        .font(.system(size: 20))
                                }
                            }
                            .onChange(of: calculationViewModel.calculationParameter, perform: { value in
                                calculationViewModel.checkIfPaymentAvailable()
                                })

                                
                            }
                            .frame(height: 50)
                            .pickerStyle(.wheel)
                            
                        }
                        
                        CalculationParameterView(calculationParameter: $calculationViewModel.calculationParameter, monetaryType: $calculationViewModel.monetaryType,
                            monetary: $calculationViewModel.monetary,
                            isPaymentAvailable: $calculationViewModel.isPaymentAvailable
                        )
                        
                        if(calculationViewModel.isPaymentAvailable){
                            Section("Select When Deposits are Made") {
                                Toggle("\(calculationViewModel.depositType.rawValue)", isOn: $calculationViewModel.isDepositMadeInEnd)
                                    .toggleStyle(SwitchToggleStyle(tint: .red))
                                    .onChange(of: calculationViewModel.isDepositMadeInEnd) { value in
                                        calculationViewModel.depositType =  value == true ? DepositType.End : DepositType.Beginning
                                    }
                                
                            }
                        }
                        
                        Button("Calculate"){
                            calculationViewModel.calculateParameter()
                            
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    
                        
                    }
                    .navigationTitle(calculationViewModel.monetaryType.rawValue)
                    .onTapGesture{hideKeyboard()}
                    .toolbar{
                        ToolbarItemGroup(placement: .navigationBarTrailing){
                            Button{
                                coreDataViewModel.addMonetaryData(monetary: calculationViewModel.monetary, monetaryType: calculationViewModel.monetaryType)
                            }label: {
                                Text("Save")
                            }
                            
                            Button{
                                calculationViewModel.resetCalculationParameter()
                            }label: {
                                Text("Reset")
                            }
                        }
                        
                        
                    }
                    
                .accentColor(.red)
                
            }
   
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
